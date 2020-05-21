##############################################################################
#
# SOC t210
#
##############################################################################

HARDWARE_NVIDIA_SOC_T210_LICENSE = GPL-2.0
HARDWARE_NVIDIA_SOC_T210_VERSION = tegra-l4t-r32.4.2
HARDWARE_NVIDIA_SOC_T210_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/t210.git
HARDWARE_NVIDIA_SOC_T210_INSTALL_STAGING = YES
HARDWARE_NVIDIA_SOC_T210__DL_DIR = $(BUILD_DIR)

define HARDWARE_NVIDIA_SOC_T210_CONFIGURE_CMDS
    mkdir -p $(BUILD_DIR)/hardware-nvidia/soc
	ln -s $(BUILD_DIR)/hardware-nvidia-soc-t210-$(HARDWARE_NVIDIA_SOC_T210_VERSION) \
		$(BUILD_DIR)/hardware-nvidia/soc/t210
endef

$(eval $(generic-package))
