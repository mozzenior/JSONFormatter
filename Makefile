all: jsonformatter

jsonformatter: jsonformatter.c parser.c parser.h scanner.c scanner.h
	gcc -Wall -Xlinker --strip-all -O2 -o jsonformatter jsonformatter.c parser.c scanner.c

parser.c parser.h: parser.y
	bison -o parser.c --defines=parser.h parser.y

scanner.c scanner.h: scanner.l
	flex --outfile=scanner.c --header-file=scanner.h scanner.l

test: jsonformatter
	cat tests/001.txt | ./jsonformatter | cmp -s - tests/e001.txt
	./jsonformatter tests/001.txt tests/002.txt
	./jsonformatter a_file_does_not_exist
	./jsonformatter a_file_does_not_exist tests/001.txt
	./jsonformatter tests/001.txt a_file_does_not_exist tests/002.txt
	./jsonformatter tests/001.txt | cmp -s - tests/e001.txt
	./jsonformatter tests/002.txt | cmp -s - tests/e002.txt
	./jsonformatter tests/003.txt | cmp -s - tests/e003.txt
	./jsonformatter tests/004.txt | cmp -s - tests/e004.txt
	./jsonformatter tests/005.txt | cmp -s - tests/e005.txt
	./jsonformatter tests/006.txt | cmp -s - tests/e006.txt
	./jsonformatter tests/007.txt | cmp -s - tests/e007.txt
	./jsonformatter tests/008.txt | cmp -s - tests/e008.txt
	./jsonformatter tests/009.txt | cmp -s - tests/e009.txt
	./jsonformatter tests/010.txt | cmp -s - tests/e010.txt
	./jsonformatter tests/011.txt | cmp -s - tests/e011.txt
	./jsonformatter tests/012.txt | cmp -s - tests/e012.txt
	./jsonformatter tests/013.txt | cmp -s - tests/e013.txt
	./jsonformatter tests/014.txt | cmp -s - tests/e014.txt
	./jsonformatter tests/015.txt | cmp -s - tests/e015.txt

clean:
	rm -rf scanner.c scanner.h parser.c parser.h
	rm -rf jsonformatter

