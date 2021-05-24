################################################################################
#
# Platform T210 Common
#
################################################################################

LINUX_EXTENSIONS += platform-t210-common

define PLATFORM_T210_COMMON_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210
	ln -sf $(PLATFORM_T210_COMMON_DIR) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210/common
endef
