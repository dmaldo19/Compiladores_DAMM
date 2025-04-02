%{
#include <stdio.h>

int contador_palabras_clave = 0;
int contador_identificadores = 0;
int contador_numeros = 0;
int contador_operadores = 0;
int contador_delimitadores = 0;
int contador_comentarios = 0;
int contador_cadenas = 0;
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
"int"|"float"|"char"|"double"|"void"|"return"|"if"|"else"|"while"|"for" {
  contador_palabras_clave++;
}

{ID}      { contador_identificadores++; }
{NUMERO}  { contador_numeros++; }

[+\-*/=<>!&|] { contador_operadores++; }
[;,(){}\[\]] { contador_delimitadores++; }

\"        { BEGIN(CADENA); contador_cadenas++; }
<CADENA>[^\"\n\\]* { /* Contenido de la cadena */ }
<CADENA>\\. { /* Secuencias de escape */ }
<CADENA>\"  { BEGIN(INITIAL); }
<CADENA>\n  { printf("Error: cadena sin terminar\n"); BEGIN(INITIAL); }

"//"      { BEGIN(COMENTARIO_LINEA); contador_comentarios++; }
<COMENTARIO_LINEA>[^\n]* { /* Contenido del comentario */ }
<COMENTARIO_LINEA>\n { BEGIN(INITIAL); }

"/*"      { BEGIN(COMENTARIO_MULTI); contador_comentarios++; }
<COMENTARIO_MULTI>[^*]* { /* Contenido del comentario */ }
<COMENTARIO_MULTI>"*"+[^*/]* { /* Contenido del comentario */ }
<COMENTARIO_MULTI>"*"+"/" { BEGIN(INITIAL); }

[ \t\n]   { /* Ignorar espacios en blanco */ }
.         { /* Otros caracteres */ }

%%
int main(int argc, char **argv) {
  if (argc > 1) {
    FILE *file = fopen(argv[1], "r");
    if (!file) {
      fprintf(stderr, "No se pudo abrir el archivo %s\n", argv[1]);
      return 1;
    }
    yyin = file;
  }
  
  yylex();
  
  printf("Resultados del análisis léxico:\n");
  printf("Palabras clave: %d\n", contador_palabras_clave);
  printf("Identificadores: %d\n", contador_identificadores);
  printf("Números: %d\n", contador_numeros);
  printf("Operadores: %d\n", contador_operadores);
  printf("Delimitadores: %d\n", contador_delimitadores);
  printf("Comentarios: %d\n", contador_comentarios);
  printf("Cadenas: %d\n", contador_cadenas);
  
  return 0;
}

int yywrap() {
  return 1;
}