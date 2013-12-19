default: vis_lib

vis_lib: vis_base
	gcc -g -shared -o vis.so vis_comm.o vis_1.o -Wl,--version-script,vis.map

vis_base: vis_comm.c vis_1.c
	gcc -g -c -fPIC -Wall vis_comm.c vis_1.c


