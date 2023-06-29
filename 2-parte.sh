#!/bin/bash
# Part 2/2
# Author Jonathan Sanfilippo - 10 Jun 2023
# Another installation method programmed through a custom script 
# prepared for File System BTRFS with subvolume creation and udev 
# zram rule for swap, but completely customizable according to the needs of your machine.
# architalialinux@gmail.com


# settings script 2

localhost="localhost" # nome machina - hostname
user="username"    # nome utente [solo minuscolo] -- username [only lowercase]
realname="realname" # nome reale [minuscolo/maiuscolo] - real name [uppercase/lowercase]
rootpw="password" # password per root -- root password
userpw="password" # password per utente -- user password
localegen="en_US.UTF-8 UTF-8" # locale encoding
localeconf="LANG=en_US.UTF-8"  # lingua locale -- local language
km="us" # lingua della tastiera -- keyboard layout
localtime="Europe/Italy" # localtime
ZS="16G" # dimensione swap zram - size swap zram
groups="wheel" # aggiungi gruppi all'utente - add groups for user
Ntools="wpa_supplicant wireless_tools netctl net-tools iw networkmanager" # set network tools
Audio="alsa-utils pipewire-pulse" # Audio packages
Utils="mtools dosfstools exfatprogs fuse" # tools 
PKGS="firewalld acpi cronie git reflector bluez bluez-utils" #general packages
DE="xorg gnome-shell nautilus gnome-console gvfs gnome-control-center xdg-user-dirs-gtk  gnome-text-editor gnome-keyring gnome-system-monitor" #GNOME [Minimal installation]
DM="gdm" # Display Manager
Service="gdm NetworkManager firewalld bluetooth cronie reflector" # Service

# [root=/dev/XXX] decommenta la nomenclatura in uso per systemd-boot IMPORTANTE! -- uncomment the nomenclature in use for systemd-boot IMPORTANT!

#p="sda2" 
#p="vda2"
#p="nvme0n1p2"

# end setting ----------------------------------------------





ln -sf /usr/share/zoneinfo/$localtime /etc/localtime 
hwclock --systohc
echo "$localegen" > /etc/locale.gen
locale-gen
echo "$localeconf" >> /etc/locale.conf
echo "KEYMAP=$km" >> /etc/vconsole.conf  
echo "$localhost" > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts 
echo "::1       localhost" >> /etc/hosts
echo root:$rootpw | chpasswd
useradd -m $user
echo $user:$userpw | chpasswd
usermod -aG $groups $user
usermod -c "$realname" $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user
#echo "$user ALL=NOPASSWD: /usr/bin/pacman" >> /etc/sudoers.d/$user
#echo "$user ALL=NOPASSWD: /usr/bin/yay" >> /etc/sudoers.d/$user
#echo "$user ALL=NOPASSWD: /usr/bin/vim" >> /etc/sudoers.d/$user



#systemd-boot
pacman -S efibootmgr --noconfirm
bootctl --path=/boot install
echo "default arch-*" >> /boot/loader/loader.conf
echo "timeout 3" >> /boot/loader/loader.conf
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=/dev/"$p" rootflags=subvol=@ rw quiet loglevel=3 rd.system.show_status=auto rd.udev.log_level=3" > /boot/loader/entries/arch.conf

#zram udev rules 
echo "zram" > /etc/modules-load.d/zram.conf
echo 'ACTION=="add", KERNEL=="zram0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="'$ZS'", RUN="/usr/bin/mkswap -U clear /dev/%k" , TAG+="systemd"' > /etc/udev/rules.d/99-zram.rules
echo "/dev/zram0 none swap defaults,pri=100 0 0 " >> /etc/fstab


pacman -S $Ntools $Utils $Audio $PKGS $DE $DM --noconfirm

systemctl enable $Service

rm -r /home/2-parte.sh #clear








