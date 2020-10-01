################################################################################
#
# Linux Tegra210 Board Support Package
#
################################################################################

TEGRA210_LINUX_VERSION = 32.4.2
TEGRA210_LINUX_SITE = https://developer.nvidia.com/embedded/L4T/r32_Release_v4.2/t210ref_release_aarch64
TEGRA210_LINUX_SOURCE = Tegra210_Linux_R$(TEGRA210_LINUX_VERSION)_aarch64.tbz2
# TODO: Double check this.
TEGRA210_LINUX_LICENSE = NVIDIA Customer Software Agreement
TEGRA210_LINUX_LICENSE_FILES = bootloader/LICENSE \
			       bootloader/LICENSE.chkbdinfo \
			       bootloader/LICENSE.mkbctpart \
			       bootloader/LICENSE.mkbootimg \
			       bootloader/LICENSE.mkgpt \
			       bootloader/LICENSE.mksparse \
			       bootloader/LICENSE.tos-mon-only.img.arm-trusted-firmware \
			       bootloader/LICENSE.u-boot \
			       bootloader/t210ref/LICENSE.cboot \
			       bootloader/t210ref/LICENSE.sc7entry-firmware

TEGRA210_LINUX_REDISTRIBUTE = NO
TEGRA210_LINUX_INSTALL_IMAGES = YES
TEGRA210_LINUX_DEPENDENCIES = linux-nvidia linux uboot
HOST_TEGRA210_LINUX_DEPENDENCIES = host-python


define TEGRA210_LINUX_BUILD_CMDS
	cd $(@D)/bootloader && \
	./mkbootimg --kernel $(BINARIES_DIR)/u-boot.bin \
	--ramdisk /dev/null \
	--board mmcblk0p1 \
	--output $(@D)/bootloader/boot.img \
	--cmdline 'root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 console=ttyS0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0'

endef

define TEGRA210_LINUX_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0644 $(@D)/bootloader/boot.img $(BINARIES_DIR)/boot.img
	$(INSTALL) -m 0644 $(@D)/bootloader/bmp.blob $(BINARIES_DIR)/bmp.blob
endef

# Other binaries and files required for flashing process
# NVCFILE -> nvtboot.bin
# LNXFILE -> boot.img (generated in build step)
define TEGRA210_LINUX_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 $(@D)/bootloader/l4t_initrd.img $(TARGET_DIR)/boot/initrd
	$(INSTALL) -m 0644 $(@D)/bootloader/nv_boot_control.conf $(TARGET_DIR)/etc/nv_boot_control.conf

	sed -i /TNSPEC/d $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i '$$ a TNSPEC 3448-300---1-0-jetson-nano-qspi-sd-mmcblk0p1' $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i /TEGRA_CHIPID/d $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i '$$ a TEGRA_CHIPID 0x21' $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i /TEGRA_OTA_BOOT_DEVICE/d $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i '$$ a TEGRA_OTA_BOOT_DEVICE /dev/mtdblock0' $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i /TEGRA_OTA_GPT_DEVICE/d $(TARGET_DIR)/etc/nv_boot_control.conf
	sed -i '$$ a TEGRA_OTA_GPT_DEVICE /dev/mtdblock0' $(TARGET_DIR)/etc/nv_boot_control.conf
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
