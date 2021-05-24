################################################################################
#
# NVIDIA Linux for Tegra
#
################################################################################

LINUX_NVIDIA_VERSION = tegra-l4t-r32.5
LINUX_NVIDIA_SITE = git://nv-tegra.nvidia.com/linux-nvidia.git
LINUX_NVIDIA_LICENSE = GPL-2.0
LINUX_NVIDIA_LICENSE_FILES = drivers/Makefile

$(eval $(generic-package))
