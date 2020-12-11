(include "system.scm")

(define screen-w 320)
(define screen-h 240)

(if (zero? (init-system "Hello" screen-w screen-h))
	(begin
		(clear-screen)
		(refresh-screen)
		(sleep 2000)
        (stop-system)))
