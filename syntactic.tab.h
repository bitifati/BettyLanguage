
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
     program_keyword = 258,
     begin_keyword = 259,
     end_keyword = 260,
     import_keyword = 261,
     library_keyword = 262,
     int_keyword = 263,
     float_keyword = 264,
     char_keyword = 265,
     semicolon = 266,
     comma = 267,
     equal_op = 268,
     small_equal_op = 269,
     great_equal_op = 270,
     great_op = 271,
     small_op = 272,
     different_op = 273,
     and_keyword = 274,
     or_keyword = 275,
     assignment_op = 276,
     plus_op = 277,
     minus_op = 278,
     multiplication_op = 279,
     devision_op = 280,
     left_paranthesis = 281,
     right_paranthesis = 282,
     left_curly_bracket = 283,
     right_curly_bracket = 284,
     if_keyword = 285,
     for_keyword = 286,
     do_keyword = 287,
     while_keyword = 288,
     idf = 289,
     cst = 290
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


