################################################################################
#
# Platform T210 Jetson
#
################################################################################

LINUX_EXTENSIONS += platform-t210-jetson

define PLATFORM_T210_JETSON_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210
	ln -sf $(PLATFORM_T210_JETSON_DIR) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210/jetson
endef
