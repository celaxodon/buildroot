################################################################################
#
# NVIDIA Linux kernel drivers
#
################################################################################

LINUX_EXTENSIONS += linux-nvidia

define LINUX_NVIDIA_PREPARE_KERNEL
	# Must be defined here as well as in hardware-nvidia packages
	export NV_BUILD_KERNEL_DTS_ROOT=$(BUILD_DIR)/hardware/nvidia

	# L4T build process requires specific directory layouts
	ln -sf $(LINUX_NVIDIA_DIR) $(BUILD_DIR)/nvidia
endef
