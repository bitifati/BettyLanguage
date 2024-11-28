%{
	#include "syntactic.tab.h"
    int line_number = 1;
	int column_number = 0;
	#define MAX_IDF_LENGTH 10
%}
letter [A-Za-z]
digit [0-9]
IDF {letter}({letter}|{digit})* 
CST {digit}+
%%

"Programme" { column_number += yyleng; return program_keyword;}
"InDebut" { column_number += yyleng; return begin_keyword;}
"InFin" { column_number += yyleng; return end_keyword;}
"PDec" { column_number += yyleng; return declaration_keyword;}

"import" { column_number += yyleng; return import_keyword; }
"ISIL.io" { column_number += yyleng; return io_library;}
"ISIL.lang" { column_number += yyleng; return lang_library;}

"final" { column_number += yyleng; return final_keyword;}

"integer" { column_number += yyleng; return int_keyword;}
"float" { column_number += yyleng; return float_keyword;}
"char" { column_number += yyleng; return char_keyword;}

";" { column_number += yyleng; return semicolon;}
"," { column_number += yyleng; return comma;}
"|" { column_number += yyleng; return pipe;}

"==" { column_number += yyleng; return equal_op; }
"<=" { column_number += yyleng; return small_equal_op;}
">=" { column_number += yyleng; return great_equal_op;}
">" { column_number += yyleng; return great_op;}
"<" { column_number += yyleng; return small_op;}
"!=" { column_number += yyleng; return different_op;}

"&&" { column_number += yyleng; return and_keyword;}
"||" { column_number += yyleng; return or_keyword;}
"!" { column_number += yyleng; return not_keyword;}

"=" { column_number += yyleng; return assignment_op;}
"+" { column_number += yyleng; return plus_op; }
"-" { column_number += yyleng; return minus_op;}
"*" { column_number += yyleng; return multiplication_op;}
"/" { column_number += yyleng; return devision_op;}

"(" { column_number += yyleng; return left_paranthesis; }
")" { column_number += yyleng; return right_paranthesis;}

"{" { column_number += yyleng; return left_curly_bracket;}
"}" { column_number += yyleng; return right_curly_bracket;}

"[" { column_number += yyleng; return left_bracket;}
"]" { column_number += yyleng; return right_bracket;}


"if" { column_number += yyleng; return if_keyword; }
"else" { column_number += yyleng; return else_keyword; }
"endif" { column_number += yyleng; return endif_keyword; }

"for" { column_number += yyleng; return for_keyword;}
"do" { column_number += yyleng; return do_keyword;}
"endfor" { column_number += yyleng; return endfor_keyword;}


{CST} { column_number += yyleng; return cst;}
{IDF} { column_number += yyleng; if(strlen(yytext) > MAX_IDF_LENGTH) {printf("Erreur: IDF \"%s\" depasse 10 caracteres.\n", yytext);} return idf;}

"//".* { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
"#".* { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
\/\*([^*/])*\*\/ { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
[ \t] {column_number += yyleng;}
\n { line_number++;  column_number = 0;}
. {printf("lexical error, line %d , column %d\n", line_number, column_number); }
%%  

