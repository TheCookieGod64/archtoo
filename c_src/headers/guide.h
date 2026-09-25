/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - Copyright (C) 2026 TheCookieGod64 */

#ifndef ARCHTOO_GUIDE_H
#define ARCHTOO_GUIDE_H

typedef enum {
    GUIDE_FIRST_RUN = 0,
    GUIDE_ALWAYS,
    GUIDE_NEVER
} guide_policy_t;

int guide_policy_parse(const char *text, guide_policy_t *out);
const char *guide_policy_name(guide_policy_t policy);
void guide_set_policy(guide_policy_t policy);
guide_policy_t guide_get_policy(void);
void guide_request_explicit(void);
int guide_should_show(void);
void guide_print(void);
int guide_mark_seen(void);
int guide_maybe_show(void);

#endif
