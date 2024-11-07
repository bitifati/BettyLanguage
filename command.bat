flex lexical.l
bison -d syntactic.y
gcc lexical.yy.c syntactic.tab.c -lfl -ly -o Betty.exe