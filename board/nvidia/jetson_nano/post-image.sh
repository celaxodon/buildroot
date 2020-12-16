#!/usr/bin/env bash

genimage_cmd()
{
    GENIMAGE_CFG="$(dirname $0)/genimage.cfg"
    GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

    rm -rf "${GENIMAGE_TMP}"

    genimage \
        --rootpath "${TARGET_DIR}" \
        --tmppath "${GENIMAGE_TMP}" \
        --inputpath "${BINARIES_DIR}" \
        --outputpath "${BINARIES_DIR}" \
        --config "${GENIMAGE_CFG}"
}

move_app_partition()
{
    # Nano requires APP partition to be partition 1 so it can be referenced as the
    # fixed special device /dev/mmcblk0p1.
    sgdisk ${BINARIES_DIR}/sdcard.img --transpose=15:1
    sgdisk ${BINARIES_DIR}/sdcard.img -d 15
    app_part=$(gdisk -l ${BINARIES_DIR}/sdcard.img | grep APP | awk {'print $1'})
    if [[ "${app_part}" -eq 1 ]]; then
        return 0
    else
        echo "sdcard.img APP partition not found in position 1. Found instead in position ${app_part}"
        return 1
    fi
}

main()
{
    genimage_cmd
    move_app_partition
    exit $?
}

main $@
