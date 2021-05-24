################################################################################
#
# t210 jetson DTS
#
################################################################################

PLATFORM_T210_JETSON_LICENSE = GPL-2.0
PLATFORM_T210_JETSON_LICENSE_FILES = kernel-dts/tegra210-jetson-common.dtsi
PLATFORM_T210_JETSON_VERSION = tegra-l4t-r32.5
PLATFORM_T210_JETSON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/jetson.git

$(eval $(generic-package))
