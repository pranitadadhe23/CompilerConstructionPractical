%{
#include <stdio.h>
#include <stdlib.h>

void dec_to_hex(int num) {
    char hex[20];
    int i = 0, temp = num;

    if (num == 0) {
        printf("Decimal: 0 -> Hexadecimal: 0\n");
        return;
    }

    while (num > 0) {
        int rem = num % 16;
        hex[i++] = (rem < 10) ? rem + '0' : rem - 10 + 'A';
        num = num / 16;
    }

    printf("Decimal: %d -> Hexadecimal: ", temp);
    while (i--)
        putchar(hex[i]);
    putchar('\n');
}
%}

%%
[0-9]+   { dec_to_hex(atoi(yytext)); }
.|\n     ;
%%

int main() {
    yylex();
    return 0;
}

