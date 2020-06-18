#################################################
#
# Base Make file for setting up NVIDIA firmware directory structure
#
#################################################

# $(BUILD_DIR)/hardware/nvidia maps to Linux_for_Tegra/sources/hardware/nvidia
# TODO: Try to get rid of the 'hardware/nvidia' directories - depends on build scripts
NV_BUILD_KERNEL_DTS_ROOT = $(BUILD_DIR)/hardware/nvidia

include $(sort $(wildcard package/hardware-nvidia/*/*.mk))
