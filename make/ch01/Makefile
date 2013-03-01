cw: cw.o lexer.o -lfl
	gcc cw.o lexer.o -lfl -ocw

cw.o: cw.c
	gcc -c cw.c

lexer.o: lexer.c
	gcc -c lexer.c

lexer.c: lexer.l
	flex -t lexer.l > lexer.c