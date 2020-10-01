#!/usr/bin/env bash

# Requires the tegra-linux Board Support Package (BSP) to be enabled

# set -x

BSP_VERSION=32.4.2

BSP_DIR="${BUILD_DIR}/tegra210-linux-${BSP_VERSION}"

install_dtb()
{
    install -m 0644 -D "${BUILD_DIR}/linux-tegra-l4t-r${BSP_VERSION}/arch/arm64/boot/dts/tegra210-p3448-0000-p3449-0000-b00.dtb" \
		"${TARGET_DIR}/boot/tegra210-p3448-0000-p3449-0000-b00.dtb"

    # Required for tegrasign operations
    install -m 0644 -D "${BUILD_DIR}/linux-tegra-l4t-r${BSP_VERSION}/arch/arm64/boot/dts/tegra210-p3448-0000-p3449-0000-b00.dtb" \
		"${BSP_DIR}/bootloader/tegra210-p3448-0000-p3449-0000-b00.dtb"
}


# Collects files required for tegraflash.py (in case of signing images)
# Also edits the flash.xml config file with values for the Jetson Nano SD (p3450-0000)
prepare_tegraflash_files()
{
    # NOTE: system.img may require size to be aligned to 512 bytes (sectors), that's why -m was used
    # in 1M blocks
    rootfs_blocks=$(du -ms "${TARGET_DIR}" | awk '{print $1}')
    # From MB -> B. 
    rootfs_size=$((rootfs_blocks * 1024 * 1024))
    padded_rootfs_size=$((rootfs_size + (rootfs_size / 10)))
    echo "padded root fs size is "$padded_rootfs_size" Bytes"

    cd "${BSP_DIR}"/bootloader

	cp t210ref/nvtboot.bin nvtboot.bin
	cp t210ref/cboot.bin cboot.bin
	cp t210ref/warmboot.bin warmboot.bin
	cp t210ref/sc7entry-firmware.bin sc7entry-firmware.bin
	cp t210ref/BCT/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg \
		P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg
	cp t210ref/cfg/flash_l4t_t210_spi_sd_p3448.xml flash.xml

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
		-e "s/APPSIZE/"$padded_rootfs_size"/" \
		flash.xml
}

install_unsigned_image_files()
{
	cd "${BSP_DIR}"/bootloader
    echo "Installing BSP binaries and images..."

	install -m 0644 -D tegra210-p3448-0000-p3449-0000-b00.dtb "${BINARIES_DIR}"/tegra210-p3448-0000-p3449-0000-b00.dtb
	install -m 0644 -D cboot.bin "${BINARIES_DIR}"/cboot.bin
	install -m 0644 -D flash.xml "${BINARIES_DIR}"/flash.xml
	install -m 0644 -D nvtboot.bin "${BINARIES_DIR}"/nvtboot.bin
	install -m 0644 -D nvtboot_cpu.bin "${BINARIES_DIR}"/nvtboot_cpu.bin
	install -m 0644 -D sc7entry-firmware.bin "${BINARIES_DIR}"/sc7entry-firmware.bin
	install -m 0644 -D tos-mon-only.img "${BINARIES_DIR}"/tos-mon-only.img
	install -m 0644 -D warmboot.bin "${BINARIES_DIR}"/warmboot.bin
	install -m 0644 -D nvtboot_recovery.bin "${BINARIES_DIR}"/nvtboot_recovery.bin
	install -m 0644 -D tos-mon-only.img "${BINARIES_DIR}"/tos-mon-only.img
	install -m 0644 -D eks.img "${BINARIES_DIR}"/eks.img
	install -m 0644 -D rp4.blob "${BINARIES_DIR}"/rp4.blob
}

# tegraflash.py command for signing and generating flash-ready partition imgs:
tegraflash_sign()
{
	cd "$BSP_DIR"/bootloader
    # NOTE: Requires dtb file and boot.img to be present in the same directory
    cp "$BINARIES_DIR"/boot.img boot.img

    # TODO: Specify key
	./tegraflash.py --bl cboot.bin \
        --bct P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.cfg \
        --odmdata 0x94000 \
        --bldtb tegra210-p3448-0000-p3449-0000-b00.dtb \
        --applet nvtboot_recovery.bin \
        --cmd "sign" \
        --cfg flash.xml \
        --chip 0x21 \
        --bins "EBT cboot.bin; DTB tegra210-p3448-0000-p3449-0000-b00.dtb"

	install -m 0644 -D signed/boot.img.encrypt "${BINARIES_DIR}"/signed/boot.img.encrypt
	install -m 0644 -D signed/cboot.bin.encrypt "${BINARIES_DIR}"/signed/cboot.bin.encrypt
	install -m 0644 -D signed/flash.xml "${BINARIES_DIR}"/signed/flash.xml
	install -m 0644 -D signed/flash.xml.bin "${BINARIES_DIR}"/signed/flash.xml.bin
	install -m 0644 -D signed/nvtboot.bin.encrypt "${BINARIES_DIR}"/signed/nvtboot.bin.encrypt
	install -m 0644 -D signed/nvtboot_cpu.bin.encrypt ${BINARIES_DIR}/signed/nvtboot_cpu.bin.encrypt
	install -m 0644 -D signed/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.bct \
        "${BINARIES_DIR}"/signed/P3448_A00_4GB_Micron_4GB_lpddr4_204Mhz_P987.bct
	install -m 0644 -D signed/rcm_0_encrypt.rcm ${BINARIES_DIR}/signed/rcm_0_encrypt.rcm
	install -m 0644 -D signed/rcm_1_encrypt.rcm ${BINARIES_DIR}/signed/rcm_1_encrypt.rcm
	install -m 0644 -D signed/sc7entry-firmware.bin.encrypt ${BINARIES_DIR}/signed/sc7entry-firmware.bin.encrypt
	install -m 0644 -D signed/tegra210-p3448-0000-p3449-0000-b00.dtb.encrypt \
        "${BINARIES_DIR}"/signed/tegra210-p3448-0000-p3449-0000-b00.dtb.encrypt
	install -m 0644 -D signed/tos-mon-only.img.encrypt ${BINARIES_DIR}/signed/tos-mon-only.img.encrypt
	install -m 0644 -D signed/warmboot.bin.encrypt ${BINARIES_DIR}/signed/warmboot.bin.encrypt
}

main()
{
    install_dtb
    prepare_tegraflash_files
    # tegraflash_sign
    install_unsigned_image_files
}

main
