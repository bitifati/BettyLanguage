%{
#include <stdio.h>
extern int line_number;
void yyerror(char* message)
{
printf("syntax error, line %d : %s",line_number, message);
}
int yylex(void);
%}
%token program_keyword begin_keyword end_keyword 
%token import_keyword library_keyword 
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
s: list_import program | program {printf("syntax is correct"); YYACCEPT;}
;


list_import:  | list_import single_import
;
single_import: import_keyword libraries semicolon
;
libraries: library_keyword | comma library_keyword libraries
;


program: program_keyword begin_keyword body end_keyword
;


body: var_declaration | assignment
;


var_declaration:  | var_declaration list_var
;
list_var: type_var variables semicolon
;
type_var: int_keyword | float_keyword | char_keyword
;
variables: idf | variables comma idf
;


assignment: idf assignment_op expression semicolon | idf assignment_op expression semicolon body
;
expression: arithmetic_exp | logic_exp
;
exp: idf | cst;


arithmetic_exp: arithmetic_exp1 arithmetic_exp_prime
;
arithmetic_exp_prime: plus_op arithmetic_exp1 arithmetic_exp_prime | minus_op arithmetic_exp1 arithmetic_exp_prime | /* epsilon */
;
arithmetic_exp1: arithmetic_exp2 arithmetic_exp1_prime
;
arithmetic_exp1_prime: multiplication_op arithmetic_exp2 arithmetic_exp1_prime | devision_op arithmetic_exp2 arithmetic_exp1_prime | /* epsilon */
;
arithmetic_exp2: exp | left_paranthesis arithmetic_exp right_paranthesis
;


logic_exp: logic_exp or_keyword logic_exp1 | logic_exp and_keyword logic_exp1 | logic_exp1
;
logic_exp1: logic_exp2 logic_exp1_prime
;
logic_exp1_prime: equal_op logic_exp2 logic_exp1_prime | different_op logic_exp2 logic_exp1_prime | great_equal_op logic_exp2 logic_exp1_prime | great_op logic_exp2 logic_exp1_prime | small_equal_op logic_exp2 logic_exp1_prime | small_op logic_exp2 logic_exp1_prime | /* epsilon */
;
logic_exp2: exp | left_paranthesis logic_exp right_paranthesis
;


%%
main()
{
yyparse();
}
