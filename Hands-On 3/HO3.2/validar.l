%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[1]                                    { yylval.bool = 1; return BOOLEANO; }
[0]                                    { yylval.bool = 0; return BOOLEANO; }
[aA][nN][dD]                           { return AND; }
[oO][rR]                               { return OR; }
[nN][oO][tT]                           { return NOT; }
[ \t]                                  ; /* ignorar espacios y tabulaciones */
[\n]                                   { return '\n'; }
[()]                                   { return yytext[0]; }
.                                      { return yytext[0]; }
%%

int yywrap() { return 1; }
