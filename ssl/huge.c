#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* byte_to_binary(int x) {
  static char b[9];
  b[0] = '\0'; // strcat will override it

  int z;
  // 2^7 = 128. 8 bits
  for (z = 128; z > 0; z >>= 1) {
	strcat(b, ((x & z) == z) ? "1" : "0");
  }

  return b;
}

const int binary_to_byte(char* x) {
	int ret;
	int cnt = 0;
	char *p;
	int b[8];
	
	for (p = x; ((*p != '\0') && (cnt < 8)); p++) {		
		if (*p == '1') {
			printf("1");
			b[cnt] = 1;
		} else if (*p == '0') {
			printf("0");
			b[cnt] = 0;
		}
		cnt++;
	}
	
	int size = cnt;
	while (cnt >= 0) {
		ret += b[size - cnt] << cnt;
		cnt--;
	}
	
	printf("\n");
	return ret;	
}

typedef struct {
    unsigned int size;
    unsigned char *rep;
} huge;

void expand(huge *h) {
	unsigned char *tmp = h->rep;
	h->size++;
	h->rep = (unsigned char *) calloc (h->size, sizeof(unsigned char));
	memcpy(h->rep+1, tmp, (h->size - 1) * sizeof(unsigned char));
	h->rep[0]=0x01;
	free(tmp);
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

void left_shift(huge *h1) {
	int i;
	int old_carry, carry = 0;
	
	i = h1->size;
	
	do {
		i--;
		old_carry = carry;
		// 1|0 2|0 4|0 8|0 10|0 20|0 40|0 80|128
		carry = (h1->rep[i] & 0x80) == 0x80;
		h1->rep[i] = (h1->rep[i]<<1) | old_carry;
	} while (i);
	
	if (carry) {
		expand(h1);
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
    	if (compare(divisor, dividend) <= 0) {
//      		subtract(dividend, divisor);
    		quotient->rep[(int) (bit_position / 8)] |= (0x80 >> (bit_position % 8));
    	}
    	
		if (bit_size) {
// 			right_shift(divisor);
		}
		bit_position++;    	
        
    } while (bit_size--);
}

void print_huge(huge *h) {
	int i;
    
    for (i=0; i<h->size; i++) {
        printf("%s ", byte_to_binary(h->rep[i]));
    }    
    printf("\n");
}

void test_shift_logic() {
	//j 1|0 2|0 4|0 8|0 10|0 20|0 40|0 80|128
    printf("\nj ");
    int j;
    for (j=1; j<=0x80; j = j << 1) {
    	printf("%x|%d ", j, j&0x80);
    }
    printf("\n");
}

void test_expand(huge *h) {
	printf("\n## TEST-EXPAND ##\n");
	
	int i;
	for (int i=0; i<8; i++) {
		print_huge(h);
		left_shift(h);
	}
}

void test_binary_to_byte() {
	char *p = "111100001";
	char *q = "1010";
	binary_to_byte(p);

	printf("binary_to_byte(1010): %d\n", binary_to_byte(q));
}

int main(int argc, const char * argv[])
{
    huge *h1 = malloc(sizeof(huge));
    huge *h2 = malloc(sizeof(huge));
    
    set_huge(h1, 1032); // 00000100 00001000
    set_huge(h2, 1033); // 00000100 00001001
    
    print_huge(h1);
    print_huge(h2);
    
    printf("cmp h1 h2: %d\n", compare(h1, h2));
    printf("cmp h1 h1: %d\n", compare(h1, h1));
    printf("cmp h1 h1: %d\n", compare(h2, h1));
    
    while (compare(h1, h2) < 0) {
        left_shift(h1);
        printf("left_shift(h1)\n");
    }
    
    print_huge(h1);
    printf("cmp h1 h2: %d\n", compare(h1, h2));    
    
    test_shift_logic();
    
    expand(h2);
    print_huge(h2);
    
    test_expand(h1);
    
    test_binary_to_byte();
    return 0;
}

