%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 1;

char* newTemp() {
    char *temp = (char*)malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

void yyerror(const char *s);
int yylex();

%}

%union {
    char *str;
}

%token <str> ID NUM
%token ASSIGN SEMI PLUS MINUS MUL DIV LPAREN RPAREN
%type <str> expr term factor assign_stmt

%%
program:
      program assign_stmt
    | /* empty */
    ;

assign_stmt:
      ID ASSIGN expr SEMI {
          printf("%s = %s\n", $1, $3);
      }
    ;

expr:
      expr PLUS term {
          char *temp = newTemp();
          printf("%s = %s + %s\n", temp, $1, $3);
          $$ = temp;
      }
    | expr MINUS term {
          char *temp = newTemp();
          printf("%s = %s - %s\n", temp, $1, $3);
          $$ = temp;
      }
    | term { $$ = $1; }
    ;

term:
      term MUL factor {
          char *temp = newTemp();
          printf("%s = %s * %s\n", temp, $1, $3);
          $$ = temp;
      }
    | term DIV factor {
          char *temp = newTemp();
          printf("%s = %s / %s\n", temp, $1, $3);
          $$ = temp;
      }
    | factor { $$ = $1; }
    ;

factor:
      ID { $$ = $1; }
    | NUM { $$ = $1; }
    | LPAREN expr RPAREN { $$ = $2; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expression (end with ;):\n");
    yyparse();
    return 0;
}

