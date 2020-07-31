include $(top_srcdir)/Common.mk
include $(top_srcdir)/fpga/Common.mk

FPGA_REPO_DIR += $(top_builddir)/fpga/lib/red-pitaya-notes

## CORES ##
VENDOR = w7x
LIBRARY = ip
vivado_CORES = timing_1.0
timing_SOURCES = \
	src/w7x_timing_v1_0_S00_AXI.vhd \
	src/w7x_timing_v1_0.vhd \
	src/w7x_timing.vhd \
	src/w7x_timing.xdc
timing_IPCFG = src/w7x_timing_setup.tcl
timing_DRV_LINUX = \
	linux/rptiming.h \
	linux/rptiming.c \
	linux/rptiming_lib.c \
	linux/rptiming_test.c

## PROJECTS ##
vivado_PROJECTS = timing_brd
timing_brd_VERSION = 1.0
timing_brd_IP_SOURCES = timing_1.0
timing_brd_SOURCES = \
	prj_src/system.bd \
	prj_src/hdl/system_wrapper.v \
	prj_src/red_pitaya.xdc
timing_brd_PRJCFG = prj_src/w7x_timing_brd_setup.tcl
#timing_brd_ARCHIVE = $(NAME).zip

.PHONY: linux
linux:
	$(MAKE) $(AM_MAKEFLAGS) -C linux clean all

all: cores projects dtb linux bitstream
