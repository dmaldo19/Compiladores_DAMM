%{
#include <stdio.h>
#include <stdlib.h>

int yylex();  // Declarar la función yylex()
int yyerror(const char *s); // Declarar yyerror()
%}

%union {
    int value;
}

%token <value> NUMBER BOOL
%token AND OR NOT
%left '+' '-'
%left '*' '/'
%left OR
%left AND
%right NOT UMINUS

%%
input: expr '\n' { printf("Expresión válida\n"); exit(0); }
     | error '\n' { yyerror("Expresión inválida"); yyerrok; exit(1); }
     ;

expr: expr '+' termino
    | expr '-' termino
    | termino
    ;

termino: termino '*' factor
       | termino '/' factor
       | factor
       ;

factor: '(' expr ')'
      | '-' factor %prec UMINUS
      | NUMBER
      | logico
      ;

logico: logico AND logic_term
      | logico OR logic_term
      | logic_term
      ;

logic_term: NOT logic_factor
          | logic_factor
          ;

logic_factor: '(' logico ')'
            | BOOL
            ;
%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingrese una expresión combinada: \n");
    return yyparse();
}