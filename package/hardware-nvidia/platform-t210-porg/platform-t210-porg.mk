#################################################
#
# Platform T210 Porg download helper
#
#################################################

PLATFORM_T210_PORG_LICENSE = GPL-2.0
PLATFORM_T210_PORG_VERSION = tegra-l4t-r32.4.2
PLATFORM_T210_PORG_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/porg.git
PLATFORM_T210_PORG_INSTALL_STAGING = YES

define PLATFORM_T210_PORG_CONFIGURE_CMDS
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/t210
    ln -s $(BUILD_DIR)/platform-t210-porg-$(PLATFORM_T210_PORG_VERSION) \
        $(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/platform/t210/porg
endef

$(eval $(generic-package))
