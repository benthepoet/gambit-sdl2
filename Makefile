OUTDIR = bin

main: main.scm
	gsc -ld-options -lSDL2 -o $(OUTDIR)/$@ -exe $^
