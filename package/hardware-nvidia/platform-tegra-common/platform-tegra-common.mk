################################################################################
#
# t210 Common DTS source
#
################################################################################

PLATFORM_TEGRA_COMMON_LICENSE = GPL-2.0
PLATFORM_TEGRA_COMMON_LICENSE_FILES = kernel-dts/audio/tegra-platforms-audio-enable.dtsi
PLATFORM_TEGRA_COMMON_VERSION = tegra-l4t-r32.4.2
PLATFORM_TEGRA_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/tegra/common.git

define PLATFORM_TEGRA_COMMON_CONFIGURE_CMDS
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/tegra
	ln -s $(BUILD_DIR)/platform-tegra-common-$(PLATFORM_TEGRA_COMMON_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/tegra/common
endef

$(eval $(generic-package))
