(c-declare #<<eof
#include <SDL2/SDL.h>
eof
)

(c-define-type SDL_Window "SDL_Window")
(c-define-type SDL_Window* (pointer SDL_Window))

(define create-window 
    (c-lambda 
        (nonnull-char-string int32 int32 int32 int32 unsigned-int32)
        SDL_Window*
        "SDL_CreateWindow"))


(define sleep
    (c-lambda (unsigned-int32) void "SDL_Delay"))

(create-window "Hello" 0 0 64 64 0)

(sleep 5000)
(print "Hello")
