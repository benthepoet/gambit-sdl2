(include "util.scm")
(include "system.scm")
(include "sprite.scm")
(include "block.scm")

(define +screen-w+ 320)
(define +screen-h+ 240)
(define +screen-scale+ 2)
(define +ticks-per-second+ 30)
(define +skip-ticks+ (truncate (/ 1000 +ticks-per-second+)))

(define draw-tilemap
    (lambda (tilemap) 
        (put-sprite 0 0 tilemap)))

(define draw-sprites
    (lambda (sprites)
        (for-each 
            (lambda (s) (apply put-sprite s)) 
            sprites)))

(define root (make-block 
    (make-state
        "../assets/tileset.bmp"
        '#(#(0 1 0 1 0 1 0)) 
        (list '(64 64 #(#(0 1 16) #(17 2 18)))))
    (lambda (state)
        (let ((tilemap (state-tilemap state))
              (sprites (state-sprites state)))
            (draw-tilemap tilemap)
            (draw-sprites sprites)))))

(if (zero? (init-system "Demo" +screen-w+ +screen-h+ +screen-scale+))
    (begin
        (load-tileset (state-tileset (block-state root)))
        (let ((run #t) 
              (next-tick 0))
            (let main-loop ()
                (set! next-tick (+ (get-ticks) +skip-ticks+))

                (clear-screen)
                (let ((on-draw (block-on-draw root))
                      (state (block-state root)))
                    (on-draw state))
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
