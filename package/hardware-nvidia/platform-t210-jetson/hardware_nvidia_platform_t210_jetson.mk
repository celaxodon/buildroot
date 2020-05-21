##############################################################################
#
# t210 port drivers
#
##############################################################################

HARDWARE_NVIDIA_PLATFORM_T210_JETSON_LICENSE = GPL-2.0
HARDWARE_NVIDIA_PLATFORM_T210_JETSON_VERSION = tegra-l4t-r32.4.2
HARDWARE_NVIDIA_PLATFORM_T210_JETSON_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/platform/t210/jetson.git
# HARDWARE_NVIDIA_PLATFORM_T210_JETSON_INSTALL_STAGING = YES

NV_BUILD_KERNEL_DTS_ROOT = $(BUILD_DIR)/nvhardware

define LINUX_NVIDIA_CONFIGURE_CMDS
    mkdir -p $(BUILD_DIR)/nv_hardware/platform/t210
	ln -s $(BUILD_DIR)/linux-nvidia-$(LINUX_NVIDIA_VERSION) $(BUILD_DIR)/nv_hardware/platform/t210/jetson
	export NV_BUILD_KERNEL_DTS_ROOT $(BUILD_DIR)/nv_hardware
	echo "DOING STUFF"
endef

# TODO: Create directory structure and symlink it: hardware/nvidia/platform

$(eval $(generic-package))
