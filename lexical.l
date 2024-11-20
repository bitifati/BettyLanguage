%{
	#include "syntactic.tab.h"
    int line_number = 1;
	int column_number = 0;
%}
letter [A-Za-z]
digit [0-9]
IDF {letter}({letter}|{digit})*
CST {digit}+
%%
"BettyCode" { column_number += yyleng; return program_keyword;}
"Begin" { column_number += yyleng; return begin_keyword;}
"End" { column_number += yyleng; return end_keyword;}

"import" { column_number += yyleng; return import_keyword; }
"Betty_Input_Output" { column_number += 18; return library_keyword;}

"int" { column_number += yyleng; return int_keyword;}
"float" { column_number += yyleng; return float_keyword;}
"char" { column_number += yyleng; return char_keyword;}

";" { column_number += yyleng; return semicolon;}
"," { column_number += yyleng; return comma;}

"==" { column_number += yyleng; return equal_op; }
"<=" { column_number += yyleng; return small_equal_op;}
">=" { column_number += yyleng; return great_equal_op;}
">" { column_number += yyleng; return great_op;}
"<" { column_number += yyleng; return small_op;}
"!=" { column_number += yyleng; return different_op;}

"AND" { column_number += yyleng; return and_keyword;}
"OR" { column_number += yyleng; return or_keyword;}

"=" { column_number += yyleng; return assignment_op;}
"+" { column_number += yyleng; return plus_op; }
"-" { column_number += yyleng; return minus_op;}
"*" { column_number += yyleng; return multiplication_op;}
"/" { column_number += yyleng; return devision_op;}

"(" { column_number += yyleng; return left_paranthesis; }
")" { column_number += yyleng; return right_paranthesis;}

"{" { column_number += yyleng; return left_curly_bracket;}
"}" { column_number += yyleng; return right_curly_bracket;}

"if" { column_number += yyleng; return if_keyword; }

"for" { column_number += yyleng; return for_keyword;}
"do" { column_number += yyleng; return do_keyword;}
"while" { column_number += yyleng; return while_keyword;}

{CST} { column_number += yyleng; return cst;}
{IDF} { column_number += yyleng; return idf;}

[ \t] {column_number += yyleng;}
\n { line_number++;  column_number = 0;}
. {printf("lexical error, line %d , column %d\n", line_number, column_number); }
%%  
int yywrap() {return 1;}
