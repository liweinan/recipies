//
//  main.c
//  algorithm
//
//  Created by Weinan Li on 7/20/13.
//  Copyright (c) 2013 Weinan Li. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    unsigned int size;
    unsigned char *rep;
} huge;

void left_shift(char* val) {
	int val_size = strlen(val);
	int i = val_size;
	int old_carry, carry = 0;
	while (i) {
		i--;
		old_carry = carry;
		carry = (val[i] << 1) | old_carry;
		val[i] = val[i] <<  1;
	}
	
	if (carry) {
		// expand val;
	}
}

void contract (huge *h) {
    int i = 0;
    while (!(h->rep[i]) && (i<h->size)) { i++; }
    
    if (i && i<h->size) {
        unsigned char *tmp = &h->rep[i];
        
        h->rep = (unsigned char*) calloc(h->size-i, sizeof(unsigned char));
        memcpy(h->rep, tmp, h->size-i);
        
        
    }
}

int compare(huge *h1, huge *h2) {
    int i;
    
    if (h1->size > h2->size) {
        return 1;
    }
    
    if (h1->size < h2->size) {
        return -1;
    }
    
    i=0;
    
    while (i<h1->size &&  i<h2->size) {
        if (h1->rep[i] < h2->rep[i]) {
            return -1;
        } else if (h1->rep[i] > h2->rep[i]) {
            return 1;
        }
        i++;
    }
    return 0;
}

void set_huge(huge *h, unsigned int val) {
    unsigned int mask, i, shift;
    h->size = 4;
    
    for (mask = 0xFF000000; mask > 0x000000FF; mask >>= 8) {
        if (val & mask) {
            break;
        }
        h->size--;
    }
    
    h->rep = (unsigned char*) malloc(h->size);
    
    mask =  0x000000FF;
    shift = 0;
    for (i=h->size; i; i--) {
        h->rep[i-1] = (val & mask) >> shift;
        mask <<= 8;
        shift += 8;
    }
}

void divide(huge *dividend, huge *divisor, huge *quotient) {
    int bit_size, bit_position;
    
    bit_size = bit_position = 0;
    
    while (compare(divisor, dividend) < 0) {
        left_shift(divisor);
        bit_size++;
    }
    
    quotient->size = (bit_size / 8) + 1;
    quotient->rep = (unsigned char *) calloc(quotient->size, sizeof(unsigned char));
    memset(quotient->rep, 0, quotient->size);
    
    bit_position = 8 - (bit_size % 8) - 1;
    
    do {
        
    } while (bit_size--);
}

int main(int argc, const char * argv[])
{
    int i;
    huge *h1 = malloc(sizeof(huge));
    huge *h2 = malloc(sizeof(huge));
    
    set_huge(h1, 1032); // 0000 0100 0000 1000
    set_huge(h2, 1033); // 0000 0100 0000 1001
    
    printf("h1->size: %d\n", h1->size);
    
    for (i=0; i<h1->size; i++) {
        printf("%d ", h1->rep[i]);
    }
    
    printf("\n");
    printf("cmp h1 h2: %d\n", compare(h1, h2));
    printf("cmp h1 h1: %d\n", compare(h1, h1));
    printf("cmp h1 h1: %d\n", compare(h2, h1));
    
    return 0;
}

