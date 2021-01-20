################################################################################
#
# SOC Tegra
#
################################################################################

LINUX_EXTENSIONS += soc-tegra

define SOC_TEGRA_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/soc
	ln -sf $(SOC_TEGRA_DIR) $(NV_BUILD_KERNEL_DTS_ROOT)/soc/tegra
endef
