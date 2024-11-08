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
%token assignment_op plus_op minus_op multiplication_op devision_op 
%token left_paranthesis right_paranthesis 
%token left_curly_bracket right_curly_bracket 
%token if_keyword 
%token for_keyword do_keyword while_keyword 
%token idf cst
%%
s: list_import program | program {printf("syntax is correct"); YYACCEPT;}; 
 
list_import: single_import | single_import list_import
;
single_import: import_keyword libraries semicolon
;
libraries: library_keyword | library_keyword comma libraries
;

program: program_keyword begin_keyword body end_keyword
;

body: var_declaration 
;
var_declaration: list_var | list_var var_declaration

list_var: type_var variables semicolon
;
type_var: int_keyword | float_keyword | char_keyword
;
variables: idf | idf comma variables
;

%%
main()
{
yyparse();
}
