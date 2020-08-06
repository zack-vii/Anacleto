
#include <stdlib.h>
#include <unistd.h>

#include "usermem.h"

int main(int argc, char *argv[])
{
	usermem_t *dev = usermem_open(NULL);
	if (!dev)
		exit(-1);
	int i;
	for (i = 0 ; i <= 255 ; i++)
	{
		dev->buf[8] = i;
		usleep(10000);
	}
	dev->buf[8] = 0;
	exit(usermem_close(dev));
}
