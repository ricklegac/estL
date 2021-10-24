%{
# include "ejer2.tab.h"
int yyval;
%}

%%
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { }
0x[a-f0-9]+ { sscanf(yytext,"%d\n",&yylval) ; return NUMBER; }
.      { }
%%
