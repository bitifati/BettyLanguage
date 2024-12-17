%{
#include <stdio.h>

char suavType [20];
char suavbib [20];
char suavbib1 [20];

extern int line_number;
extern char* getValByIdf(char* idf);  // Declaration of getValByIdf function
extern char* floatToString(float number);
extern char* integerToString(int number);
//extern void fillCategory(char* idf, int val);
extern void insererConstant(char entite[], int val);

extern void assignValueToVar(char entite[], char val[]);

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
%token <str>idf 
%token <Integer>csti 
%token <Float>cstf 
%token <str>string //  i will use string later


// Token declarations
%token program_keyword begin_keyword end_keyword declaration_keyword
%token import_keyword io_library lang_library
%token final_keyword
%token <str>int_keyword <str>float_keyword <str>char_keyword <str>bool_keyword
%token semicolon pipe_keyword
%token <str>equal_op <str>small_equal_op <str>great_equal_op <str>great_op <str>small_op <str>different_op 
%token and_keyword or_keyword not_keyword
%token assignment_op plus_op minus_op multiplication_op devision_op 
%token left_paranthesis right_paranthesis
%token left_bracket right_bracket
%token <Integer>true_keyword <Integer>false_keyword;  
%token if_keyword else_keyword endif_keyword
%token for_keyword do_keyword endfor_keyword


// Define operator precedence and associativity
%left plus_op minus_op
%left multiplication_op devision_op
%nonassoc equal_op different_op great_op small_op small_equal_op great_equal_op


%type<Float> arithmetic_exp arithmetic_exp1 arithmetic_exp2 cst

%type <Integer>comparison_exp logic_exp
%type <str> comparison_op

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
libraries: pipe_keyword library libraries
         | /* epsilon */
;

declaration_part: declaration_variable declaration_part
                | declaration_constant declaration_part
                | /* epsilon */
;

/*
declaration_constant: final_keyword type_keyword idf assignment_op cst semicolon {
    if (doubleDeclaration($3)==0) {
        insererType($3,suavType); 
        fillCategory($3, 1);
    } else{
        printf("erreur Semantique: double declaration de %s, a la ligne %d \n", $1, line_number);
    } 
}
;
*/

declaration_constant: final_keyword type_keyword idf assignment_op cst semicolon {
    if (doubleDeclaration($3) == 0) {
        insererType($3, suavType);  // Insère l'identifiant dans la table des symboles avec son type
        insererConstant($3, 1);        // Marque l'identifiant comme constant ("true")
    } else {
        printf("Erreur Sémantique : double déclaration de %s à la ligne %d\n", $3, line_number);
    }
}
;



declaration_variable: type_keyword variable variables semicolon
;
type_keyword: int_keyword {strcpy(suavType,$1); }
            | float_keyword {strcpy(suavType,$1); }
            | char_keyword {strcpy(suavType,$1); }
			| bool_keyword {strcpy(suavType,$1); }
;
variable: idf { 
    if(doubleDeclaration($1)==0){ 
        insererType($1, suavType);
    } else{
        printf("erreur Semantique: double declaration de %s, a la ligne %d \n", $1, line_number);
    } 
}
        | array 
;
array: idf left_bracket csti right_bracket { 
    if (doubleDeclaration($1)==0) {
        insererType($1,suavType); 
    } else {
        printf("erreur Semantique: double declation de %s, a la ligne %d \n", $1, line_number);
    }  
}
;
variables: pipe_keyword idf variables { if(doubleDeclaration($2)==0){ insererType($2, suavType); }else{printf("erreur Semantique: double declaration de %s, a la ligne %d \n", $2, line_number);} }
         | /* epsilon */
;

body: assignment_arithmetic body
    | assignment_string body
    | assignment_logic body
    | if_condition body
    | for_loop body
    | /* epsilon */ 
;

assignment_string: idf assignment_op string semicolon {
    assignValueToVar($1, $3);
}
;



assignment_arithmetic: idf assignment_op arithmetic_exp semicolon {
    char* value = floatToString($3);  // Convert result to string
    assignValueToVar($1, value);    // Assign value to variable in the symbol table
    free(value);                   // Free dynamically allocated memory
}
;






/*
expression: arithmetic_exp {}
          | logic_exp {$$ = $1;}
;
*/


cst: cstf { $$ = $1; }  // Valeur flottante
   | csti { $$ = (float)$1; } // Conversion explicite en flottant
;


arithmetic_exp: arithmetic_exp plus_op arithmetic_exp1 { $$ = $1 + $3; }
              | arithmetic_exp minus_op arithmetic_exp1 { $$ = $1 - $3; }
              | arithmetic_exp1 { $$ = $1; }
;




arithmetic_exp1: arithmetic_exp1 multiplication_op arithmetic_exp2 { $$ = $1 * $3; }
               | arithmetic_exp1 devision_op arithmetic_exp2 {
                   if ($3 == 0) {
                       printf("Erreur ligne : %d : division par zéro\n", line_number);
                       //YYABORT;  // Stop parsing
                   } else {
                       $$ = $1 / $3;
                   }
               }
               | arithmetic_exp2 { $$ = $1; }
;




arithmetic_exp2: idf {
                    char* value = getValByIdf($1);
                    if (value == NULL || strcmp(value, "Null") == 0) {
                        printf("Erreur : L'identifiant '%s' non initialisé à la ligne %d\n", $1, line_number);
                        //YYABORT;
                    } else {
                        $$ = atof(value);  // Convert string value to float
                    }
                }
               | cst { $$ = $1; }  // Constant (integer or float)
               | left_paranthesis arithmetic_exp right_paranthesis { $$ = $2; }
;


assignment_logic: idf assignment_op logic_exp semicolon {
    char* value = integerToString($3);
    assignValueToVar($1, value);    // Assign value to variable in the symbol table
    free(value);
}
;

logic_exp: comparison_exp { $$ = $1}
         | logic_exp and_keyword comparison_exp { $$ = $1 && $3;}
         | logic_exp or_keyword comparison_exp { $$ = $1 || $3; }
;

comparison_exp: arithmetic_exp comparison_op arithmetic_exp { $$ = compare($1, $2, $3); }
              | left_paranthesis comparison_exp right_paranthesis { $$ = $2; }
              | not_keyword comparison_exp { $$ = !$2; }
			  | true_keyword { $$ = 1; }
			  | false_keyword {$$ = 0; }
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
main(){
    initialization();
    yyparse();
    afficher();
}
yywrap()
{}


