include $(top_srcdir)/Common.mk

AM_MAKEFLAGS = -j$(MAKE_PROCESS)

CLEANFILES = $(LIBLIBS_SO) $(BINS)
MOSTLYCLEANFILES = *.mod.c *.o modules.order Module.symvers

.PHONY: modules
modules: $(MODULES:=.c) Kbuild
	@ echo " --- building modules ---"; \
	$(_set_export); \
	  $(MAKE) $(AM_MAKEFLAGS) -C ${LINUX_SRCDIR} \
	  CFLAGS="$(LINUX_CFLAGS)" M=$$PWD O=$$O \
	  srcdir=$(srcdir) builddir=$(builddir) modules

clean-local:
	@ echo " --- cleaning modules ---"; \
	$(_set_export); \
	$(MAKE) $(AM_MAKEFLAGS) -C ${LINUX_SRCDIR} \
	     CFLAGS="$(LINUX_CFLAGS)" M=$$PWD O=$$O \
	     srcdir=$(srcdir) builddir=$(builddir) clean


.PHONY: bins
bins: $(BINS)
$(BINS):
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(DEBUG_FLAGS) $(LINUX_CFLAGS) $(srcdir)/$@_bin.c -o $@

.PHONY: libs
libs: $(LIBLIBS_SO)
LIBLIBS_SO = $(addprefix lib,$(LIBS:=.so))
$(LIBLIBS_SO): lib%.so: %_lib.c
	echo " --- building $@ ---"; \
	$(_set_export); \
	${CROSS_COMPILE}${CC} $(DEBUG_FLAGS) $(LINUX_CFLAGS) $(srcdir)/$< -fPIC -shared -o $@

.PHONY: deploy
deploy: $(MODULES:=.ko) $(LIBLIBS_SO) $(BINS)
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
