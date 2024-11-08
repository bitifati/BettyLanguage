flex lexical.l
bison -d syntactic.y
gcc lex.yy.c syntactic.tab.c -lfl -ly -o Betty.exe