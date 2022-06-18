#!/bin/bash

cat arch/arm64/boot/Image.gz qcom/sdm636-meizu-E3.dtb > /tmp/Image.gz-dtb-meizu
#cat arch/arm64/boot/Image.gz qcom/sdm630-sony-xperia-nile-pioneer.dtb  > /tmp/Image.gz-dtb-meizu
#cat arch/arm64/boot/Image.gz qcom/sdm636-asus-x00td.dtb > /tmp/Image.gz-dtb-meizu
#cp twrp.331.img.gz /tmp/twrp.360.img.gz
#cp pmos.img.gz /tmp/twrp.360.img.gz
#cp twrp.350_mod.img.gz /tmp/twrp.360.img.gz
#cp ramdisk.331.mod_sh.gz /tmp/twrp.360.img.gz
#cp twrp.341.img.gz /tmp/twrp.360.img.gz
cp twrp.361.img.gz /tmp/twrp.360.img.gz
#cp ramdisk_v8000.img.gz  /tmp/twrp.360.img.gz
#cp ramdisk_pl2_los18.1.img.gz  /tmp/twrp.360.img.gz
cp ramdisk.los.vayu.img.gz /tmp/twrp.360.img.gz
cd /tmp/

parse_opt()
{
for i in "$@"
do
case $i in
    -e=*|--extension=*)
    EXTENSION="${i#*=}"
    shift # past argument=value
    ;;
    -s=*|--searchpath=*)
    SEARCHPATH="${i#*=}"
    shift # past argument=value
    ;;
    -l=*|--lib=*)
    LIBPATH="${i#*=}"
    shift # past argument=value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument with no value
    ;;
    *)
          # unknown option
    ;;
esac
done
}

echo "$@"
	kernel='Image.gz-dtb-meizu'
	ramdisk='twrp.360.img.gz'
	echo twrp boot

#boot image:
# boot KERNEL [RAMDISK [SECOND]]
#                            Download and boot kernel from RAM.
# flash:raw PARTITION KERNEL [RAMDISK [SECOND]]
#                            Create boot image and flash it.
# --dtb DTB                  Specify path to DTB for boot image header version 2.
# --cmdline CMDLINE          Override kernel command line.
# --base ADDRESS             Set kernel base address (default: 0x10000000).
# --kernel-offset            Set kernel offset (default: 0x00008000).
# --ramdisk-offset           Set ramdisk offset (default: 0x01000000).
# --tags-offset              Set tags offset (default: 0x00000100).
# --dtb-offset               Set dtb offset (default: 0x01100000).
# --page-size BYTES          Set flash page size (default: 2048).
# --header-version VERSION   Set boot image header version.
# --os-version MAJOR[.MINOR[.PATCH]]
#                            Set boot image OS version (default: 0.0.0).
# --os-patch-level YYYY-MM-DD
#                            Set boot image OS security patch level.

#cmdline='console=pstore1 clk_ignore_unused firmware_class.path=/vendor/firmware/ androidboot.hardware=qcom init=/init 
# androidboot.boot_devices=soc@0/1d84000.ufshc printk.devkmsg=on deferred_probe_timeout=30 buildvariant=userdebug'
# console=ttyMSM0,115200,n8 androidboot.console=ttyMSM0 earlycon=msm_serial_dm,0xc170000 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 sched_enable_hmp=1 sched_enable_power_aware=1 service_locator.enable=1 swiotlb=1 androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 androidboot.selinux=permissive loop.max_part=9 buildvariant=userdebug'
cmdline='max_cpus=1 clk_ignore_unused androidboot.hardware=qcom androidboot.configfs=true androidboot.usbcontroller=a800000.dwc3 printk.devkmsg=on androidboot.selinux=permissive'
kernel_offset='32768'
ramdisk_offset='16777216'
loadBase='0'
tag_offset='256'
osVersion='10.0.0'
osPatchLevel='2020-06-00'
headerVersion='0'
#ramdisk='twrp.img.gz'
#ramdisk='mk10.img.gz'
~/fastboot boot $kernel $ramdisk --base $loadBase --kernel-offset $kernel_offset --ramdisk-offset $ramdisk_offset --tags-offset $tag_offset --page-size 4096 --os-version $osVersion --os-patch-level $osPatchLevel --header-version $headerVersion --cmdline "$cmdline"
