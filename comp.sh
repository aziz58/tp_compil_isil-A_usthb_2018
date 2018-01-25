 flex lexic.l;bison -d synt.y;gcc lex.yy.c synt.tab.c -o compil;./compil < INPUT.txt
