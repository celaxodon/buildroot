# $TOPDIR?
# LINUX_NVGPU_DL_DIR = output/build/nvgpu
LINUX_NVGPU_NAME = nvgpu
LINUX_NVGPU_VERSION = tegra-l4t-r32.4.2
LINUX_NVGPU_SITE = git://nv-tegra.nvidia.com/linux-nvgpu.git
# TODO: Dbl check this
LINUX_NVGPU_LICENSE = GPL-2.0

# git clone --single-branch --branch $(LINUX_NVGPU_VERSION) $(LINUX_NVGPU_SITE) $(TOPDIR/output/build/nvgpu)
# define LINUX_NVGPU_EXTRACT_CMDS
# 	mv $(TOPDIR)/output/build/linux-nvgpu-$(LINUX_NVGPU_VERSION) $(TOPDIR)/output/build/nvgpu
# endef

$(eval $(generic-package))
