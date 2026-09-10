AFLAGS=-g -o
FLAGS=-g -o
CFLAGS=-g -c -Wall -Wextra -Wwrite-strings
LFLAGS=-g -o prog1

prog1: prog1.o binsearch.o mult7div8.o area.o secondMax.o gcd.o reverse.o sum.o product.o commonPrefix.o isPrime.o
	gcc ${LFLAGS} prog1.o binsearch.o mult7div8.o area.o secondMax.o gcd.o reverse.o sum.o product.o commonPrefix.o isPrime.o

prog1.o: prog1.c
	gcc ${CFLAGS} prog1.c

binsearch.o: binsearch.S
	as ${AFLAGS} binsearch.o binsearch.S

mult7div8.o: mult7div8.S
	as ${AFLAGS} mult7div8.o mult7div8.S

area.o: area.S
	as ${AFLAGS} area.o area.S

secondMax.o: secondMax.S
	as ${AFLAGS} secondMax.o secondMax.S

gcd.o: gcd.S
	as ${AFLAGS} gcd.o gcd.S

reverse.o: reverse.S
	as ${AFLAGS} reverse.o reverse.S

sum.o: sum.S
	as ${AFLAGS} sum.o sum.S

product.o: product.S
	as ${AFLAGS} product.o product.S

commonPrefix.o: commonPrefix.S
	as ${AFLAGS} commonPrefix.o commonPrefix.S

isPrime.o: isPrime.S
	as ${AFLAGS} isPrime.o isPrime.S

clean:
	rm -rf prog1
	rm -rf *.o