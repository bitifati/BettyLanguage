%{
#include <stdio.h>
extern int line_number;
void yyerror(char* message)
{
printf("syntax error, line %d : %s",line_number, message);
}
int yylex(void);
%}
%token program_keyword begin_keyword end_keyword declaration_keyword
%token import_keyword math_library lang_library
%token int_keyword float_keyword char_keyword 
%token semicolon comma 
%token equal_op small_equal_op great_equal_op great_op small_op different_op 
%token and_keyword or_keyword
%token assignment_op plus_op minus_op multiplication_op devision_op 
%token left_paranthesis right_paranthesis 
%token left_curly_bracket right_curly_bracket 
%token if_keyword 
%token for_keyword do_keyword while_keyword 
%token idf cst
%start s
%%
s: import_part program_keyword idf declaration_keyword declaration_part begin_keyword body end_keyword {printf("syntax is correct"); YYACCEPT;}
;


import_part: single_import import_part 
           | /* epsilon */
;
single_import: import_keyword library libraries semicolon
;
library: math_library 
       | lang_library
;
libraries: comma library libraries
		 | /* epsilon */
;


declaration_part: type_keyword variable variables semicolon
;
type_keyword: int_keyword 
			| float_keyword 
			| char_keyword
;
variable: idf
;
variables: comma idf variables 
         | /* epsilon */
;


body: assignment body
	| /* epsilon */ 
;

assignment: idf assignment_op expression semicolon	
;


expression: arithmetic_exp 
          | logic_exp
;
exp: idf 
   | cst;


arithmetic_exp: arithmetic_exp1 arithmetic_exp_prime
;
arithmetic_exp_prime: plus_op arithmetic_exp1 arithmetic_exp_prime 
                    | minus_op arithmetic_exp1 arithmetic_exp_prime 
					| /* epsilon */
;


arithmetic_exp1: arithmetic_exp2 arithmetic_exp1_prime
;
arithmetic_exp1_prime: multiplication_op arithmetic_exp2 arithmetic_exp1_prime 
                     | devision_op arithmetic_exp2 arithmetic_exp1_prime 
					 | /* epsilon */
;
arithmetic_exp2: exp 
               | left_paranthesis arithmetic_exp right_paranthesis
;


logic_exp: logic_exp or_keyword logic_exp1 
         | logic_exp and_keyword logic_exp1 
		 | logic_exp1
;
logic_exp1: logic_exp2 logic_exp1_prime
;
logic_exp1_prime: equal_op logic_exp2 logic_exp1_prime 
				| different_op logic_exp2 logic_exp1_prime 
				| great_equal_op logic_exp2 logic_exp1_prime 
				| great_op logic_exp2 logic_exp1_prime 
				| small_equal_op logic_exp2 logic_exp1_prime 
				| small_op logic_exp2 logic_exp1_prime 
				| /* epsilon */
;
logic_exp2: exp 
          | left_paranthesis logic_exp right_paranthesis
;

%%
main()
{
yyparse();
}
