
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     idf = 258,
     csti = 259,
     cstf = 260,
     string = 261,
     program_keyword = 262,
     begin_keyword = 263,
     end_keyword = 264,
     declaration_keyword = 265,
     import_keyword = 266,
     io_library = 267,
     lang_library = 268,
     final_keyword = 269,
     int_keyword = 270,
     float_keyword = 271,
     char_keyword = 272,
     semicolon = 273,
     pipe = 274,
     equal_op = 275,
     small_equal_op = 276,
     great_equal_op = 277,
     great_op = 278,
     small_op = 279,
     different_op = 280,
     and_keyword = 281,
     or_keyword = 282,
     not_keyword = 283,
     assignment_op = 284,
     plus_op = 285,
     minus_op = 286,
     multiplication_op = 287,
     devision_op = 288,
     left_paranthesis = 289,
     right_paranthesis = 290,
     left_bracket = 291,
     right_bracket = 292,
     if_keyword = 293,
     else_keyword = 294,
     endif_keyword = 295,
     for_keyword = 296,
     do_keyword = 297,
     endfor_keyword = 298
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 13 "syntactic.y"

 int Integer;
 float Float;
 char* str;



/* Line 1676 of yacc.c  */
#line 103 "syntactic.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


