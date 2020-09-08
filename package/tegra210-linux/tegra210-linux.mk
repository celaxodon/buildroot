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

# Interpolate values for p3450-0000
# TODO: Find a way to conditionally set these based on board
# TODO: Calculate the APPSIZE value? This should be the size of the root filesystem, which may be dynamically evaluated, not sure.
# Regardless, it's the first partition on the SD card, but set off to be the last in terms of byte order
define TEGRA210_LINUX_CONFIGURE_CMDS
	cp $(@D)/bootloader/t210ref/cfg/flash_l4t_t210_spi_sd_p3448.xml $(@D)/bootloader/flash.xml
	cp $(@D)/bootloader/t210ref/nvtboot.bin $(@D)/bootloader/nvtboot.bin
	cp $(@D)/bootloader/t210ref/cboot.bin $(@D)/bootloader/cboot.bin
	cp $(@D)/bootloader/t210ref/warmboot.bin $(@D)/bootloader/warmboot.bin
	cp $(@D)/bootloader/t210ref/sc7entry-firmware.bin $(@D)/bootloader/sc7entry-firmware.bin
	cp $(@D)/bootloader/t210ref/BCT/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg \
		$(@D)/bootloader/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg

	sed -i -e 's/NXC/NVC/' \
		-e 's/NVCTYPE/bootloader/' \
		-e 's/NVCFILE/nvtboot.bin/' \
		-e 's/VERFILE/qspi_bootblob_ver.txt/g' \
		-e 's/EBTFILE/cboot.bin/' \
		-e 's/TBCFILE/nvtboot_cpu.bin/' \
		-e 's/TXC/TBC/' \
		-e 's/TXS/TOS/' \
		-e 's/TOSFILE/tos-mon-only.img/' \
		-e 's/TBCTYPE/bootloader/' \
		-e 's/DTBFILE/tegra210-p3448-0000-p3449-0000-b00.dtb/' \
		-e 's/WB0TYPE/WB0/' \
		-e 's/WB0FILE/warmboot.bin/' \
		-e 's/BXF/BPF/' \
		-e 's/BPFFILE/sc7entry-firmware.bin/' \
		-e 's/WX0/WB0/' \
		-e 's/DXB/DTB/' \
		-e 's/EXS/EKS/' \
		-e 's/EKSFILE/eks.img/' \
		-e 's/FBTYPE/data/' \
		-e 's/LNXFILE/boot.img/' \
		-e 's/APPUUID//' \
		-e 's/APPFILE/system.img/' \
		-e '/FBFILE/d' \
		-e '/BPFDTB-FILE/d' \
		-e 's/APPSIZE/7795113984/' \
		$(@D)/bootloader/flash.xml
endef

# TODO: See if there's a way to do this as part of the linux-nvidia package or in a cleaner way
# or whether this should actually go in $(BINARIES_DIR) for additional flash usage...
define COPY_DTB_FOR_SIGNING
	cp $(BUILD_DIR)/linux-tegra-l4t-r$(TEGRA210_LINUX_VERSION)/arch/arm64/boot/dts/tegra210-p3448-0000-p3449-0000-b00.dtb \
		$(@D)/bootloader/tegra210-p3448-0000-p3449-0000-b00.dtb
endef

TEGRA210_LINUX_PRE_BUILD_HOOKS += COPY_DTB_FOR_SIGNING

# tegraflash.py command for signing and generating flash-ready partition imgs:
define TEGRA210_LINUX_BUILD_CMDS
	cd $(@D)/bootloader && \
	./mkbootimg --kernel $(BINARIES_DIR)/u-boot.bin \
	--ramdisk /dev/null \
	--board mmcblk0p1 \
	--output $(@D)/bootloader/boot.img \
	--cmdline 'root=/dev/mmcblk0p1 rw rootwait rootfstype=ext4 console=ttyS0,115200n8 console=tty0 fbcon=map:0 net.ifnames=0'

	cd $(@D)/bootloader && \
	./tegraflash.py --bl $(BINARIES_DIR)/cboot.bin \
	--bct P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg \
	--odmdata 0x94000 \
	--bldtb $(BINARIES_DIR)/tegra210-p3448-0000-p3449-0000-b00.dtb \
	--applet nvtboot_recovery.bin \
	--cmd "sign" \
	--cfg flash.xml \
	--chip 0x21 \
	--bins "EBT cboot.bin; DTB tegra210-p3448-0000-p3449-0000-b00.dtb"
endef

# TODO: Copy signed images and other necessary files for flashing to $(BINARIES_DIR)

# Other binaries and files required for flashing process
# NVCFILE -> nvtboot.bin
# LNXFILE -> boot.img (generated in build step)
define TEGRA210_LINUX_INSTALL_IMAGES_CMDS

	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/boot.img.encrypt $(BINARIES_DIR)/signed/boot.img.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/cboot.bin.encrypt $(BINARIES_DIR)/signed/cboot.bin.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/flash.xml $(BINARIES_DIR)/signed/flash.xml
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/flash.xml.bin $(BINARIES_DIR)/signed/flash.xml.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/nvtboot.bin.encrypt $(BINARIES_DIR)/signed/nvtboot.bin.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/nvtboot_cpu.bin.encrypt $(BINARIES_DIR)/signed/nvtboot_cpu.bin.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.bct \
		$(BINARIES_DIR)/signed/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.bct
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/rcm_0_encrypt.rcm $(BINARIES_DIR)/signed/rcm_0_encrypt.rcm
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/rcm_1_encrypt.rcm $(BINARIES_DIR)/signed/rcm_1_encrypt.rcm
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/sc7entry-firmware.bin.encrypt $(BINARIES_DIR)/signed/sc7entry-firmware.bin.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/tegra210-p3448-0000-p3449-0000-b00.dtb.encrypt \
		$(BINARIES_DIR)/signed/tegra210-p3448-0000-p3449-0000-b00.dtb.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/tos-mon-only.img.encrypt $(BINARIES_DIR)/signed/tos-mon-only.img.encrypt
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/warmboot.bin.encrypt $(BINARIES_DIR)/signed/warmboot.bin.encrypt

	$(INSTALL) -m 0644 -D $(@D)/bootloader/t210ref/cboot.bin $(BINARIES_DIR)/cboot.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/t210ref/nvtboot.bin $(BINARIES_DIR)/nvtboot.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/t210ref/warmboot.bin $(BINARIES_DIR)/warmboot.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/t210ref/sc7entry-firmware.bin \
		$(BINARIES_DIR)/sc7entry-firmware.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/nvtboot_recovery.bin \
		$(BINARIES_DIR)/nvtboot_recovery.bin
	$(INSTALL) -m 0644 -D $(@D)/bootloader/tos-mon-only.img \
		$(BINARIES_DIR)/tos-mon-only.img
	$(INSTALL) -m 0644 -D $(@D)/bootloader/t210ref/BCT/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg \
		$(BINARIES_DIR)/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg
	$(INSTALL) -m 0644 -D $(@D)/bootloader/signed/flash.xml.bin \
		$(BINARIES_DIR)/flash.xml.bin
endef

define TEGRA210_LINUX_INSTALL_TARGET_CMDS
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
# Necessary?
$(eval $(host-generic-package))
