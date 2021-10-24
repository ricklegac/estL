ejer2.tab.c: ejer2.y
	bison -d ejer2.y

lex.yy.c: ejer2.l 
	flex ejer2.l

programa: lex.yy.c ejer2.tab.c
	cc -o programa ejer2.tab.c lex.yy.c -lfl
	./programa
clean:
	rm *.c *.h programa

