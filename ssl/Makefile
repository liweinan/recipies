huge: huge.c huge.h
	cc -g -DHUGE_MAIN -o huge huge.c
	
rsa: rsa.c huge.h huge.c
	cc -g -DRSA_MAIN -o rsa rsa.c huge.c
	
clean:
	rm -rf huge

.PHONY: clean