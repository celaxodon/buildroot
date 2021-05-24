################################################################################
#
# Platform T210 Porg
#
################################################################################

PLATFORM_T210_PORG_LICENSE = GPL-2.0
PLATFORM_T210_PORG_LICENSE_FILES = kernel-dts/tegra210-porg-p3448-common.dtsi
PLATFORM_T210_PORG_VERSION = tegra-l4t-r32.5
PLATFORM_T210_PORG_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/porg.git

$(eval $(generic-package))
