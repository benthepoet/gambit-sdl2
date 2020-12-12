(include "system.scm")

(define screen-w 320)
(define screen-h 240)

(define tileset "tileset.bmp")

(if (zero? (init-system "Hello" screen-w screen-h))
	(begin
		(load-tileset tileset)
		(clear-screen)
		(put-tile 0 0 0 0)
		(refresh-screen)
		(sleep 2000)
        (stop-system)))
