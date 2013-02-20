#include<stdio.h>
#include<unistd.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>

int main()
{
	int fd=0,ret=0;
	char buff[80]="";
	
	fd=open("/dev/cdev_rw0",O_RDONLY);
	
	printf("fd :%d\n",fd);
	
	ret=read(fd,buff,10);
	buff[ret]='\0';
	
	printf("buff: %s ;length: %d bytes\n",buff,ret);
	close(fd);
}

