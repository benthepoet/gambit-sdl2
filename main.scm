(include "system.scm")

(define screen-w 320)
(define screen-h 240)
(define screen-scale 2)

(define tileset "../assets/tileset.bmp")

(define put-sprite
	(lambda
		(x y rows)
		(let ((i x) (j y))
			(vector-for-each
				(lambda (row)
					(vector-for-each
						(lambda (tile)
							(put-tile tile i j)
							(set! i (+ i 8))) 
						row)
					(set! i x)
					(set! j (+ j 8))
					)
				rows
			))))

(if (zero? (init-system "Demo" screen-w screen-h screen-scale))
	(begin
		(load-tileset tileset)
		(clear-screen)
		(put-sprite 64 64 #(#(0 1 16) #(17 2 18)))
		(refresh-screen)
		(sleep 2000)
        (stop-system)))
