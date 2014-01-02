default: vis_lib

vis_lib: vis_base
	gcc -g -shared -o vis.so vis_comm.o vis_1.o -Wl,--version-script,vis.map

vis_base: vis_comm.c vis_1.c
	gcc -g -c -fPIC -Wall vis_comm.c vis_1.c


vis_1.o: vis_1.c vis_comm.o
	gcc -g -c -fPIC -Wall vis_1.c

offset.o: offset.c
	gcc -g -c -fPIC -Wall offset.c

offset: offset.o
	readelf -s mod1.o | grep _GLOBAL_OFFSET_TABLE_

