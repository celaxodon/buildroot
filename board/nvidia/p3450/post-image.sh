#!/usr/bin/env bash

set -e

main()
{
    # Nano requires APP partition to be partition 1 so it can be referenced as the
    # fixed special device /dev/mmcblk0p1.
    sgdisk ${BINARIES_DIR}/sdcard.img --transpose=15:1
    sgdisk ${BINARIES_DIR}/sdcard.img -d 15
    app_part=$(gdisk -l ${BINARIES_DIR}/sdcard.img | grep APP | awk {'print $1'})
    if [[ "${app_part}" -eq 1 ]]; then
        exit 0
    else
        echo "sdcard.img APP partition not found in position 1. Found instead in position ${app_part}"
        exit 1
    fi
}

main $@
