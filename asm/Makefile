default: xlat xlat2 sandbox push_esp shift_bits hello inline_data macro_label stosb loop movsb nested_loop argnum boiler puts
sandbox: sandbox.o
	ld -o sandbox sandbox.o
sandbox.o: sandbox.asm
	nasm -f elf -g -F stabs sandbox.asm -l sandbox.lst
push_esp: push_esp.o
	ld -o push_esp push_esp.o
push_esp.o: push_esp.asm
	nasm -f elf -g -F stabs push_esp.asm -l push_esp.lst
shift_bits: shift_bits.o
	gcc -g -o shift_bits shift_bits.o
shift_bits.o: shift_bits.asm
	nasm -f elf -g -F stabs shift_bits.asm -l shift_bits.lst
hello: hello.o
	gcc -o hello hello.o
hello.o: hello.asm
	nasm -f elf -l hello.lst  hello.asm
xlat: xlat.o
	ld -o xlat xlat.o
xlat.o: xlat.asm
	nasm -f elf -g -F stabs -l xlat.lst xlat.asm
xlat2: xlat2.o
	ld -o xlat2 xlat2.o
xlat2.o: xlat2.asm
	nasm -f elf -g -F stabs -l xlat2.lst xlat2.asm
inline_data: inline_data.o
	ld -o inline_data inline_data.o
inline_data.o: inline_data.asm
	nasm -f elf -g -F stabs -l inline_data.lst inline_data.asm
macro_label: macro_label.o
	ld -o macro_label macro_label.o
macro_label.o: macro_label.asm macro_lib.mac
	nasm -f elf -g -F stabs -l macro_label.lst macro_label.asm
stosb: stosb.o
	ld -o stosb stosb.o
stosb.o: stosb.asm
	nasm -f elf -g -F stabs -l stosb.lst stosb.asm
loop: loop.o libs.o
	ld -o loop loop.o libs.o
loop.o: loop.asm
	nasm -f elf -g -F stabs -l loop.lst loop.asm
libs.o: libs.asm
	nasm -f elf -g -F stabs -l libs.lst libs.asm
movsb: movsb.o libs.o
	ld -o movsb movsb.o libs.o
movsb.o: movsb.asm
	nasm -f elf -g -F stabs -l movsb.lst movsb.asm
nested_loop: nested_loop.o libs.o
	ld -o nested_loop nested_loop.o libs.o
nested_loop.o: nested_loop.asm libs.asm
	nasm -f elf -g -F stabs -l nested_loop.lst nested_loop.asm
argnum: argnum.o libs.o
	ld -o argnum argnum.o libs.o
argnum.o: argnum.asm libs.asm
	nasm -f elf -g -F stabs -l argnum.lst argnum.asm
boiler: boiler.o
	gcc boiler.o -o boiler
boiler.o: boiler.asm
	nasm -f elf -g -F stabs boiler.asm
clean:
	rm *.lst *.o .*.swp
puts: puts.o
	gcc puts.o -o puts
puts.o: puts.asm
	nasm -f elf -g -F stabs puts.asm
