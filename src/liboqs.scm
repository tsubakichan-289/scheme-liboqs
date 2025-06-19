(module liboqs
  (kem-alg-count kem-alg-identifier kem-new kem-free
   kem-length-public-key kem-length-secret-key
   kem-length-ciphertext kem-length-shared-secret
   kem-keypair kem-encap kem-decap)

  (import scheme (chicken base) (chicken foreign) srfi-4)

  (foreign-declare "#include <oqs/oqs.h>")


  (define kem-alg-count
    (foreign-lambda* int ((void)) "return OQS_KEM_alg_count();"))

  (define kem-alg-identifier
    (foreign-lambda* c-string ((size_t i)) "return OQS_KEM_alg_identifier(i);"))

  (define kem-new
    (foreign-lambda* c-pointer ((c-string name)) "return OQS_KEM_new(name);"))

  (define kem-free
    (foreign-lambda* void ((c-pointer kem)) "OQS_KEM_free(kem);"))

  (define kem-length-public-key
    (foreign-lambda* size_t ((c-pointer kem))
      "return ((OQS_KEM*)kem)->length_public_key;"))

  (define kem-length-secret-key
    (foreign-lambda* size_t ((c-pointer kem))
      "return ((OQS_KEM*)kem)->length_secret_key;"))

  (define kem-length-ciphertext
    (foreign-lambda* size_t ((c-pointer kem))
      "return ((OQS_KEM*)kem)->length_ciphertext;"))

  (define kem-length-shared-secret
    (foreign-lambda* size_t ((c-pointer kem))
      "return ((OQS_KEM*)kem)->length_shared_secret;"))

  (define (kem-keypair kem)
    (let* ((pk-len (kem-length-public-key kem))
           (sk-len (kem-length-secret-key kem))
           (pk (make-u8vector pk-len))
           (sk (make-u8vector sk-len))
           (status ((foreign-lambda* int ((c-pointer kem) (u8vector pk) (u8vector sk))
                    "return OQS_KEM_keypair(kem, pk, sk);")
                    kem pk sk)))
      (values status pk sk)))

  (define (kem-encap kem pk)
    (let* ((ct-len (kem-length-ciphertext kem))
           (ss-len (kem-length-shared-secret kem))
           (ct (make-u8vector ct-len))
           (ss (make-u8vector ss-len))
           (status ((foreign-lambda* int ((c-pointer kem) (u8vector ct) (u8vector ss) (u8vector pk))
                    "return OQS_KEM_encaps(kem, ct, ss, pk);")
                    kem ct ss pk)))
      (values status ct ss)))

  (define (kem-decap kem ct sk)
    (let* ((ss-len (kem-length-shared-secret kem))
           (ss (make-u8vector ss-len))
           (status ((foreign-lambda* int ((c-pointer kem) (u8vector ss) (u8vector ct) (u8vector sk))
                    "return OQS_KEM_decaps(kem, ss, ct, sk);")
                    kem ss ct sk)))
      (values status ss)))
)

