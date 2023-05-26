# installscript
install script for archlinux [expert mode]

InstallScript
Custom BTRFS subvolumes
Video demo of custom 2-part script for installing arch linux with btrfs file system and subvolumes with separate /home partition, to be modified for your own machine and kept in a small dedicated partition.

Guide: it is necessary to prepare the disk by partitioning as seen in the video using "cfdisk", the necessary partitions are 4 efi, root, home, and the small partition dedicated to cloning the scripts for this installation. In this procedure it is assumed that Swap is managed after installation using Zram.

Once the disk has been prepared, format partition 4 in ext4, mount the partition in /run/mount, go to the /run/mount directory, install git, clone the scripts from the ArchItalia repository: # git clone https : //github.com/architalia/installscript.git , we give permissions with chmod +x *

At this point we can modify 1-part.sh and 2-part.sh through vim for personal personalities, once configured starting the installation through ./1-part at the end when it enters chroot alone move to cd /home and start ./2-part.

save the partition for future with the scripts already configured in case you need a clean reinstall, just start live and mount partition 4 in /run/mount/ and start ./1-part.

Github: https://github.com/ArchItalia/installscript
Video: [Youtube](https://www.youtube.com/watch?v=Yf1HUUUuTA4)
Facebook: https://www.facebook.com/groups/architalia
