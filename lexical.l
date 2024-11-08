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
"BettyCode" { column_number += 9; return program_keyword;}
"Begin" { column_number += 5; return begin_keyword;}
"End" { column_number += 3; return end_keyword;}

"import" { column_number += 6; return import_keyword; }
"Betty_Input_Output" { column_number += 18; return library_keyword;}

"int" { column_number += 3; return int_keyword;}
"float" { column_number += 5; return float_keyword;}
"char" { column_number += 4; return char_keyword;}

";" { column_number += 1; return semicolon;}
"," { column_number += 1; return comma;}

"==" { column_number += 2; return equal_op; }
"<=" { column_number += 2; return small_equal_op;}
">=" { column_number += 2; return great_equal_op;}
">" { column_number += 1; return great_op;}
"<" { column_number += 1; return small_op;}
"!=" { column_number += 2; return different_op;}

"=" { column_number += 1; return assignment_op;}
"+" { column_number += 1; return plus_op; }
"-" { column_number += 1; return minus_op;}
"*" { column_number += 1; return multiplication_op;}
"/" { column_number += 1; return devision_op;}

"(" { column_number += 1; return left_paranthesis; }
")" { column_number += 1; return right_paranthesis;}

"{" { column_number += 1; return left_curly_bracket;}
"}" { column_number += 1; return right_curly_bracket;}

"if" { column_number += 2; return if_keyword; }

"for" { column_number += 3; return for_keyword;}
"do" { column_number += 2; return do_keyword;}
"while" { column_number += 5; return while_keyword;}

{CST} { column_number += yyleng; return cst;}
{IDF} { column_number += yyleng; return idf;}

[ \t] {column_number += yyleng;}
\n { line_number++;  column_number = 0;}
. {printf("lexical error, line %d , column %d\n", line_number, column_number); }
%%  
int yywrap() {return 1;}
