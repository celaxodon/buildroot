################################################################################
#
# SOC Tegra
#
################################################################################

SOC_TEGRA_VERSION = tegra-l4t-r32.5
SOC_TEGRA_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/tegra.git
SOC_TEGRA_LICENSE = GPL-2.0
SOC_TEGRA_LICENSE_FILES = kernel-include/dt-bindings/media/tegra-vi.h

$(eval $(generic-package))
