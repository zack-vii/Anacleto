#ifndef USER512_H
#define USER512_H

#include <linux/types.h>
#include <asm/ioctl.h>

#ifdef __cplusplus
extern "C" {
#endif

#define C_OK           0
#define C_DEV_ERROR    1
#define C_PARAM_ERROR  2

#define USER512_IOCTL_BASE	'W'
#define USER512_RESOFFSET _IO(USER512_IOCTL_BASE, 0)

#define DEVICE_NAME	"user512"  /* Dev name as it appears in /proc/devices */
#define MODULE_NAME	"user512"
#define MAX_SIZE	0x80000
typedef struct {
	char raw[MAX_SIZE];
} user512_t;

#ifndef __KERNEL__
// api functions here //

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <inttypes.h>

user512_t *const user512_open(const char *dev_file)
{
	int fd;
	if(dev_file)
		fd = open(dev_file, O_RDWR | O_SYNC);
	else
		fd = open("/dev/"DEVICE_NAME, O_RDWR | O_SYNC);
	if(fd < 0)
	{
		printf("ERROR: failed to open device file\n");
		return NULL;
	}
	user512_t *const dev = (user512_t*)mmap(NULL, MAX_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if(!dev)
		printf("ERROR: failed to mmap device memory\n");
	return dev;
}

const int user512_close(user512_t *const dev)
{
	if(dev)
		return munmap(dev, MAX_SIZE);
	return C_OK;
}

#endif // __KERNEL__

#ifdef __cplusplus
}
#endif
#endif
