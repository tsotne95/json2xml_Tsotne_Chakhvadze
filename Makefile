all: build
build:	
	flex parse.lex
	bison -y -d parse.y
	gcc y.tab.c lex.yy.c -o json2xml
clean:
	rm lex.yy.c y.tab.c y.tab.h
