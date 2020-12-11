CC = gcc
CFLAGS = -g -Wall -I/usr/include -L/usr/lib/gambit4 -ldl -lm -lutil
SDL2 = `sdl2-config --cflags --libs`
OUTDIR = bin

main: $(wildcard *.o)
	$(CC) $(CFLAGS) -o $(OUTDIR)/$@ $^ $(SDL2)
