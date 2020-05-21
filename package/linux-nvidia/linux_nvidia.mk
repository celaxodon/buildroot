#################################################
#
# NVIDIA Linux Drivers
#
#################################################

# TODO: Double check licensing
LINUX_NVIDIA_LICENSE = GPL-2.0
LINUX_NVIDIA_VERSION = tegra-l4t-r32.4.2
LINUX_NVIDIA_SITE = git://nv-tegra.nvidia.com/linux-nvidia.git

define LINUX_NVIDIA_CONFIGURE_CMDS
	ln -s $(BUILD_DIR)/linux-nvidia-$(LINUX_NVIDIA_VERSION) $(BUILD_DIR)/nvidia
endef


$(eval $(generic-package))
