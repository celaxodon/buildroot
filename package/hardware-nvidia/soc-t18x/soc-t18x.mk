##############################################################################
#
# SOC t18x
#
##############################################################################

SOC_T18X_LICENSE = GPL-2.0
SOC_T18X_VERSION = tegra-l4t-r32.4.2
SOC_T18X_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/t18x.git
SOC_T18X_INSTALL_STAGING = YES

define SOC_T18X_CONFIGURE_CMDS
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -s $(BUILD_DIR)/soc-t18x-$(SOC_T18X_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/soc/t18x
endef

$(eval $(generic-package))
