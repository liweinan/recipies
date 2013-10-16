//
//  endian.c
//  algorithm
//
//  Created by Weinan Li on 7/22/13.
//  Copyright (c) 2013 Weinan Li. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lib/common.h"

int main(void) {
	int i = 0;
	char *p = "abc";
	char c[4];
	
	for (i=0; i<3; i++) {
		printf("p[%d]:%c ", i, p[i]);
	}
	printf("\np:%s sizeof(p):%d sizeof(*p):%d\n", p, (int) sizeof(p), (int) sizeof(*p));
		
	c[0]='a';
	c[1]='b';
	c[2]='c';
	c[3]='\0';
	
	printf("c:%s size:%d\n", c, (int)sizeof(c));
	
	char *g = malloc(sizeof(char));	
	memcpy(g, p, 1);
	printf("g:%c\n", *g);	
	write_str_to_file(p, "/tmp/out");
// 	little endian
// 	mini:c weinanli$ od -ch /tmp/out
// 0000000    a   b   c
//              6261    0063
// 0000003	
    return 0;
}
