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

#define DEVICE_NAME	"usermem"  /* Dev name as it appears in /proc/devices */
#define MODULE_NAME	"usermem"
#define USERMEM_SIZE	0x400000
#define USERMEM(name)	char name[USERMEM_SIZE]
typedef struct {
	USERMEM(buf);
} usermem_t;

#ifndef __KERNEL__
// api functions here //

#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <inttypes.h>

usermem_t *const usermem_open(const char *dev_file)
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
	usermem_t *const dev = (usermem_t*)mmap(NULL, USERMEM_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
	if(!dev)
		printf("ERROR: failed to mmap device memory\n");
	return dev;
}

const int usermem_close(usermem_t *const dev)
{
	if(dev)
		return munmap(dev, USERMEM_SIZE);
	return C_OK;
}

#endif // __KERNEL__

#ifdef __cplusplus
}
#endif
#endif
