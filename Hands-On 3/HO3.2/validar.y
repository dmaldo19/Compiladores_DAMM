%{
#include <stdio.h>
#include <stdlib.h>

int yylex();  // Declarar la función yylex()
int yyerror(const char *s); // Declarar yyerror()
%}

%union {
    int bool;
}

%token <bool> BOOLEANO
%token AND OR NOT
%left OR
%left AND
%right NOT

%%
input: expr '\n' { printf("Expresión válida\n"); exit(0); }
     | error '\n' { yyerror("Expresión inválida"); yyerrok; exit(1); }
     ;

expr: expr AND termino
    | expr OR termino
    | termino
    ;

termino: NOT factor
       | factor
       ;

factor: '(' expr ')'
      | BOOLEANO
      ;
%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingrese una expresión lógica: \n");
    return yyparse();
}
