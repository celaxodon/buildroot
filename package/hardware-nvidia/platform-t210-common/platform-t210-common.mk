##############################################################################
#
# t210 common DTS
#
##############################################################################

PLATFORM_T210_COMMON_LICENSE = GPL-2.0
PLATFORM_T210_COMMON_VERSION = tegra-l4t-r32.4.2
PLATFORM_T210_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/common.git
PLATFORM_T210_COMMON_INSTALL_STAGING = YES

define PLATFORM_T210_COMMON_CONFIGURE_CMDS
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/t210
	ln -s $(BUILD_DIR)/platform-t210-common-$(PLATFORM_T210_COMMON_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/t210/common
endef

$(eval $(generic-package))
