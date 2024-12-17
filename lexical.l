%{
	#include "syntactic.tab.h"
	#include "TS.h"
    int line_number = 1;
	int column_number = 0;
	extern YYSTYPE yylval;
	#define MAX_IDF_LENGTH 10


%}
letter [A-Za-z]
digit [0-9]
IDF {letter}({letter}|{digit})* 
cstI [-+]?{digit}+
cstF [-+]?{digit}+("."{digit}+)? 
STRING \"[^"]*\" 

%%

"Programme" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return program_keyword;}
"InDebut" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return begin_keyword;}
"InFin" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return end_keyword;}
"PDec" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return declaration_keyword;}

"import" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return import_keyword; }
"ISIL.io" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return io_library;}
"ISIL.lang" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return lang_library;}

"final" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return final_keyword;}

"integer" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.str=strdup(yytext); return int_keyword;}
"float" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.str=strdup(yytext); return float_keyword;}
"char" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.str=strdup(yytext); return char_keyword;}
"bool" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.str=strdup(yytext); return bool_keyword; }

";" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return semicolon;}
"|" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return pipe_keyword;}

"==" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return equal_op; }
"<=" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return small_equal_op;}
">=" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return great_equal_op;}
">" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return great_op;}
"<" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return small_op;}
"!=" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return different_op;}

"&&" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return and_keyword;}
"||" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return or_keyword;}
"!" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return not_keyword;}

"<--" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return assignment_op;}
"+" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return plus_op; }
"-" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return minus_op;}
"*" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return multiplication_op;}
"/" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return devision_op;}

"(" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return left_paranthesis; }
")" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return right_paranthesis;}


"[" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return left_bracket;}
"]" { rechercher(yytext,"Separateur",0,"",3); column_number += yyleng; return right_bracket;}

"true" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.Integer = 1; return true_keyword;}
"false" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; yylval.Integer = 0; return false_keyword;}

"if" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return if_keyword; }
"else" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return else_keyword; }
"endif" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return endif_keyword; }

"for" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return for_keyword;}
"do" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return do_keyword;}
"endfor" { rechercher(yytext,"Mot cle",0,"",2); column_number += yyleng; return endfor_keyword;}


{cstI} {column_number += yyleng;
        yylval.Integer=atoi(yytext); 
		return csti;
}
	
{cstF} {column_number += yyleng;
        yylval.Float=atof(yytext); 
		return cstf;
}

{STRING} { 
	yylval.str = strdup(yytext + 1); 
	yylval.str[strlen(yylval.str) - 1] = '\0'; 
	return string; 
}


{IDF} { 
    column_number += yyleng;
    if (strlen(yytext) > MAX_IDF_LENGTH) {
        printf("Erreur: IDF \"%s\" dépasse 10 caractères à la ligne %d, colonne %d.\n", yytext, line_number, column_number);
        return 0; // Return no token, effectively discarding the input
    } 
    yylval.str = strdup(yytext); // If valid, store the identifier
	rechercher(yytext,"IDF","","",1); 
    return idf;
}


"//".* { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
"#".* { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
\/\*([^*/])*\*\/ { int i=0; while (yytext[i]!='\0' ){ if ( yytext[i]=='\n'){line_number++;}  i++;} }
[ \t] {column_number += yyleng;}
\n { line_number++;  column_number = 0;}
. {printf("lexical error, line %d , column %d\n", line_number, column_number); }
%%  

