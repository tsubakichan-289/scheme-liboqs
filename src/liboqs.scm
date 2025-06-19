(module liboqs
  (kem-alg-count kem-alg-identifier kem-new kem-free
   kem-length-public-key kem-length-secret-key
   kem-length-ciphertext kem-length-shared-secret
   kem-keypair kem-encap kem-decap)

  (import scheme (chicken base) (chicken foreign) srfi-4)

  (foreign-declare "#include <oqs/oqs.h>\n#include \"liboqs-wrapper.h\"")


  (define kem-alg-count
    (foreign-lambda* int ((void)) "return OQS_KEM_alg_count();"))

  (define kem-alg-identifier
    (foreign-lambda* c-string ((size_t i)) "return OQS_KEM_alg_identifier(i);"))

  (define kem-new
    (foreign-lambda c-pointer "liboqs_kem_new" c-string))

  (define kem-free
    (foreign-lambda void "liboqs_kem_free" c-pointer))

  (define kem-length-public-key
    (foreign-lambda size_t "liboqs_kem_length_public_key" c-pointer))

  (define kem-length-secret-key
    (foreign-lambda size_t "liboqs_kem_length_secret_key" c-pointer))

  (define kem-length-ciphertext
    (foreign-lambda size_t "liboqs_kem_length_ciphertext" c-pointer))

  (define kem-length-shared-secret
    (foreign-lambda size_t "liboqs_kem_length_shared_secret" c-pointer))

  (define c-kem-keypair
    (foreign-lambda int "liboqs_kem_keypair" c-pointer u8vector u8vector))

  (define (kem-keypair kem)
    (let* ((pk-len (kem-length-public-key kem))
           (sk-len (kem-length-secret-key kem))
           (pk (make-u8vector pk-len))
           (sk (make-u8vector sk-len))
           (status (c-kem-keypair kem pk sk)))
      (values status pk sk)))

  (define c-kem-encap
    (foreign-lambda int "liboqs_kem_encap" c-pointer u8vector u8vector u8vector))

  (define (kem-encap kem pk)
    (let* ((ct-len (kem-length-ciphertext kem))
           (ss-len (kem-length-shared-secret kem))
           (ct (make-u8vector ct-len))
           (ss (make-u8vector ss-len))
           (status (c-kem-encap kem ct ss pk)))
      (values status ct ss)))

  (define c-kem-decap
    (foreign-lambda int "liboqs_kem_decap" c-pointer u8vector u8vector u8vector))

  (define (kem-decap kem ct sk)
    (let* ((ss-len (kem-length-shared-secret kem))
           (ss (make-u8vector ss-len))
           (status (c-kem-decap kem ss ct sk)))
      (values status ss)))
)

