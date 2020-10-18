################################################################################
#
# Linux NVGPU for Tegra
#
################################################################################

LINUX_NVGPU_VERSION = tegra-l4t-r32.4.2
LINUX_NVGPU_SITE = git://nv-tegra.nvidia.com/linux-nvgpu.git
LINUX_NVGPU_LICENSE = GPL-2.0
LINUX_NVGPU_LICENSE_FILES = include/linux/tegra_gpu_t19x.h

define LINUX_NVGPU_CONFIGURE_CMDS
		ln -s $(TOPDIR)/output/build/linux-nvgpu-$(LINUX_NVGPU_VERSION) $(TOPDIR)/output/build/nvgpu
endef

$(eval $(generic-package))
