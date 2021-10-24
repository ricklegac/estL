%{
# include "ejer3.tab.h"
int yyval;
%}
%%
"&"    { return AND; }
"|"    { return OR; }
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { return EOL; }
0x[a-f0-9]+ { sscanf(yytext,"%d\n",&yylval) ; return NUMBER; }
.      { }
%%
