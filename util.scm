(define vec-each
  (lambda (fn vec)
    (do ((v vec)
         (i 0 (+ i 1)))
        ((= i (vector-length vec)) vec)
      (fn (vector-ref vec i)))))
