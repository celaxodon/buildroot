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
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -s $(BUILD_DIR)/soc-t210-$(SOC_T210_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/soc/t210
endef

$(eval $(generic-package))
