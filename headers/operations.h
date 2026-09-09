#ifndef ARCHTOO_OPERATIONS_H
#define ARCHTOO_OPERATIONS_H
int cmd_search_v2(const char *query);
int cmd_available_info_v2(const char *name);
int cmd_query_v2(const char *name);
int cmd_get_pkgbuild_v2(const char *name);
int cmd_local_build_v2(const char *directory);
int cmd_orphans_v2(void);
int cmd_clean_v2(void);
int cmd_stats_v2(void);
int cmd_news_v2(void);
int cmd_completion_v2(void);
int cmd_repo_install_v2(const char *name);
int cmd_provider_v2(const char *name);
int cmd_transaction_check_v2(void);
int cmd_dependency_plan_v2(const char *name);
int cmd_review_v2(const char *directory);
int cmd_devel_v2(void);
#endif
