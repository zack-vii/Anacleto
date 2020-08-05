#pragma once
#include "user512.h"

#ifdef __cplusplus
extern "C" {
#endif

#define STATUS_MASK    254 // 11111110
#define IDLE             6 // 00000110
#define ARMED           14 // 00001110
#define WAITING_DELAY   22 // 00010110
#define WAITING_SAMPLE 114 // 01110010
#define WAITING_LOW     82 // 01010010
#define WAITING_HIGH   210 // 11010010
#define WAITING_REPEAT  50 // 00110010

#define MAX_SAMPLES 54272
#define MAX_TIME    0xFFFFFFFFFF // (1<<40)-1
#define MAX_STATUS  8

#define INIT_ON		0x1
#define	INIT_ARM	0x3// + INIT_ON
#define	INIT_REARM	0x7// + INIT_ARM
#define	INIT_REINIT	0xf// + INIT_REARM

/*
typedef unsigned char		uint8_t;
typedef unsigned short		uint16_t;
typedef unsigned int		uint32_t;
typedef unsigned long long	uint64_t;
*/

typedef union
{
	user512_t raw;
# pragma pack(1) // manual packing aligned 64 bit
	struct
	{
		uint8_t  r_status[MAX_STATUS];//0x00 ++0x01
		uint8_t  w_init;              //0x08 &1:on,&2:arm,&4:rearm,&8:reinit
		uint8_t  w_trig;              //0x09
		uint8_t  w_clear;             //0x0A
		uint8_t  w_save;              //0x0B
		uint8_t  w_extclk;            //0x0C
		uint8_t  w_invert;            //0x0D
		uint8_t  w_gate;              //0x0E
		uint8_t  w_gate2;             //0x0F
		uint64_t w_delay;             //0x10
		uint64_t w_width;             //0x18
		uint64_t w_period;            //0x20
		uint64_t w_burst;             //0x28
		uint64_t w_cycle;             //0x30
		uint32_t w_repeat;            //0x38
		uint32_t w_count;             //0x3C
		uint64_t w_times[MAX_SAMPLES];//0x40 ++0x08
	};
} rptrig_t;

#ifdef __cplusplus
}
#endif
