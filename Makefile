all:
	bison -y -d lexyacc-code/calc3.y --output=lexyacc-code/y.tab.c
	flex -o lexyacc-code/lex.yy.c lexyacc-code/calc3.l
	gcc -c lexyacc-code/y.tab.c -o lexyacc-code/y.tab.o
	gcc -c lexyacc-code/lex.yy.c -o lexyacc-code/lex.yy.o
	gcc lexyacc-code/y.tab.o lexyacc-code/lex.yy.o lexyacc-code/calc3i.c -o bin/calc3i.exe

clean:
	rm -rf lexyacc-code/lex.yy.c lexyacc-code/y.tab.c lexyacc-code/y.tab.h lexyacc-code/lex.yy.o lexyacc-code/y.tab.o bin/calc3i.exe