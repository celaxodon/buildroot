#################################################
#
# Base Make file for setting up NVIDIA firmware directory structure
#
#################################################

# $(BUILD_DIR)/hardware-nvidia maps to Linux_for_Tegra/sources/hardware/nvidia

define HARDWARE_NVIDIA_CONFIGURE_CMDS
    export NV_BUILD_KERNEL_DTS_ROOT $(BUILD_DIR)/hardware-nvidia
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)
endef

include $(sort $(wildcard package/hardware-nvidia/*/*.mk))
