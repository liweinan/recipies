typedef struct {
	unsigned int size;
	unsigned char *val;
} huge;

void add(huge *h1, huge *h2) {
	unsigned int i, j;
	unsigned int sum;
	unsigned int carry = 0;
	
	if (h2->size > h1->size) {
		unsigned char *tmp = h1->rep;
		h1->rep = (unsigned char*) calloc(h2->size, sizeof(unsigned char));
	}
}