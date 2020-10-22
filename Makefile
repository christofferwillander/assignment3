all:
	mkdir -p lexyacc-code/build-dir
	bison -y -d lexyacc-code/calc3.y --output=lexyacc-code/build-dir/y.tab.c
	flex -o lexyacc-code/build-dir/lex.yy.c lexyacc-code/calc3.l
	gcc -c lexyacc-code/build-dir/y.tab.c -o lexyacc-code/build-dir/y.tab.o
	gcc -c lexyacc-code/build-dir/lex.yy.c -o lexyacc-code/build-dir/lex.yy.o
	gcc lexyacc-code/build-dir/y.tab.o lexyacc-code/build-dir/lex.yy.o lexyacc-code/calc3i.c -o bin/calc3i.exe
	gcc -g -shared src/*.s -o lib/libfunctions.so

clean:
	rm -rf lexyacc-code/build-dir bin/calc3i.exe lib/libfunctions.so