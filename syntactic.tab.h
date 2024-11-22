
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
     declaration_keyword = 261,
     import_keyword = 262,
     io_library = 263,
     lang_library = 264,
     int_keyword = 265,
     float_keyword = 266,
     char_keyword = 267,
     semicolon = 268,
     comma = 269,
     equal_op = 270,
     small_equal_op = 271,
     great_equal_op = 272,
     great_op = 273,
     small_op = 274,
     different_op = 275,
     and_keyword = 276,
     or_keyword = 277,
     not_keyword = 278,
     assignment_op = 279,
     plus_op = 280,
     minus_op = 281,
     multiplication_op = 282,
     devision_op = 283,
     left_paranthesis = 284,
     right_paranthesis = 285,
     left_curly_bracket = 286,
     right_curly_bracket = 287,
     if_keyword = 288,
     for_keyword = 289,
     do_keyword = 290,
     while_keyword = 291,
     idf = 292,
     cst = 293
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


