default: vis_lib

vis_lib: vis_comm.o vis_1.o
	gcc -g -shared -o vis.so vis_comm.o vis_1.o -Wl,--version-script,vis.map

vis_comm.o: vis_comm.c
	gcc -g -c -fPIC -Wall vis_comm.c

vis_1.o: vis_1.c vis_comm.o
	gcc -g -c -fPIC -Wall vis_1.c
