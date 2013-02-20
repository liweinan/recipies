struct t_linked_list {
	int val;
	struct linked_list *next;
}

typedef struct t_linked_list node;

/* create a new linked list with initial value */
node* create(val);

/* insert a new value into linked list */
node* insert(int val);

/* remove a node from list */
void remove(node* n);

/* print out the whole string */
void to_string();