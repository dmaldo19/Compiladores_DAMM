%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%
[0-9]+                                 { yylval.value = atoi(yytext); return NUMBER; }
[aA][nN][dD]                           { return AND; }
[oO][rR]                               { return OR; }
[nN][oO][tT]                           { return NOT; }
"+"                                    { return '+'; }
"-"                                    { return '-'; }
"*"                                    { return '*'; }
"/"                                    { return '/'; }
[ \t]                                  ;
[\n]                                   { return '\n'; }
[()]                                   { return yytext[0]; }
.                                      { return yytext[0]; }
%%

int yywrap() { return 1; }