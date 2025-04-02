%{
#include <stdio.h>
#include <stdlib.h>

int yylex();  // Declarar la función yylex()
int yyerror(const char *s); // Declarar yyerror()
%}


%union {
    int num;
}

%token <num> NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS
%%
input: expr '\n' { printf("Expresión válida\n"); exit(0); }
     | error '\n' { yyerror("Expresión inválida"); yyerrok; exit(1); }
     ;

expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '-' expr %prec UMINUS
    | '(' expr ')'
    | NUMBER
    ;
%%

int yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}

int main() {
    printf("Ingrese una expresión: \n");
    return yyparse();
}
