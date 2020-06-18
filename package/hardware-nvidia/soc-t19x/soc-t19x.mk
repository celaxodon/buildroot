##############################################################################
#
# SOC t19x
#
##############################################################################

SOC_T19X_LICENSE = GPL-2.0
SOC_T19X_VERSION = tegra-l4t-r32.4.2
SOC_T19X_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/t19x.git
SOC_T19X_INSTALL_STAGING = YES

define SOC_T19X_CONFIGURE_CMDS
    mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -s $(BUILD_DIR)/soc-t19x-$(SOC_T19X_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/soc/t19x
endef

$(eval $(generic-package))
