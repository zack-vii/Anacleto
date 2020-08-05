
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <time.h>
#include <math.h>

#include "rptrig_lib.c"

int main(int argc, char *argv[])
{
	int i, c_status;
	uint64_t delay, width, period, burst, cycle, *times;
	uint32_t repeat;
	if(argc < 7)
	{
		printf("Usage:\n    %s Delay Width Period Burst Cycle Repeat [Seq1..Seq16]\n", argv[0]);
		exit(C_PARAM_ERROR);
	}
	RPTRIG_Disarm();
	delay  = (uint64_t)atoi(argv[1]);
	width  = (uint64_t)atoi(argv[2]);
	period = (uint64_t)atoi(argv[3]);
	burst  = (uint64_t)atoi(argv[4]);
	cycle  = (uint64_t)atoi(argv[5]);
	repeat = atoi(argv[6]);
	if(argc == 7)
		c_status = RPTRIG_MakeClock(&delay, &width, &period, &burst, &cycle, &repeat);
	else
	{
		uint32_t count = argc-7;
		times = malloc(count*sizeof(uint64_t));
		for(i = 0; i < count; i++)
			times[i] = (uint64_t)atoi(argv[i+7]);
		c_status = RPTRIG_MakeSequence(&delay, &width, &period, &burst, &cycle, &repeat, &count, times);
		free(times);
	}
	RPTRIG_Arm();
	RPTRIG_Close();
	exit(c_status);
}
