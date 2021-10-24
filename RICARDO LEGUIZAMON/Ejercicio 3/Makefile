ejer3.tab.c: ejer3.y
	bison -d ejer3.y

lex.yy.c: ejer3.l 
	flex ejer3.l

programa: lex.yy.c ejer3.tab.c
	cc -o programa ejer3.tab.c lex.yy.c -lfl
	./programa
clean:
	rm *.c *.h programa

