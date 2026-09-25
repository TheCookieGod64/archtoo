/* SPDX-License-Identifier: GPL-3.0-or-later */
#define _POSIX_C_SOURCE 200809L

#include <ctype.h>
#include <errno.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "../headers/aur_rpc.h"

static void set_error(char *error, size_t size, const char *message) {
    size_t length;
    if (!error || size == 0) return;
    if (!message) message = "unknown error";
    length = strlen(message);
    if (length >= size) length = size - 1;
    memcpy(error, message, length);
    error[length] = '\0';
}

static int append_bytes(char **buffer, size_t *length, size_t *capacity,
                        const char *bytes, size_t count) {
    if (*length + count + 1 > *capacity) {
        size_t next = *capacity ? *capacity : 8192;
        while (next < *length + count + 1) next *= 2;
        char *grown = realloc(*buffer, next);
        if (!grown) return 0;
        *buffer = grown; *capacity = next;
    }
    memcpy(*buffer + *length, bytes, count);
    *length += count; (*buffer)[*length] = '\0';
    return 1;
}

static int curl_get(const char *url, char **body, char *error, size_t error_size) {
    int pipefd[2], status;
    pid_t pid;
    char chunk[8192];
    size_t length = 0, capacity = 0;
    ssize_t n;

    *body = NULL;
    if (pipe(pipefd) != 0) { set_error(error, error_size, strerror(errno)); return 0; }
    pid = fork();
    if (pid < 0) { close(pipefd[0]); close(pipefd[1]); set_error(error,error_size,strerror(errno)); return 0; }
    if (pid == 0) {
        close(pipefd[0]);
        if (dup2(pipefd[1], STDOUT_FILENO) < 0) _exit(127);
        close(pipefd[1]);
        execlp("curl", "curl", "--fail", "--silent", "--show-error",
               "--location", "--connect-timeout", "15", "--max-time", "60",
               url, (char *)NULL);
        _exit(127);
    }
    close(pipefd[1]);
    while ((n = read(pipefd[0], chunk, sizeof(chunk))) > 0) {
        if (!append_bytes(body, &length, &capacity, chunk, (size_t)n)) {
            close(pipefd[0]); kill(pid, SIGTERM); waitpid(pid, NULL, 0);
            free(*body); *body = NULL; set_error(error,error_size,"out of memory"); return 0;
        }
    }
    close(pipefd[0]);
    while (waitpid(pid, &status, 0) < 0 && errno == EINTR) {}
    if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
        free(*body); *body = NULL; set_error(error,error_size,"AUR RPC HTTP request failed"); return 0;
    }
    if (!*body) *body = strdup("");
    return *body != NULL;
}

static char *url_encode(const char *text) {
    static const char hex[] = "0123456789ABCDEF";
    size_t n = strlen(text), used = 0;
    char *out = malloc(n * 3 + 1);
    if (!out) return NULL;
    for (size_t i = 0; i < n; i++) {
        unsigned char c = (unsigned char)text[i];
        if (isalnum(c) || c == '-' || c == '_' || c == '.' || c == '~') out[used++] = (char)c;
        else { out[used++] = '%'; out[used++] = hex[c >> 4]; out[used++] = hex[c & 15]; }
    }
    out[used] = '\0'; return out;
}

static const char *skip_string(const char *p) {
    if (*p != '"') return p;
    for (p++; *p; p++) {
        if (*p == '\\' && p[1]) { p++; continue; }
        if (*p == '"') return p + 1;
    }
    return p;
}

static char *parse_json_string(const char **cursor) {
    const char *p = *cursor;
    char *out;
    size_t used = 0, capacity;
    if (*p != '"') return NULL;
    capacity = strlen(p) + 1;
    out = malloc(capacity);
    if (!out) return NULL;
    p++;
    while (*p && *p != '"') {
        unsigned char c = (unsigned char)*p++;
        if (c == '\\') {
            c = (unsigned char)*p++;
            switch (c) {
            case 'n': c = '\n'; break; case 'r': c = '\r'; break;
            case 't': c = '\t'; break; case 'b': c = '\b'; break;
            case 'f': c = '\f'; break;
            case 'u':
                /* Preserve non-ASCII escapes visibly; package metadata keys and
                   dependency names are ASCII, while descriptions remain valid. */
                if (strlen(p) >= 4) {
                    out[used++] = '\\';
                    out[used++] = 'u';
                    for (int i = 0; i < 4; i++)
                        out[used++] = *p++;
                    continue;
                }
                break;
            default: break;
            }
        }
        out[used++] = (char)c;
    }
    if (*p == '"') p++;
    out[used] = '\0'; *cursor = p; return out;
}

static const char *find_key(const char *begin, const char *end, const char *key) {
    char needle[96];
    snprintf(needle, sizeof(needle), "\"%s\"", key);
    const char *p = begin;
    while ((p = strstr(p, needle)) && p < end) {
        const char *q = p + strlen(needle);
        while (q < end && isspace((unsigned char)*q)) q++;
        if (q < end && *q == ':') return q + 1;
        p = q;
    }
    return NULL;
}

static char *object_string(const char *begin, const char *end, const char *key) {
    const char *p = find_key(begin, end, key);
    if (!p) return strdup("");
    while (p < end && isspace((unsigned char)*p)) p++;
    if (end - p >= 4 && strncmp(p, "null", 4) == 0) return strdup("");
    if (*p != '"') return strdup("");
    return parse_json_string(&p);
}

static long object_long(const char *begin, const char *end, const char *key) {
    const char *p = find_key(begin, end, key);
    if (!p) return 0;
    while (p < end && isspace((unsigned char)*p)) p++;
    return strtol(p, NULL, 10);
}

static double object_double(const char *begin, const char *end, const char *key) {
    const char *p = find_key(begin, end, key);
    if (!p) return 0.0;
    while (p < end && isspace((unsigned char)*p)) p++;
    return strtod(p, NULL);
}

static int object_array(const char *begin, const char *end, const char *key,
                        char ***values, size_t *count) {
    const char *p = find_key(begin, end, key);
    *values = NULL; *count = 0;
    if (!p) return 1;
    while (p < end && isspace((unsigned char)*p)) p++;
    if (*p != '[') return 1;
    p++;
    while (p < end) {
        while (p < end && (isspace((unsigned char)*p) || *p == ',')) p++;
        if (p >= end || *p == ']') return 1;
        if (*p != '"') return 0;
        char *value = parse_json_string(&p);
        char **grown = realloc(*values, (*count + 1) * sizeof(**values));
        if (!value || !grown) { free(value); return 0; }
        *values = grown; (*values)[(*count)++] = value;
    }
    return 0;
}

static void package_destroy(aur_package_t *pkg) {
    free(pkg->name); free(pkg->package_base); free(pkg->version);
    free(pkg->description); free(pkg->url); free(pkg->maintainer);
    char ***lists[] = { &pkg->depends, &pkg->make_depends, &pkg->check_depends,
                        &pkg->provides, &pkg->conflicts };
    size_t counts[] = { pkg->depends_count, pkg->make_depends_count,
                        pkg->check_depends_count, pkg->provides_count,
                        pkg->conflicts_count };
    for (size_t l=0;l<5;l++) { for(size_t i=0;i<counts[l];i++) free((*lists[l])[i]); free(*lists[l]); }
    memset(pkg, 0, sizeof(*pkg));
}

void aur_response_destroy(aur_response_t *response) {
    if (!response) return;
    for (size_t i=0;i<response->count;i++) package_destroy(&response->packages[i]);
    free(response->packages); response->packages=NULL; response->count=0;
}

static int append_package(aur_response_t *response, const char *begin, const char *end) {
    aur_package_t pkg = {0};
    aur_package_t *grown;
    pkg.name=object_string(begin,end,"Name"); pkg.package_base=object_string(begin,end,"PackageBase");
    pkg.version=object_string(begin,end,"Version"); pkg.description=object_string(begin,end,"Description");
    pkg.url=object_string(begin,end,"URL"); pkg.maintainer=object_string(begin,end,"Maintainer");
    pkg.votes=object_long(begin,end,"NumVotes"); pkg.popularity=object_double(begin,end,"Popularity");
    pkg.out_of_date=object_long(begin,end,"OutOfDate");
    if (!pkg.name || !pkg.package_base || !pkg.version || !pkg.description || !pkg.url || !pkg.maintainer ||
        !object_array(begin,end,"Depends",&pkg.depends,&pkg.depends_count) ||
        !object_array(begin,end,"MakeDepends",&pkg.make_depends,&pkg.make_depends_count) ||
        !object_array(begin,end,"CheckDepends",&pkg.check_depends,&pkg.check_depends_count) ||
        !object_array(begin,end,"Provides",&pkg.provides,&pkg.provides_count) ||
        !object_array(begin,end,"Conflicts",&pkg.conflicts,&pkg.conflicts_count)) {
        package_destroy(&pkg); return 0;
    }
    grown=realloc(response->packages,(response->count+1)*sizeof(*grown));
    if(!grown){package_destroy(&pkg);return 0;}
    response->packages=grown; response->packages[response->count++]=pkg; return 1;
}

static int parse_response(const char *json, aur_response_t *response, char *error, size_t error_size) {
    const char *results=strstr(json,"\"results\"");
    if(!results || !(results=strchr(results,'['))){set_error(error,error_size,"invalid AUR RPC response");return 0;}
    const char *p=results+1;
    while(*p){
        while(*p && *p!='{' && *p!=']') p++;
        if(*p==']') return 1;
        const char *begin=p, *q=p; int depth=0;
        while(*q){ if(*q=='"'){q=skip_string(q);continue;} if(*q=='{')depth++; else if(*q=='}'&&--depth==0){q++;break;} q++; }
        if(depth!=0){set_error(error,error_size,"truncated AUR RPC object");return 0;}
        if(!append_package(response,begin,q)){set_error(error,error_size,"cannot parse AUR package metadata");return 0;}
        p=q;
    }
    set_error(error,error_size,"truncated AUR RPC results"); return 0;
}

static int request(const char *base, const char *operation, const char *argument,
                   aur_response_t *response, char *error, size_t error_size) {
    char *encoded=url_encode(argument), *body=NULL, *url;
    size_t needed;
    memset(response,0,sizeof(*response));
    if(!encoded){set_error(error,error_size,"out of memory");return 0;}
    needed=strlen(base)+strlen(operation)+strlen(encoded)+32;
    url=malloc(needed);
    if(!url){free(encoded);set_error(error,error_size,"out of memory");return 0;}
    if(strcmp(operation,"search")==0) snprintf(url,needed,"%s/search/%s?by=name-desc",base,encoded);
    else snprintf(url,needed,"%s/info?arg[]=%s",base,encoded);
    free(encoded);
    int ok=curl_get(url,&body,error,error_size) && parse_response(body,response,error,error_size);
    if(!ok) aur_response_destroy(response);
    free(url); free(body); return ok;
}

int aur_rpc_search(const char *base_url,const char *query,aur_response_t *response,char *error,size_t error_size){
    return request(base_url?base_url:"https://aur.archlinux.org/rpc/v5","search",query,response,error,error_size);
}
int aur_rpc_info(const char *base_url,const char *name,aur_response_t *response,char *error,size_t error_size){
    return request(base_url?base_url:"https://aur.archlinux.org/rpc/v5","info",name,response,error,error_size);
}
