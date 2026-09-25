/* SPDX-License-Identifier: GPL-3.0-or-later */
/* Archtoo - SHA256 self-check implementation - no external program */
/* Public domain implementation based on Brad Conte's crypto-algorithms */

#ifndef ARCHTOO_SHA256_H
#define ARCHTOO_SHA256_H

#include <stddef.h>
#include <stdint.h>

#define SHA256_BLOCK_SIZE 32

typedef struct {
    uint8_t data[64];
    uint32_t datalen;
    uint64_t bitlen;
    uint32_t state[8];
} SHA256_CTX;

void sha256_init(SHA256_CTX *ctx);
void sha256_update(SHA256_CTX *ctx, const uint8_t *data, size_t len);
void sha256_final(SHA256_CTX *ctx, uint8_t hash[SHA256_BLOCK_SIZE]);

/* Convenience: compute SHA256 of file, output hex string (64 chars + null) */
int sha256_file(const char *path, char out_hex[65]);

/* Verify file against expected hex hash (case insensitive), returns 1 if match */
int sha256_verify_file(const char *path, const char *expected_hex);

#endif
