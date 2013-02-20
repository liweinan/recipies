#include <stdio.h>

#define OP_EXIT 0
#define OP_1 0x1
#define OP_2 0x2
#define DISPATCH() goto *dispatch_table[instructions[pc++]]

int main() {
	
	static void* dispatch_table[] = {
	    &&do_exit, &&do_op1, &&do_op2 }; // sequence must be the same with #define OP_*
	
	int instructions[] = { OP_1, OP_2, OP_EXIT };
	int pc  = 0;
	
	DISPATCH();
	while(1) {
		do_exit: // default must be in a switch so it cannot be used.
			printf("exit\n");
			return 0;
		do_op1:
			printf("op1\n");
			DISPATCH();
		do_op2:
			printf("op2\n");
			DISPATCH();
	}
	
	return 0;
    
}