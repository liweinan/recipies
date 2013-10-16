#ifndef SHA_H
#define SHA_H

#define SHA1_RESULT_SIZE 5
#define SHA1_BYTE_SIZE SHA1_RESULT_SIZE * sizeof( int )

#define SHA256_RESULT_SIZE 8
#define SHA256_BYTE_SIZE SHA256_RESULT_SIZE * sizeof( int )

#include "digest.h"

unsigned int sha1_initial_hash[ SHA1_RESULT_SIZE ];
void sha1_block_operate( const unsigned char *block, unsigned int hash[ SHA1_RESULT_SIZE ] );
void sha1_finalize( unsigned char *padded_block, int length_in_bits );
void new_sha1_digest( digest_ctx *context );
void new_sha256_digest( digest_ctx *context );

#endif
