(include "system.scm")
(include "util.scm")

(define +screen-w+ 320)
(define +screen-h+ 240)
(define +screen-scale+ 2)
(define +ticks-per-second+ 30)
(define +skip-ticks+ (truncate (/ 1000 +ticks-per-second+)))

(define tileset "../assets/tileset.bmp")

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
                rows
            ))))

(if (zero? (init-system "Demo" +screen-w+ +screen-h+ +screen-scale+))
    (begin
        (load-tileset tileset)
        (let ((run #t) 
              (next-tick 0))
            (let main-loop ()
                (set! next-tick (+ (get-ticks) +skip-ticks+))

                (clear-screen)
                (put-sprite 64 64 '#(#(0 1 16) #(17 2 18)))
                (refresh-screen)

                (let event-loop ()
                    (if (poll-event) 
                        (begin 
                            (case (event-type) 
                                ((#x100) (set! run #f)))
                            (event-loop))))

                (let ((sleep-ticks (- next-tick (get-ticks))))
                    (if (> sleep-ticks 0)
                        (sleep sleep-ticks)))

                (if run (main-loop))))
        (stop-system)))
