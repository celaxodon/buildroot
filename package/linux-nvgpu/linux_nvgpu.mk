LINUX_NVGPU_VERSION = tegra-l4t-r32.4.2
LINUX_NVGPU_SITE = git://nv-tegra.nvidia.com/linux-nvgpu.git
# TODO: Dbl check this
LINUX_NVGPU_LICENSE = GPL-2.0

define LINUX_NVGPU_CONFIGURE_CMDS
	ln -s $(TOPDIR)/output/build/linux-nvgpu-$(LINUX_NVGPU_VERSION) $(TOPDIR)/output/build/nvgpu
endef

$(eval $(generic-package))
