/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../headers/operations.h"
#include "../headers/utils.h"
#include "../headers/colors.h"

static void unescape_xml(char *s) {
    char *r = s, *w = s;
    while (*r) {
        if (r[0] == '&') {
            if (strncmp(r, "&amp;", 5) == 0) { *w++ = '&'; r += 5; continue; }
            if (strncmp(r, "&lt;", 4) == 0)  { *w++ = '<'; r += 4; continue; }
            if (strncmp(r, "&gt;", 4) == 0)  { *w++ = '>'; r += 4; continue; }
            if (strncmp(r, "&quot;", 6) == 0){ *w++ = '"'; r += 6; continue; }
            if (strncmp(r, "&apos;", 6) == 0){ *w++ = '\''; r += 6; continue; }
            if (strncmp(r, "&#39;", 5) == 0) { *w++ = '\''; r += 5; continue; }
        }
        *w++ = *r++;
    }
    *w = '\0';
}

int cmd_news_v2(void) {
    char *body = NULL;
    const char *p;
    int shown = 0;
    int rc;

    if (!have_cmd("curl")) {
        fprintf(stderr, COLOR_RED "[-] curl is required to fetch Arch news.\n"
                COLOR_RESET);
        return 0;
    }

    rc = run_cmd_capture("curl -fsSL --max-time 20 -- "
                         "'https://archlinux.org/feeds/news/'", &body);
    if (rc != 0 || !body || !*body) {
        fprintf(stderr, COLOR_RED "[-] Could not download Arch news feed.\n"
                COLOR_RESET);
        free(body);
        return 0;
    }

    printf(COLOR_CYAN ">>> Recent Arch Linux news\n" COLOR_RESET);
    /* Walk <item> elements so the channel <title> is not printed as news. */
    p = body;
    while (shown < 10) {
        const char *item = strstr(p, "<item>");
        const char *item_end;
        const char *title;
        const char *title_end;
        char buf[512];
        size_t n;

        if (!item)
            break;
        item_end = strstr(item, "</item>");
        if (!item_end)
            break;
        title = strstr(item, "<title>");
        if (!title || title > item_end) {
            p = item_end + 7;
            continue;
        }
        title += 7;
        if (strncmp(title, "<![CDATA[", 9) == 0)
            title += 9;
        title_end = strstr(title, "</title>");
        if (!title_end || title_end > item_end) {
            p = item_end + 7;
            continue;
        }
        if (title_end >= title + 3 && strncmp(title_end - 3, "]]>", 3) == 0)
            title_end -= 3;
        n = (size_t)(title_end - title);
        if (n >= sizeof(buf))
            n = sizeof(buf) - 1;
        memcpy(buf, title, n);
        buf[n] = '\0';
        unescape_xml(buf);
        printf("  %d. %s\n", shown + 1, buf);
        shown++;
        p = item_end + 7;
    }
    free(body);

    if (shown == 0) {
        fprintf(stderr, COLOR_RED "[-] News feed contained no items.\n"
                COLOR_RESET);
        return 0;
    }
    return 1;
}
