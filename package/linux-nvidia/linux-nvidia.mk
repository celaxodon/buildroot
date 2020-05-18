################################################################################
#
# NVIDIA Linux for Tegra
#
################################################################################

LINUX_NVIDIA_VERSION = tegra-l4t-r32.4.2
LINUX_NVIDIA_SITE = git://nv-tegra.nvidia.com/linux-nvidia.git
LINUX_NVIDIA_LICENSE = GPL-2.0
LINUX_NVIDIA_LICENSE_FILES = drivers/Makefile

# Must be defined here as well as in hardware-nvidia packages
export NV_BUILD_KERNEL_DTS_ROOT=$(BUILD_DIR)/hardware/nvidia

# L4T build process requires specific directory layouts
define LINUX_NVIDIA_CONFIGURE_CMDS
	ln -s $(BUILD_DIR)/linux-nvidia-$(LINUX_NVIDIA_VERSION) $(BUILD_DIR)/nvidia
endef

$(eval $(generic-package))
