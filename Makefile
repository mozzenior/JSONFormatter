all: jsonformater

jsonformater: jsonformater.c parser.c parser.h tokenlizer.c tokenlizer.h
	gcc -Wall -Xlinker --strip-all -O2 -o jsonformater jsonformater.c parser.c tokenlizer.c

parser.c parser.h: parser.y
	bison -o parser.c --defines=parser.h parser.y

tokenlizer.c tokenlizer.h: tokenlizer.l
	flex --outfile=tokenlizer.c --header-file=tokenlizer.h tokenlizer.l

test: jsonformater
	cat test.txt | ./jsonformater
	cat test2.txt | ./jsonformater
	cat test3.txt | ./jsonformater
	cat test4.txt | ./jsonformater
	cat test5.txt | ./jsonformater
	./jsonformater test.txt test2.txt
	./jsonformater a_file_does_not_exist
	./jsonformater a_file_does_not_exist test.txt
	./jsonformater test.txt a_file_does_not_exist test2.txt
	./jsonformater

clean:
	rm -rf tokenlizer.c tokenlizer.h parser.c parser.h
	rm -rf jsonformater

