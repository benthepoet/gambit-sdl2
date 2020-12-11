(c-declare #<<eof
#include <SDL2/SDL.h>

SDL_Window* window;
SDL_Renderer* renderer;

eof
)

(define init-system
	(c-lambda
		(nonnull-char-string int32 int32)
		int32
#<<eof
	if ((window = SDL_CreateWindow(___arg1, 0, 0, ___arg2, ___arg3, 0)) == NULL) {
		___return(3);
	}
	if ((renderer = SDL_CreateRenderer(window, -1, 0)) == NULL) {
		___return(3);
	}
	___return(0);
eof
))

(define clear-scr
	(c-lambda
		()
		void
#<<eof
		SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
		SDL_RenderClear(renderer);
		___return;
eof
))

(define refresh-scr
	(c-lambda
		()
		void
		"SDL_RenderPresent(renderer);"))

(define sleep
    (c-lambda (unsigned-int32) void "SDL_Delay"))

(define scr-w 320)
(define scr-h 240)

(if (= (init-system "Hello" scr-w scr-h) 0)
	(begin
		(clear-scr)
		(refresh-scr)
		(sleep 2000)))
