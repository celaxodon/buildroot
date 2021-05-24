################################################################################
#
# Platform T210 Porg
#
################################################################################

LINUX_EXTENSIONS += platform-t210-porg

define PLATFORM_T210_PORG_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210
	ln -sf $(PLATFORM_T210_PORG_DIR) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210/porg
endef
