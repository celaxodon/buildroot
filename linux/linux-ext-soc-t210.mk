################################################################################
#
# SOC T210
#
################################################################################

LINUX_EXTENSIONS += soc-t210

define SOC_T210_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -sf $(SOC_T210_DIR) $(NV_BUILD_KERNEL_DTS_ROOT)/soc/t210
endef
