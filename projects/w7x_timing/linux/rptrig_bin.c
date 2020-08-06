#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "rptrig_lib.c"

int print_block(const int offset, const int cols, const int rows)
{
	int c, r, o = offset;
	for ( r = 0 ; r < rows ; r++)
	{
		printf("0x%04x: ", r);
		for ( c = 0 ; c < cols ; c++, o++)
			 printf("%3u,", dev->raw[o]);
		printf("\n");
	}
	return 0;
}


int main(int argc, char *argv[])
{
	int i, c_status;
	uint64_t delay, width, period, burst, cycle, *times;
	uint32_t repeat;
	rptrig_t *tmp;
	RPTRIG_GetDevice(&tmp);
	switch(argc)
	{
	case 1:
		return print_block(0, 8, 2);
	case 2:
	{
		int rows = atoi(argv[1]);
		return print_block(0, 8, rows);
	}
	case 3:
	{
		int offs = atoi(argv[1]);
		int rows = atoi(argv[2]);
		return print_block(offs*8, 8, rows);
	}
	case 4:
	{
		int offs = atoi(argv[1]);
		int cols = atoi(argv[2]);
		int rows = atoi(argv[3]);
		return print_block(offs, cols, rows);
	}
	case 5:
	case 6:
	{
		printf(
	"Usage:\n"
	"     %s Delay Width Period Burst Cycle Repeat [Seq1..Seq16]\n"
	"e.g. %s 10000 10000 20000 100 3000000 3\n"
		, argv[0], argv[0]);
		return 7;
	}
	default:
	{
		delay  = (uint64_t)atoi(argv[1]);
		width  = (uint64_t)atoi(argv[2]);
		period = (uint64_t)atoi(argv[3]);
		burst  = (uint64_t)atoi(argv[4]);
		cycle  = (uint64_t)atoi(argv[5]);
		repeat = atoi(argv[6]);
		sleep(1);
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
		sleep(1);
		RPTRIG_Trig();
		printf("State: %d %s\n", RPTRIG_GetState(), RPTRIG_GetError());
	}}
	RPTRIG_Close();
	exit(c_status);
}
