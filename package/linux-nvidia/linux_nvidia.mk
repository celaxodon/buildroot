# TODO: Double check licensing
LINUX_NVGPU_LICENSE = GPU-2.0
LINUX_NVIDIA_VERSION = tegra-l4t-r32.4.2
LINUX_NVIDIA_SITE = git://nv-tegra.nvidia.com/linux-nvidia.git

define LINUX_NVIDIA_CONFIGURE_CMDS
	ln -s $(TOPDIR)/output/build/linux-nvidia-$(LINUX_NVIDIA_VERSION) $(TOPDIR)/output/build/nvidia
endef


$(eval $(generic-package))
