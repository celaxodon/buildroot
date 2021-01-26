################################################################################
#
# NVIDIA Linux kernel drivers
#
################################################################################

LINUX_EXTENSIONS += linux-nvidia

define LINUX_NVIDIA_PREPARE_KERNEL
	# L4T build process requires specific directory layouts
	ln -sf $(LINUX_NVIDIA_DIR) $(BUILD_DIR)/nvidia
endef
