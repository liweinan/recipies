#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

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
	int val=0;
	int cnt=0;
	char *p;
	int b[8];
	
	for (p = x; ((*p != '\0') && (cnt < 8)); p++) {		
		if (*p == '1') {
			b[cnt] = 1;
		} else if (*p == '0') {
			b[cnt] = 0;
		}
		cnt++;
	}
	
	int size = cnt;
	cnt = 0;
	while (cnt < (size-1)) {
		val += b[cnt] << size-cnt-1;
		cnt++;
	}
	
	val += b[size-1];

	return val;	
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

void right_shift(huge *h1) {
	int i;
	unsigned int old_carry, carry = 0;
	
	i = 0;
	
	do {
		old_carry = carry;
		carry = (h1->rep[i] & 0x01) << 7;
		h1->rep[i] = (h1->rep[i] >> 1) | old_carry;		
	} while (++i < h1->size);
	contract(h1);
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

void add(huge *h1, huge *h2) {
	unsigned int i, j;
	unsigned int sum;
	unsigned int carry = 0;
	
	if (h2->size > h1->size) {
		unsigned char *tmp = h1->rep;
		h1->rep = (unsigned char*) calloc(h2->size, sizeof(unsigned char));
		memcpy(h1->rep + (h2->size - h1->size), tmp, h1->size);
		h1->size = h2->size;
		free(tmp);
	}

	i = h1->size;
	j = h2->size;
	
	do {
		i--;
		if (j) {
			j--;
			sum = h1->rep[i] + h2->rep[j] + carry;
		} else {
			sum = h1->rep[i] + carry;
		}	
		
		carry = sum > 0xFF;
		h1->rep[i] = sum;
	} while (i);
	
	if (carry) {
		expand(h1);
	}
}

void subtract(huge *h1, huge *h2) {
	int i = h1->size;
	int j = h2->size;
	
	int difference;
	
	unsigned int borrow = 0;
	
	do {
		i--;
		if (j) {
			j--;
			difference = h1->rep[i] - h2->rep[j] - borrow;
		} else {
			difference = h1->rep[i] - borrow;
		}
		
		borrow = (difference < 0);
		h1->rep[i] = difference;
	} while (i);
	
	if (borrow && i) {
		if (!(h1->rep[i-1])) {
			printf("Error, subtraction result is negative\n");
			exit(0);
		}
		h1->rep[i-1]--;
	}
	
	contract(h1);
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
      		subtract(dividend, divisor);
    		quotient->rep[(int) (bit_position / 8)] |= (0x80 >> (bit_position % 8));
    	}
    	
		if (bit_size) {
 			right_shift(divisor);
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
	char *p1 = "0";
	char *p2 = "1";
	char *p3 = "10";
	char *p4 = "11";
	char *p5 = "100";
	char *p6 = "101";
	char *p7 = "110";
	char *p8 = "111";

	printf("binary_to_byte(%s): %s\n", p1, byte_to_binary(binary_to_byte(p1)));
	printf("binary_to_byte(%s): %s\n", p2, byte_to_binary(binary_to_byte(p2)));
	printf("binary_to_byte(%s): %s\n", p3, byte_to_binary(binary_to_byte(p3)));
	printf("binary_to_byte(%s): %s\n", p4, byte_to_binary(binary_to_byte(p4)));
	printf("binary_to_byte(%s): %s\n", p5, byte_to_binary(binary_to_byte(p5)));
	printf("binary_to_byte(%s): %s\n", p6, byte_to_binary(binary_to_byte(p6)));
	printf("binary_to_byte(%s): %s\n", p7, byte_to_binary(binary_to_byte(p7)));
	printf("binary_to_byte(%s): %s\n", p8, byte_to_binary(binary_to_byte(p8)));
	
	assert(0 == binary_to_byte(p1));
	assert(1 == binary_to_byte(p2));
	assert(2 == binary_to_byte(p3));
	assert(3 == binary_to_byte(p4));
	assert(4 == binary_to_byte(p5));
	assert(5 == binary_to_byte(p6));
	assert(6 == binary_to_byte(p7));
	assert(7 == binary_to_byte(p8));
}

void test_add() {
}

#ifdef MAIN
int main(int argc, const char * argv[]) {
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
    
    test_add();
    return 0;
}
#endif

