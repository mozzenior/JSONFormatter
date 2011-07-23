all: jsonformater

jsonformater: jsonformater.c parser.c parser.h tokenlizer.c tokenlizer.h
	gcc -O2 -o jsonformater jsonformater.c parser.c tokenlizer.c

parser.c parser.h: parser.y
	bison -o parser.c --defines=parser.h parser.y

tokenlizer.c tokenlizer.h: tokenlizer.l
	flex --outfile=tokenlizer.c --header-file=tokenlizer.h tokenlizer.l

clean:
	rm -rf tokenlizer.c tokenlizer.h parser.c parser.h
	rm -rf jsonformater

