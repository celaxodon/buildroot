################################################################################
#
# SOC t210
#
################################################################################

SOC_T210_LICENSE = GPL-2.0
SOC_T210_LICENSE_FILES = kernel-dts/tegra210-soc/tegra210-soc-base.dtsi
SOC_T210_VERSION = tegra-l4t-r32.5
SOC_T210_SITE = git://nv-tegra.nvidia.com/device/hardware/nvidia/soc/t210.git

$(eval $(generic-package))
