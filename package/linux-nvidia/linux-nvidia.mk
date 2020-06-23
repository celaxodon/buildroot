#################################################
#
# NVIDIA Linux Drivers
#
#################################################

# TODO: Double check licensing
LINUX_NVIDIA_LICENSE = GPL-2.0
LINUX_NVIDIA_VERSION = tegra-l4t-r32.4.2
LINUX_NVIDIA_SITE = git://nv-tegra.nvidia.com/linux-nvidia.git

# Must be defined here as well as in hardware-nvidia packages
NV_BUILD_KERNEL_DTS_ROOT=$(BUILD_DIR)/hardware/nvidia

define LINUX_NVIDIA_CONFIGURE_CMDS
	ln -s $(BUILD_DIR)/linux-nvidia-$(LINUX_NVIDIA_VERSION) $(BUILD_DIR)/nvidia
endef


$(eval $(generic-package))
