(define put-sprite
  (lambda
      (x y rows)
    (let ((i x) (j y))
      (vec-each
       (lambda (row)
         (vec-each
          (lambda (tile)
            (put-tile tile i j)
            (set! i (+ i 8))) 
          row)
         (set! i x)
         (set! j (+ j 8)))
       rows))))
