################################################################################
#
# Linux NVGPU for Tegra
#
################################################################################

LINUX_NVGPU_VERSION = tegra-l4t-r32.5
LINUX_NVGPU_SITE = git://nv-tegra.nvidia.com/linux-nvgpu.git
LINUX_NVGPU_LICENSE = GPL-2.0
LINUX_NVGPU_LICENSE_FILES = include/linux/tegra_gpu_t19x.h

$(eval $(generic-package))
