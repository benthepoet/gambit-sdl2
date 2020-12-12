(include "system.scm")

(define screen-w 320)
(define screen-h 240)

(define tileset "../assets/tileset.bmp")

(define put-sprite
	(lambda
		(x y tiles)
		(let ((i x))
			(vector-for-each
				(lambda (t)
					(put-tile (car t) (cdr t) i y)
					(set! i (+ i 8))) 
				tiles))))

(if (zero? (init-system "Demo" screen-w screen-h))
	(begin
		(load-tileset tileset)
		(clear-screen)
		(put-sprite 64 64 '#((0 . 0) (0 . 0)))
		(refresh-screen)
		(sleep 2000)
        (stop-system)))
