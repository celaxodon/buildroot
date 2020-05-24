#################################################
#
# Base Make file for setting up NVIDIA firmware directory structure
#
#################################################

# $(BUILD_DIR)/nvhardware maps to Linux_for_Tegra/sources/hardware/nvidia
NV_BUILD_KERNEL_DTS_ROOT = $(BUILD_DIR)/nvhardware

include $(sort $(wildcard package/hardware-nvidia/*/*.mk))
