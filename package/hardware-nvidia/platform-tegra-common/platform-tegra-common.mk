################################################################################
#
# t210 Common DTS source
#
################################################################################

PLATFORM_TEGRA_COMMON_LICENSE = GPL-2.0
PLATFORM_TEGRA_COMMON_LICENSE_FILES = kernel-dts/audio/tegra-platforms-audio-enable.dtsi
PLATFORM_TEGRA_COMMON_VERSION = tegra-l4t-r32.5
PLATFORM_TEGRA_COMMON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/tegra/common.git

$(eval $(generic-package))
