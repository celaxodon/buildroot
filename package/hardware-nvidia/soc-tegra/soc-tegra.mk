################################################################################
#
# SOC Tegra
#
################################################################################

SOC_TEGRA_VERSION = tegra-l4t-r32.4.2
SOC_TEGRA_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/tegra.git
SOC_TEGRA_LICENSE = GPL-2.0
SOC_TEGRA_LICENSE_FILES = kernel-include/dt-bindings/media/tegra-vi.h

define SOC_TEGRA_CONFIGURE_CMDS
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -s $(BUILD_DIR)/soc-tegra-$(SOC_TEGRA_VERSION) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/soc/tegra
endef

$(eval $(generic-package))
