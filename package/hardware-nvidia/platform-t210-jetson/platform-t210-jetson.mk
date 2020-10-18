################################################################################
#
# t210 jetson DTS
#
################################################################################

PLATFORM_T210_JETSON_LICENSE = GPL-2.0
PLATFORM_T210_JETSON_LICENSE_FILES = kernel-dts/tegra210-jetson-common.dtsi
PLATFORM_T210_JETSON_VERSION = tegra-l4t-r32.4.2
PLATFORM_T210_JETSON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/jetson.git

define PLATFORM_T210_JETSON_CONFIGURE_CMDS
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210
	ln -s $(BUILD_DIR)/platform-t210-jetson-$(PLATFORM_T210_JETSON_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/t210/jetson
endef

$(eval $(generic-package))
