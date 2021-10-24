%{
#include <stdio.h>
int yylex();
void yyerror(char *s);
%}
%token NUMBER
%token ADD SUB MUL DIV ABS CP OR AND OP
%token EOL
%%
calclist: 
 | calclist exp EOL { printf("decimal = %d\nhexadecimal = 0x%x\n", $2,$2); } 
 | calclist EOL {/*NO HACE NADA*/} 
 ; 
factor: ter { $$ = $1; }
    | factor MUL ter { $$ = $1 * $3; }
    | factor DIV ter { $$ = $1 / $3; }
    ;
ter:  term
    | ter AND term {$$ = $1 & $3; }
    | ter OR term { $$ = $1 | $3; }
    ;
term: NUMBER { $$ = $1; }
    | OR term { $$ = $2 >= 0 ? $2 : -$2; }
    | OP exp CP { $$ = $2; }
    ;
exp: factor      
    | exp ADD factor { $$ = $1 + $3; }
    | exp SUB factor { $$ = $1 - $3; }
    ;

%%
void main(int argc, char **argv)
{
  yyparse();
}

void yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}