#include "liboqs-wrapper.h"

OQS_KEM *liboqs_kem_new(const char *name) {
    return OQS_KEM_new(name);
}

void liboqs_kem_free(OQS_KEM *kem) {
    OQS_KEM_free(kem);
}

size_t liboqs_kem_length_public_key(const OQS_KEM *kem) {
    return kem->length_public_key;
}

size_t liboqs_kem_length_secret_key(const OQS_KEM *kem) {
    return kem->length_secret_key;
}

size_t liboqs_kem_length_ciphertext(const OQS_KEM *kem) {
    return kem->length_ciphertext;
}

size_t liboqs_kem_length_shared_secret(const OQS_KEM *kem) {
    return kem->length_shared_secret;
}

int liboqs_kem_keypair(OQS_KEM *kem, uint8_t *pk, uint8_t *sk) {
    return OQS_KEM_keypair(kem, pk, sk);
}

int liboqs_kem_encap(OQS_KEM *kem, uint8_t *ct, uint8_t *ss, const uint8_t *pk) {
    return OQS_KEM_encaps(kem, ct, ss, pk);
}

int liboqs_kem_decap(OQS_KEM *kem, uint8_t *ss, const uint8_t *ct, const uint8_t *sk) {
    return OQS_KEM_decaps(kem, ss, ct, sk);
}

