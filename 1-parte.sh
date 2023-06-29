#!/bin/bash
# Part 1/2
# Author Jonathan Sanfilippo - 10 Jun 2023
# Another installation method programmed through a custom script 
# prepared for File System BTRFS with subvolume creation and udev 
# zram rule for swap, but completely customizable according to the needs of your machine.
# architalialinux@gmail.com



#  --- settings script 1

country="us" # Mirror region
age="6" # Age server mirrors
editor="vim" # choose a editor 
kernel="linux" # kernel
FM="linux-firmware" # firmware
tools="intel-ucode btrfs-progs" # tools
base="base base-devel" # base packages
#lvm="lvm2" # lvm package [important!]



# --- nomenclatura --- nomenclature

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

#lvm - volume fisici
#p1="sda1" # boot
#disk1="/dev/sda2"
#disk2="/dev/sdb1"
#disk3="/dev/sdc1"
#disk4="/dev/sdd1"
#phisicalVolumes="$disk1 $disk2 $disk3 $disk4"
#volumeGroup="lvm"
#dimensioneRoot="40" # GiB
#dimensioneSwap="8" # GiB



# --- Tipo di installazione - type of installation

#type="btrfs"
#type="ext4"
#type="vlm"


# end settings -----------------------------------------------
##############################################################



btrfs(){
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
mkdir -p /mnt/{boot,home}
mount $p1 /mnt/boot 
mount -o noatime,ssd,space_cache=v2,compress=zstd,discard=async,subvol=@home $p3 /mnt/home 
}

ext4(){
#Formattazione delle partizioni - EFI, ROOT, HOME
mkfs.fat -F32 $p1
mkfs.ext4 -f $p2 
mkfs.ext4 -f $p3

#Montaggio - partizione /home separata                             
mount $p2 /mnt 
mkdir -p /mnt/{boot,home}
mount $p1 /mnt/boot 
mount $p3 /mnt/home 
}

lvm(){
#volume fisici
pvcreate $phisicalVolumes

#volume group
vgcreate $volumeGroup $phisicalVolumes

# logical Volume
lvcreate -L $dimensioneRoot -n root
lvcreate -L $dimensioneSwap -n swap
lvcreate -l 100%FREE $volumeGroup -n home

#Formattazione delle partizioni - EFI, ROOT, HOME
mkfs.fat -F32  /dev/$p1
mkfs.ext4 -f   /dev/$volumeGroup/root
mkfs.ext4 -f   /dev/$volumeGroup/home
mkswap         /dev/$volumeGroup/swap

#Montaggio - partizione /home separata                             
mount  /dev/$volumeGroup/root /mnt 
mkdir -p /mnt/{boot,home}
mount  /dev/$volumeGroup/home /mnt/home
mount  /dev/$p1 /mnt/boot
swapon /dev/$volumeGroup/swap
}



# type of installation
$type


# reflector
reflector --verbose -c $country -a $age --sort rate --save /etc/pacman.d/mirrorlist

#pacstrap
pacstrap -K /mnt $base $FM $kernel $tools $editor $lvm

#fstab
genfstab -Up /mnt > /mnt/etc/fstab


cp 2-parte.sh /mnt/home/
echo ""
echo "Installscript: Prima parte conclusa"
echo "Avvia la seconda parte cd /home && ./2-parte.sh"
arch-chroot /mnt 
  



