#!/bin/bash
# author Jonathan Sanfilippo
# script per l'installazione di Arch Linux

# Colors
Green='\033[1;32m'
Blue='\033[1;34m'
Red='\033[1;31m'
Yellow='\033[0;33m'
Color_Off='\033[0m'


#nvme - M2
#p1="/dev/nvme0n1p1"
#p2="/dev/nvme0n1p2"
#p3="/dev/nvme0n1p3"

#vda - Virtual Machine
#p1="/dev/vda1"
#p2="/dev/vda2"
#p3="/dev/vda3"

#sda - SSD
#p1="/dev/sda1"
#p2="/dev/sda2"
#p3="/dev/sda3" 

#Setting - Country, editor, kernel
country="us" # us
editor="vim" # vim - nano 
kernel="linux"



#Formattazione delle partizioni - EFI, ROOT, HOME
mkfs.fat -F32 $p1
mkfs.btrfs -f $p2 
mkfs.btrfs -f $p3

#Montaggio e sottovolumi - partizione /home separata
mount $p2 /mnt           
btrfs su cr /mnt/@  
umount /mnt 
mount $p3 /mnt
btrfs su cr /mnt/@home      
umount /mnt                             
mount -o noatime,ssd,space_cache=v2,compress=zstd,discard=async,subvol=@ $p2 /mnt 
mkdir -p /mnt/boot
mount $p1 /mnt/boot 
mkdir -p /mnt/home
mount -o noatime,ssd,space_cache=v2,compress=zstd,discard=async,subvol=@home $p3 /mnt/home 

# reflector
reflector --verbose -c $country -a 6 --sort rate --save /etc/pacman.d/mirrorlist

#pacstrap
pacstrap -K /mnt base base-devel $kernel linux-firmware intel-ucode btrfs-progs $editor

#fstab
genfstab -Up /mnt > /mnt/etc/fstab


# List of packages to check
pkg="base base-devel $kernel linux-firmware intel-ucode btrfs-progs $editor"
# Get a list of installed packages
INSTALLED=$(pacman -Qqe)

# Iterate through the list of packages
  if echo "$INSTALLED" | grep -qw "$pkg"; then
    echo -e "${Green}$pkg is installed${Color_Off}"
    cp 2-parte.sh /mnt/home/
    arch-chroot /mnt 
  else
    echo -e "${Red}Some packages is NOT installed${Color_Off}"
  fi



