%{
    int line_number = 1;
%}
letter [A-Za-z]
digit [0-9]
IDF {letter}({letter}|{digit})*
CST {digit}+
%%

";" return semicolon;
"," return comma;

"==" return equal_op;
"<=" return small_equal_op;
">=" return great_equal_op;
">" return great_op;
"<" return small_op;
"!=" return different_op;

"=" return assignment_op;
"+" return plus_op;
"-" return minus_op;
"*" return multiplication_op;
"/" return devision_op;

"(" return left_paranthesis;
")" return right_paranthesis;
"{" return left_curly_bracket;
"}" return right_curly_bracket;

"if" return if_keyword;
"for" return for_keyword;
"do" return do_keyword;
"while" return while_keyword;

{CST} return cst;
{IDF} return idf;

[ \t]
\n { line_number++; }
. { printf("lexical error, line %d\n", line_number); }
%%  
