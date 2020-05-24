##############################################################################
#
# t210 common DTS
#
##############################################################################

PLATFORM_TEGRA_COMMON_LICENSE = GPL-2.0
PLATFORM_TEGRA_COMMON_VERSION = tegra-l4t-r32.4.2
PLATFORM_TEGRA_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/tegra/common.git
PLATFORM_TEGRA_COMMON_INSTALL_STAGING = YES

define PLATFORM_TEGRA_COMMON_CONFIGURE_CMDS
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/tegra
	ln -s $(BUILD_DIR)/platform-tegra-common-$(PLATFORM_TEGRA_COMMON_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/tegra/common
endef

$(eval $(generic-package))

