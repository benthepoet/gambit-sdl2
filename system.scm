(c-declare 
#<<eof
    #include <SDL2/SDL.h>

    SDL_Window* window;
    SDL_Renderer* renderer;
    SDL_Texture* tileset;
eof
)

(define init-system
	(c-lambda
		(nonnull-char-string int32 int32 int32)
		int32
#<<eof
    SDL_Init(SDL_INIT_VIDEO);

	if ((window = SDL_CreateWindow(___arg1, SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, ___arg2 * ___arg4, ___arg3 * ___arg4, 0)) == NULL) {
		___return(3);
	}
	if ((renderer = SDL_CreateRenderer(window, -1, 0)) == NULL) {
		___return(3);
	}

    SDL_RenderSetLogicalSize(renderer, ___arg2, ___arg3);

	___return(0);
eof
))

(define stop-system
    (c-lambda
        ()
        void
#<<eof
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    ___return;    
eof
))

(define clear-screen
	(c-lambda
		()
		void
#<<eof
	SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
	SDL_RenderClear(renderer);
	___return;
eof
))

(define refresh-screen
	(c-lambda
		()
		void
#<<eof
    SDL_RenderPresent(renderer);
    ___return;		
eof
))

(define load-tileset
    (c-lambda
        (nonnull-char-string)
        void
#<<eof
    SDL_Surface* surface = SDL_LoadBMP(___arg1);
    tileset = SDL_CreateTextureFromSurface(renderer, surface);
    SDL_FreeSurface(surface);
    ___return;
eof
))

(define put-tile
    (c-lambda
        (int8 int8 int8)
        void
#<<eof
    char s = 8;
    char k = 16;

    SDL_Rect src;
    src.x = (___arg1 % k) * s;
    src.y = (___arg1 / k) * s;
    src.w = s;
    src.h = s;

    SDL_Rect dest;
    dest.x = ___arg2;
    dest.y = ___arg3;
    dest.w = s;
    dest.h = s;

    SDL_RenderCopy(renderer, tileset, &src, &dest);
    ___return;
eof
))

(define get-ticks
    (c-lambda () unsigned-int32 "SDL_GetTicks"))

(define sleep
    (c-lambda (unsigned-int32) void "SDL_Delay"))
