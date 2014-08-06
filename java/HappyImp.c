// http://codingmaadi.blogspot.com/2012/08/jni-step-by-step-tutorial-on-os-x-with.html
// cc -v -c -fPIC -I /System/Library/Frameworks/JavaVM.framework/Versions/A/Headers/ HappyImp.c -o libHappy.o
// libtool -dynamic -lSystem libHappy.o -o libHappy.dylib
// export LD_LIBRARY_PATH=.
// java Happy

#include "Happy.h"
#include <stdio.h>

JNIEXPORT void JNICALL Java_Happy_printText (JNIEnv *env, jobject obj) {
	printf("Hello, world!\n");
}