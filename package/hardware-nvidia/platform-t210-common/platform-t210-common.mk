################################################################################
#
# t210 Common DTS Source
#
################################################################################

PLATFORM_T210_COMMON_LICENSE = GPL-2.0
PLATFORM_T210_COMMON_LICENSE_FILES = kernel-dts/tegra210-linux-4.14.dtsi
PLATFORM_T210_COMMON_VERSION = tegra-l4t-r32.5
PLATFORM_T210_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/common.git

$(eval $(generic-package))
