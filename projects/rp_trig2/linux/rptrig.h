#pragma once
#include "usermem.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
typedef unsigned char		uint8_t;
typedef unsigned short		uint16_t;
typedef unsigned int		uint32_t;
typedef unsigned long long	uint64_t;
*/

#define DATA_WIDTH sizeof(uint64_t)
#define STAT_COUNT 8
#define CTRL_COUNT 1
#define HEAD_COUNT 7
#define TIME_WIDTH 40

#define MAX_STATUS  1
#define MAX_SAMPLES 45000
#define MAX_TIME    (((uint64_t)1)<<TIME_WIDTH)-1

#define INIT_ON		0x1
#define	INIT_ARM	0x3// + INIT_ON
#define	INIT_REARM	0x7// + INIT_ARM
#define	INIT_REINIT	0xf// + INIT_REARM

# pragma pack(1) // manual packing aligned 64 bit
typedef union
{
	USERMEM(raw);
	struct
	{
		union {
			uint64_t stat[STAT_COUNT];
			uint8_t  r_status[STAT_COUNT*DATA_WIDTH];
			struct {
				uint8_t init;
			};
		};
		union {
			uint64_t ctrl[CTRL_COUNT];
			uint8_t	 w_control[CTRL_COUNT*DATA_WIDTH];
			struct {
				uint8_t	w_init;
				uint8_t	w_trig;
				uint8_t	w_clear;
				uint8_t	w_save;
				uint8_t	w_extclk;
				uint8_t	w_invert;
				uint8_t	w_gate;
				uint8_t	w_gate2;
			};
		};
		union {
			uint64_t head[HEAD_COUNT];
			struct {
				uint64_t w_delay;
				uint64_t w_width;
				uint64_t w_period;
				uint64_t w_burst;
				uint64_t w_cycle;
				uint64_t w_repeat;
				uint64_t w_count;
			};
		};
		uint64_t w_times[MAX_SAMPLES];
	};
} rptrig_t;

#ifdef __cplusplus
}
#endif
