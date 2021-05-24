################################################################################
#
#  NVIDIA Linux kernel gpu drivers
#
################################################################################

LINUX_EXTENSIONS += linux-nvgpu

define LINUX_NVGPU_PREPARE_KERNEL
	# L4T build process requires specific directory layouts
	ln -sf $(LINUX_NVGPU_DIR) $(BUILD_DIR)/nvgpu
endef
