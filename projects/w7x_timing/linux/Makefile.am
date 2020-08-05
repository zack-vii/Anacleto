
include $(top_srcdir)/Common.mk

AM_MAKEFLAGS = -j$(MAKE_PROCESS)

BINS = rptrig
LIBS = rptrig

clean::
	@$(RM) $(OUT)

OUT = $(LIBLIBS_SO) $(BINS)

.PHONY: bins
bins: $(BINS)
$(BINS):
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(LINUX_CFLAGS) $(srcdir)/$@_bin.c -o $@ -lpthread -O2


.PHONY: libs
libs: $(LIBLIBS_SO)
LIBLIBS_SO = $(addprefix lib,$(LIBS:=.so))

$(LIBLIBS_SO): lib%.so: %_lib.c
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(LINUX_CFLAGS) $(srcdir)/$< -fPIC -o $@ -O2 -shared


.PHONY: deploy
deploy: $(BINS)
if WITH_DEVICE_SSHKEY
	@ echo " --- deploying modules to target device: ${DEVICE_NAME} using key ---";
	scp -i $(DEVICE_SSHKEY) $^ \
	  $(DEVICE_USER)@$(DEVICE_IP):$(DEVICE_MODULES_DIR);
else
if WITH_DEVICE_SSHPASSWD
	@ echo " --- deploying modules to target device: ${DEVICE_NAME} using passwd ---";
	sshpass -p ${DEVICE_PASSWD} scp $^ \
	  $(DEVICE_USER)@$(DEVICE_IP):$(DEVICE_MODULES_DIR);
endif
endif

all: libs bins
