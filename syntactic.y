%{
#include <stdio.h>

extern int line_number;
void yyerror(char* message)
{
    printf("syntax error, line %d : %s", line_number, message);
}
int yylex(void);
%}

// Define types used in rules
%union {
 int Integer;
 float Float;
 char* str;
}

// Token types
%token <str>idf <Integer>csti <Float>cstf str


// Token declarations
%token program_keyword begin_keyword end_keyword declaration_keyword
%token import_keyword io_library lang_library
%token final_keyword
%token int_keyword float_keyword char_keyword 
%token semicolon pipe
%token equal_op small_equal_op great_equal_op great_op small_op different_op 
%token and_keyword or_keyword not_keyword
%token assignment_op plus_op minus_op multiplication_op devision_op 
%token left_paranthesis right_paranthesis
%token left_bracket right_bracket  
%token if_keyword else_keyword endif_keyword
%token for_keyword do_keyword endfor_keyword


// Define operator precedence and associativity
//%left plus_op minus_op
%left multiplication_op devision_op
%nonassoc equal_op different_op great_op small_op small_equal_op great_equal_op

// Start rule
%start s
%%
s: import_part program_keyword idf declaration_keyword declaration_part begin_keyword body end_keyword { printf("syntax is correct\n"); YYACCEPT; }
 ;

import_part: single_import import_part 
           | /* epsilon */
 ;
single_import: import_keyword library libraries semicolon
 ;
library: io_library 
       | lang_library
 ;
libraries: pipe library libraries
         | /* epsilon */
 ;

declaration_part: declaration_variable declaration_part
                | declaration_constant declaration_part
                | /* epsilon */
 ;

declaration_constant: final_keyword type_keyword idf assignment_op cst semicolon
 ;

declaration_variable: type_keyword variable variables semicolon
 ;
type_keyword: int_keyword 
            | float_keyword 
            | char_keyword
 ;
variable: idf 
        | array
 ;
array: idf left_bracket csti right_bracket
;
variables: pipe idf variables 
         | /* epsilon */
 ;

body: assignment body
    | if_condition body
    | for_loop body
    | /* epsilon */ 
 ;

assignment: idf assignment_op expression semicolon    
 ;

expression: arithmetic_exp 
          | logic_exp
 ;

cst: cstf
   | csti
 ;

arithmetic_exp: arithmetic_exp plus_op arithmetic_exp1
              | arithmetic_exp minus_op arithmetic_exp1
              | arithmetic_exp1
 ;

arithmetic_exp1: arithmetic_exp1 multiplication_op arithmetic_exp2
               | arithmetic_exp1 devision_op arithmetic_exp2
               | arithmetic_exp2
 ;

arithmetic_exp2: idf
               | cst
               | left_paranthesis arithmetic_exp right_paranthesis
 ;

logic_exp: comparison_exp
         | logic_exp and_keyword comparison_exp
         | logic_exp or_keyword comparison_exp
 ;

comparison_exp: arithmetic_exp comparison_op arithmetic_exp
              | left_paranthesis comparison_exp right_paranthesis
              | not_keyword comparison_exp
 ;

comparison_op: equal_op
             | different_op
             | great_equal_op
             | great_op
             | small_equal_op
             | small_op
 ;

if_condition: if_keyword left_paranthesis logic_exp right_paranthesis do_keyword body if_condition_prime
 ;

if_condition_prime: endif_keyword
                  | else_keyword body endif_keyword
 ;

for_loop: for_keyword left_paranthesis for_initialization semicolon logic_exp semicolon for_update right_paranthesis do_keyword body endfor_keyword
 ;
for_initialization: idf assignment_op arithmetic_exp
 ;
for_update: idf assignment_op arithmetic_exp
 ;

%%
main()
{
yyparse();
}
