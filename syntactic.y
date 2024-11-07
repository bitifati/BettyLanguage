%{
int line_number=1;
int column_number=0;
%}
%token semicolon comma assignment idf cst
%%
s: idf assignment cst semicolon {printf("syntax is correct"); yyaccept;}
%%
main()
{
yyparse();
}
yywrap(){}
int yyerror(char* message)
{
printf("syntactic error, line %d, column %d \n", line_number, column_number);