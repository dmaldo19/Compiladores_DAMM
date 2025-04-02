%{
#include <stdio.h>
%}

/* Definiciones */
DIGITO    [0-9]
LETRA     [a-zA-Z]
ID        {LETRA}({LETRA}|{DIGITO})*
NUMERO    {DIGITO}+

%x COMENTARIO_LINEA
%x COMENTARIO_MULTI
%x CADENA

%%
int       { printf("PALABRA_CLAVE: %s\n", yytext); }
return    { printf("PALABRA_CLAVE: %s\n", yytext); }
{ID}      { printf("IDENTIFICADOR: %s\n", yytext); }
{NUMERO}  { printf("NUMERO: %s\n", yytext); }

\"        { BEGIN(CADENA); printf("CADENA: \""); }
<CADENA>[^\"\n\\]* { printf("%s", yytext); }
<CADENA>\\. { printf("%s", yytext); } /* Escape sequences */
<CADENA>\"  { BEGIN(INITIAL); printf("\"\n"); }
<CADENA>\n  { printf("\nError: cadena sin terminar\n"); BEGIN(INITIAL); }

"//"      { BEGIN(COMENTARIO_LINEA); printf("COMENTARIO: //"); }
<COMENTARIO_LINEA>[^\n]* { printf("%s", yytext); }
<COMENTARIO_LINEA>\n { printf("\n"); BEGIN(INITIAL); }

"/*"      { BEGIN(COMENTARIO_MULTI); printf("COMENTARIO: /*"); }
<COMENTARIO_MULTI>[^*]* { printf("%s", yytext); }
<COMENTARIO_MULTI>"*"+[^*/]* { printf("%s", yytext); }
<COMENTARIO_MULTI>"*"+"/" { printf("*/\n"); BEGIN(INITIAL); }

[ \t\n]   { /* Ignorar espacios en blanco */ }
.         { printf("OTRO: %s\n", yytext); }

%%
int main() {
  yylex();
  return 0;
}

int yywrap() {
  return 1;
}