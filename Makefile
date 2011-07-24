all: jsonformater

jsonformater: jsonformater.c parser.c parser.h tokenlizer.c tokenlizer.h
	gcc -Wall -Xlinker --strip-all -O2 -o jsonformater jsonformater.c parser.c tokenlizer.c

parser.c parser.h: parser.y
	bison -o parser.c --defines=parser.h parser.y

tokenlizer.c tokenlizer.h: tokenlizer.l
	flex --outfile=tokenlizer.c --header-file=tokenlizer.h tokenlizer.l

test: jsonformater
	cat tests/001.txt | ./jsonformater | cmp -s - tests/e001.txt
	./jsonformater tests/001.txt tests/002.txt
	./jsonformater a_file_does_not_exist
	./jsonformater a_file_does_not_exist tests/001.txt
	./jsonformater tests/001.txt a_file_does_not_exist tests/002.txt
	./jsonformater tests/001.txt | cmp -s - tests/e001.txt
	./jsonformater tests/002.txt | cmp -s - tests/e002.txt
	./jsonformater tests/003.txt | cmp -s - tests/e003.txt
	./jsonformater tests/004.txt | cmp -s - tests/e004.txt
	./jsonformater tests/005.txt | cmp -s - tests/e005.txt
	./jsonformater tests/006.txt | cmp -s - tests/e006.txt
	./jsonformater tests/007.txt | cmp -s - tests/e007.txt
	./jsonformater tests/008.txt | cmp -s - tests/e008.txt
	./jsonformater tests/009.txt | cmp -s - tests/e009.txt
	./jsonformater tests/010.txt | cmp -s - tests/e010.txt
	./jsonformater tests/011.txt | cmp -s - tests/e011.txt
	./jsonformater tests/012.txt | cmp -s - tests/e012.txt
	./jsonformater tests/013.txt | cmp -s - tests/e013.txt
	./jsonformater tests/014.txt | cmp -s - tests/e014.txt

clean:
	rm -rf tokenlizer.c tokenlizer.h parser.c parser.h
	rm -rf jsonformater

