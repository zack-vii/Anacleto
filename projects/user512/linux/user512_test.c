
#include <stdlib.h>
#include <unistd.h>

#include "user512.h"

int main(int argc, char *argv[])
{
	user512_t *dev = user512_open(NULL);
	if (!dev)
		exit(-1);
	int i;
	for (i = 0 ; i <= 255 ; i++)
	{
		dev->raw[8] = i;
		usleep(10000);
	}
	dev->raw[8] = 0;
	exit(user512_close(dev));
}
