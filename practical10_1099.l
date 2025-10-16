%{
#include "y.tab.h"
%}

%%
[a-zA-Z][a-zA-Z0-9]*   { yylval = strdup(yytext); return ID; }
[0-9]+                 { yylval = strdup(yytext); return NUM; }
"="                    { return ASSIGN; }
";"                    { return SEMI; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
"*"                    { return MUL; }
"/"                    { return DIV; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
[\n\t ]+               ;
.                      { return yytext[0]; }
%%
int yywrap() { return 1; }

