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
	for (i=0; i<3; i++) {
		printf("%c ", p[i]);
	}
	
	char *g = malloc(sizeof(char));
	
	memcpy(g, p, 1);
	printf("\n%c\n", *g);
	
	write_str_to_file(p, "/tmp/out");
// 	little endian
// 	mini:c weinanli$ od -ch /tmp/out
// 0000000    a   b   c
//              6261    0063
// 0000003
	
    return 0;
}
