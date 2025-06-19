#ifndef LIBOQS_WRAPPER_H
#define LIBOQS_WRAPPER_H

#include <oqs/oqs.h>

OQS_KEM *liboqs_kem_new(const char *name);
void liboqs_kem_free(OQS_KEM *kem);
size_t liboqs_kem_length_public_key(const OQS_KEM *kem);
size_t liboqs_kem_length_secret_key(const OQS_KEM *kem);
size_t liboqs_kem_length_ciphertext(const OQS_KEM *kem);
size_t liboqs_kem_length_shared_secret(const OQS_KEM *kem);
int liboqs_kem_keypair(OQS_KEM *kem, uint8_t *pk, uint8_t *sk);
int liboqs_kem_encap(OQS_KEM *kem, uint8_t *ct, uint8_t *ss, const uint8_t *pk);
int liboqs_kem_decap(OQS_KEM *kem, uint8_t *ss, const uint8_t *ct, const uint8_t *sk);

#endif /* LIBOQS_WRAPPER_H */
