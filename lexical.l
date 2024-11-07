%{
    int line_number = 1;
%}
letter [A-Za-z]
digit [0-9]
IDF {letter}({letter}|{digit})*
CST {digit}+
%%

; return semicolon;
, return comma;
= return assignment;
{CST} return cst;
{IDF} return idf;

[ \t]
\n { line_number++; }
. { printf("lexical error, line %d\n", line_number); }
%%  
