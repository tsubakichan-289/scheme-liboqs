(import scheme (chicken base) (chicken foreign) srfi-4 liboqs)

;; Simple demonstration of generating a keypair, encapsulating,
;; and decapsulating using the first available algorithm.

(let* ((count (kem-alg-count))
       (alg-name (kem-alg-identifier 0))
       (kem (kem-new alg-name)))
  (unless kem
    (error "Could not initialize KEM"))
  (let-values (((status pk sk) (kem-keypair kem)))
    (unless (zero? status) (error "keypair failed"))
    (let-values (((status ct ss1) (kem-encap kem pk)))
      (unless (zero? status) (error "encap failed"))
      (let-values (((status ss2) (kem-decap kem ct sk)))
        (unless (zero? status) (error "decap failed"))
        (print "Algorithm: " alg-name)
        (print "Shared secrets match: " (equal? ss1 ss2))))
    (kem-free kem)))

