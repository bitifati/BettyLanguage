%{
int line_number=1;
int column_number=0;
%}
%token semicolon comma 
equal_op small_equal_op great_equal_op great_op small_op different_op 
assignment_op plus_op minus_op multiplication_op devision_op 
left_paranthesis right_paranthesis 
left_curly_bracket right_curly_bracket 
if_keyword for_keyword do_keyword while_keyword 
idf cst
%%
s: idf assignment_op cst semicolon {printf("syntax is correct"); yyaccept;}
%%
main()
{
yyparse();
}
yywrap(){}
int yyerror(char* message)
{
printf("syntactic error, line %d, column %d \n", line_number, column_number);