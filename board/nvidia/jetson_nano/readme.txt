Intro
=====

This default configuration currently only supports the NVIDIA Jetson Nano SD,
board model p3450-0000. This configuration uses a custom U-Boot and kernel with
custom extensions and also builds the device tree files.

<link>

How to build
============

    $ make jetson_nano_defconfig
    $ make all

Note: Requires internet connectivity to download NVIDIA packages and binaries.

How to write the SD card
========================

Once the build process is finished, you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an SD card with "dd":

    $ sudo dd if=output/images/sdcard.img of=/dev/sdX
    $ sudo sync

Insert the micro SD card in your Jetson Nano and turn it on.
