################################################################################
#
# Platform Tegra Common
#
################################################################################

LINUX_EXTENSIONS += platform-tegra-common

define PLATFORM_TEGRA_COMMON_PREPARE_KERNEL
	mkdir -p $(NV_BUILD_KERNEL_DTS_ROOT)/platform/tegra
	ln -sf $(PLATFORM_TEGRA_COMMON_DIR) \
		$(NV_BUILD_KERNEL_DTS_ROOT)/platform/tegra/common
endef
