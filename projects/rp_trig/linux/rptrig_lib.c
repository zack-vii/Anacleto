#include <string.h>
#include <time.h>
#include <pthread.h>
#include "rptrig.h"

#define PREFIX(name) RPTRIG_##name

#define DEFAULT_DELAY 600000000 //60s
static struct timespec t = {0, 100};
static char error[1024];

#define CHECK_INPUTS \
	uint64_t delay, cycle, burst, width, period;\
	uint32_t repeat;\
	delay = delay_p ? *delay_p : 0;\
	repeat = repeat_p ? *repeat_p : 1;\
	if (period_p)\
	{\
		period = *period_p;\
		width = width_p ? *width_p : period/2;\
	}\
	else\
	{\
		width = width_p ? *width_p : 5;\
		period = width*2;\
	}\
	burst    = burst_p && *burst_p>0 ? *burst_p : 1;\
	repeat = repeat_p && *repeat_p>0 ? *repeat_p : 1;

#define INIT_DEVICE \
	*error = 0;\
	int pos = 0;\
	if (open_dev(&pos))\
	{\
		fputs(error, stderr);\
		return C_DEV_ERROR;\
	}

static pthread_mutex_t dev_lock = PTHREAD_MUTEX_INITIALIZER;
static rptrig_t *dev = NULL;

static int open_dev(int *pos)
{
	int c_sts = C_OK;
	pthread_mutex_lock(&dev_lock);
	if (!dev)
	{
		dev = (rptrig_t *)usermem_open(NULL);
		if (!dev)
		{
			*pos += sprintf(error+*pos, "ERROR: unable to get device\n");
			c_sts = C_DEV_ERROR;
		}
	}
	pthread_mutex_unlock(&dev_lock);
	return c_sts;
}

static uint64_t get_clock()
{
	uint8_t buf[8];
	int i;
	buf[7]=buf[6]=buf[5]=0;
	for (i = 3 ; i < 8 ; i++)
		buf[i-3] = dev->r_status[i];
	return *(uint64_t*)buf;
}

int get_status(int idx, int *pos)
{
	int pos_in = *pos;
	if (idx >= MAX_STATUS || idx < 0)
	{
		*pos += sprintf(error+*pos, "ERROR: IDX < 0 or IDX > %d", MAX_STATUS-1);
		return -1;
	}
	uint8_t status, i;
	if (open_dev(pos)) return -1;
	status = dev->r_status[idx];
	if (idx<3)
	{ //it is a status byte
		switch (status & STATUS_MASK)
		{
		case 0:
			break;
		case IDLE:
			*pos += sprintf(error+*pos,"IDLE");
			break;
		case ARMED:
			*pos += sprintf(error+*pos, "ARMED");
			break;
		case WAITING_DELAY:
			*pos += sprintf(error+*pos, "WAITING_DELAY");
			break;
		case WAITING_SAMPLE:
			*pos += sprintf(error+*pos, "WAITING_SAMPLE");
			break;
		case WAITING_LOW:
			*pos += sprintf(error+*pos, "WAITING_LOW");
			break;
		case WAITING_HIGH:
			*pos += sprintf(error+*pos, "WAITING_HIGH");
			break;
		case WAITING_REPEAT:
			*pos += sprintf(error+*pos, "WAITING_REPEAT");
			break;
		default:
			*pos += sprintf(error+*pos, "UNDEFINED(0x%02X)", status);
		}
		if (idx>0)
			*pos += sprintf(error+*pos, "\n");
		else if (status&1)
			*pos += sprintf(error+*pos, " - ok @ ticks: %llu\n", get_clock());
		else
		{
			*pos += sprintf(error+*pos, " - errors:\n");
			for (i = 1 ; i < 3 ; i++)
			    get_status(i, pos);
			*pos += sprintf(error+*pos, " @ ticks: %llu\n", get_clock());
		}
		if (pos_in==0)
			fputs(error, stdout);
	}
	return status;
}

int PREFIX(GetDevice)(rptrig_t **dev_p)
{
	*error = 0;
	int pos = 0;
	if (open_dev(&pos))
	{
		fputs(error, stderr);
		dev_p = NULL;
		return C_DEV_ERROR;
	}
	*dev_p = dev;
	return C_OK;
}

int PREFIX(Close)()
{
	return dev ? usermem_close((void*)dev) : 0;
}

int PREFIX(GetClock)(uint64_t * clock)
{
	INIT_DEVICE
	*clock = get_clock();
	return C_OK;
}

int PREFIX(GetState)()
{
	INIT_DEVICE
	return get_status(0, &pos);
}

int PREFIX(GetParams)(
	uint64_t *delay_p,
	uint64_t *width_p,
	uint64_t *period_p,
	uint64_t *burst_p,
	uint64_t *cycle_p,
	uint32_t *repeat_p,
	uint32_t *count_p)
{
	INIT_DEVICE
	if (delay_p) *delay_p  = dev->w_delay;
	if (width_p) *width_p  = dev->w_width;
	if (period_p)*period_p = dev->w_period;
	if (burst_p) *burst_p  = dev->w_burst;
	if (cycle_p) *cycle_p  = dev->w_cycle;
	if (repeat_p)*repeat_p = dev->w_repeat;
	if (count_p) *count_p  = dev->w_count;
	return C_OK;
}

uint64_t PREFIX(GetRegister)()
{
	INIT_DEVICE
	return *(uint64_t*)&dev->w_init;
}


int PREFIX(GetTimes)(uint32_t offset, uint32_t count, uint64_t *times_p)
{
	int i;
	INIT_DEVICE
	memcpy(times_p, &(dev->w_times[offset]), (count<MAX_SAMPLES ? count : MAX_SAMPLES)*sizeof(uint64_t));
	for (i = MAX_SAMPLES ; i < count ; i++)
		times_p[i] = 0;
	return C_OK;
}

int PREFIX(SetParams)(
	const uint64_t delay,
	const uint64_t width,
	const uint64_t period,
	const uint64_t burst,
	const uint64_t cycle,
	const uint32_t repeat,
	const uint32_t count,
	int *pos)
{
	*pos += sprintf(error+*pos, "DELAY: %llu, WIDTH: %llu, PERIOD: %llu, BURST: %llu, CYCLE: %llu, REPEAT: %u, COUNT: %u\n", delay, width, period, burst, cycle, repeat, count);
	if (count > MAX_SAMPLES)
	{
		*pos += sprintf(error+*pos, "ERROR: COUNT > MAX_SAMPLES(%d)\n", MAX_SAMPLES);
		return C_PARAM_ERROR;
	}
	if (period < 2)
	{
		*pos += sprintf(error+*pos, "ERROR: PERIOD < 2\n");
		return C_PARAM_ERROR;
	}
	if (width >= period)
	{
		*pos += sprintf(error+*pos, "ERROR: WIDTH >= PERIOD\n");
		return C_PARAM_ERROR;
	}
	if (delay>MAX_TIME)
	{
		*pos += sprintf(error+*pos, "ERROR: DELAY > MAX_TIME = %llu\n", (uint64_t)MAX_TIME);
		return C_PARAM_ERROR;
	}
	if (cycle>MAX_TIME)
	{
		*pos += sprintf(error+*pos, "ERROR: CYCLE > MAX_TIME = %llu\n", (uint64_t)MAX_TIME);
		return C_PARAM_ERROR;
	}
	if (burst*period>MAX_TIME)
	{
		*pos += sprintf(error+*pos, "ERROR: BURST x PERIOD > MAX_TIME = %llu\n", (uint64_t)MAX_TIME);
		return C_PARAM_ERROR;
	}
	if (open_dev(pos))
		return C_DEV_ERROR;
	dev->w_count  = 0;
	dev->w_delay  = delay;
	dev->w_width  = width;
	dev->w_period = period;
	dev->w_burst  = burst;
	dev->w_cycle  = cycle;
	dev->w_repeat = repeat;
	return C_OK;
}

char* PREFIX(GetError)()
{
	return error;
}

int PREFIX(MakeClock)(
	const uint64_t *delay_p,
	const uint64_t *width_p,
	const uint64_t *period_p,
	const uint64_t *burst_p,
	const uint64_t *cycle_p,
	const uint32_t *repeat_p)
{
	int pos = sprintf(error, "MAKE CLOCK: ");
	CHECK_INPUTS
	if (cycle_p)
	{
		cycle = *cycle_p;
		if (cycle < period * burst)
		{
			pos += sprintf(error+pos, "ERROR: CYCLE < PERIOD * BURST\n");
			fputs(error, stderr);
			return C_PARAM_ERROR;
		}
	} else
		cycle = period * burst;
	int i, c_status = PREFIX(SetParams)(delay, width, period, burst, cycle, repeat, 1, &pos);
	fputs(error, stdout);
	if(c_status)
		return c_status;
	dev->w_times[0] = 0;
	dev->w_count = 1;
	return C_OK;
}

int PREFIX(MakeSequence)(
	const uint64_t *delay_p,
	const uint64_t *width_p,
	const uint64_t *period_p,
	const uint64_t *burst_p,
	const uint64_t *cycle_p,
	const uint32_t *repeat_p,
	const uint32_t *count_p,
	const uint64_t *times)
{
	int pos = sprintf(error, "MAKE SEQUENCE: ");
	if (!times || !count_p)
	{
		pos += sprintf(error+pos, "ERROR: TIMES = NULL");
		fputs(error, stderr);
		return C_PARAM_ERROR;
	}
	uint32_t count = *count_p;
	CHECK_INPUTS
	if (count < 1)
	{
		pos += sprintf(error+pos, "ERROR: COUNT < 1\n");
		fputs(error, stderr);
		return C_PARAM_ERROR;
	}
	uint64_t periodxburst = period*burst;
	if (cycle_p)
	{
		cycle = *cycle_p;
		if (cycle < times[count-1] + periodxburst)
		{
			pos += sprintf(error+pos, "ERROR: CYCLE < TIMES[end] + PERIOD x BURST\n");
			pos += sprintf(error+pos, "               TIMES[end]: %llu\n", times[count-1]);
			fputs(error, stderr);
			return C_PARAM_ERROR;
		}
	} else
		cycle = times[count-1] + periodxburst;
	pos += sprintf(error+pos, "TIMES: [%llu", times[0]);
	int i;
	for(i = 1; i < count; i++)
	{
		if (i < 16)
			pos += sprintf(error+pos, ", %llu", times[i]);
		if (i == 16)
			pos += sprintf(error+pos, ", ...");
		if(times[i] < times[i-1] + periodxburst)
		{
			pos += sprintf(error+pos, "\nERROR: TIMES[%d] - TIMES[%d] < PERIOD x BURST\n", i, i-1);
			fputs(error, stderr);
			return C_PARAM_ERROR;
		}
	}
	pos += sprintf(error+pos, "],\n");
	int c_status = PREFIX(SetParams)(delay, width, period, burst, cycle, repeat, count, &pos);
	fputs(error, stdout);
	if(c_status)
		return c_status;
	memcpy(dev->w_times, times, count*sizeof(uint64_t));
	dev->w_count = count;
	return C_OK;
}

int PREFIX(Trig)()
{
	INIT_DEVICE
	dev->w_trig = -1;
	return C_OK;
}

int PREFIX(Arm)()
{
	int i;
	INIT_DEVICE
	dev->w_clear = -1;
	dev->w_init    = INIT_ARM;
	return C_OK;
}

int PREFIX(Rearm)()
{
	int i;
	INIT_DEVICE
	dev->w_clear = -1;
	dev->w_init = INIT_REARM;
	return C_OK;
}

int PREFIX(Disarm)()
{
	INIT_DEVICE
	dev->w_init = 0;
	return C_OK;
}

int PREFIX(Reinit)(uint64_t *delay_p)
{
	INIT_DEVICE
	dev->w_init = 0;
	dev->w_count = 0;
	dev->w_delay = delay_p ? *delay_p : DEFAULT_DELAY;
	dev->w_width = 0;
	dev->w_period = 0;
	dev->w_burst = 0;
	dev->w_cycle = 0;
	dev->w_repeat = 0;
	nanosleep(&t, 0);
	dev->w_save =-1;
	nanosleep(&t, 0);
	dev->w_clear =-1;
	dev->w_init = INIT_REINIT;
	return C_OK;
}

int PREFIX(SetInvert)(uint8_t val)
{
	INIT_DEVICE
	dev->w_invert = val;
	return C_OK;
}

int PREFIX(SetGate)(uint8_t val)
{
	INIT_DEVICE
	dev->w_gate = val;
	return C_OK;
}

int PREFIX(SetGate2)(uint8_t val)
{
	INIT_DEVICE
	dev->w_gate2 = val;
	return C_OK;
}

int PREFIX(SetClockExt)(int val)
{
	INIT_DEVICE
	dev->w_extclk = val ? -1 : 0;
	return C_OK;
}
