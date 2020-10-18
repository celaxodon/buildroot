################################################################################
#
# t210 Common DTS Source
#
################################################################################

PLATFORM_T210_COMMON_LICENSE = GPL-2.0
PLATFORM_T210_COMMON_LICENSE_FILES = kernel-dts/tegra210-linux-4.14.dtsi
PLATFORM_T210_COMMON_VERSION = tegra-l4t-r32.4.2
PLATFORM_T210_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/common.git

define PLATFORM_T210_COMMON_CONFIGURE_CMDS
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210
	ln -s $(BUILD_DIR)/platform-t210-common-$(PLATFORM_T210_COMMON_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210/common
endef

$(eval $(generic-package))
