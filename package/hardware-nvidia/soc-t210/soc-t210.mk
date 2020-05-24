##############################################################################
#
# SOC t210
#
##############################################################################

SOC_T210_LICENSE = GPL-2.0
SOC_T210_VERSION = tegra-l4t-r32.4.2
SOC_T210_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/t210.git
SOC_T210_INSTALL_STAGING = YES

define SOC_T210_CONFIGURE_CMDS
    NV_BUILD_KERNEL_DTS_ROOT=$(BUILD_DIR)/nvhardware
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/soc/t210
	ln -s $(BUILD_DIR)/soc-t210-$(SOC_T210_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/hardware/nvidia/soc/t210/soc
endef

$(eval $(generic-package))
