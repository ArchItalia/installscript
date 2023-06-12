#!/bin/bash
# author Jonathan Sanfilippo
# installazione parte seconda chroot

# Colors
Green='\033[1;32m'
Blue='\033[1;34m'
Red='\033[1;31m'
Yellow='\033[0;33m'
Color_Off='\033[0m'




# setting variable for arch here ---------------------

localhost="localhost"
user="username"    # username solo minuscolo
realname="realname" # nome reale con iniziale maiuscola
rootpw="password"
userpw="password"
localegen="en_US.UTF-8 UTF-8" # lingua
localeconf="LANG=en_US.UTF-8"  # lingua
km="us" # keymap - lingua della tastiera
localtime="Europe/Italy" # posizione London, France etc..
ZS="16G" # dimensione massima della swap che zram deve impostare esempio 4G [4 gigabyte]
groups="wheel" # aggiungi gruppi all'utente esempio wheel,video,nordvpn etc [non eliminare wheel]
PACKAGEBASE=(wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils pipewire-pulse firewalld mtools dosfstools exfatprogs reflector acpi cronie git)
MINIGNOME=(gnome-shell nautilus gnome-console gvfs gnome-control-center xdg-user-dirs-gtk gdm xorg gnome-text-editor gnome-keyring gnome-system-monitor) #GNOME Minimal gnome installation
#p="sda2"
#p="vda2"
#p="nvme0n1p2"




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
pacman -S efibootmgr
bootctl --path=/boot install
echo "default arch-*" >> /boot/loader/loader.conf
echo "timeout 3" >> /boot/loader/loader.conf
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=/dev/$p rootflags=subvol=@ rw quiet loglevel=3 rd.system.show_status=auto rd.udev.log_level=3" > /boot/loader/entries/arch.conf

#zram udev rules 
echo "zram" > /etc/modules-load.d/zram.conf
echo 'ACTION=="add", KERNEL=="zram0", ATTR{comp_algorithm}="zstd", ATTR{disksize}="'$ZS'", RUN="/usr/bin/mkswap -U clear /dev/%k" , TAG+="systemd"' > /etc/udev/rules.d/99-zram.rules
echo "/dev/zram0 none swap defaults,pri=100 0 0 " >> /etc/fstab

for pkgbase in "${PACKAGESBASE[@]}"; do
 pacman -S $pkgbase 
done

for pkg in "${MINIGNOME[@]}"; do
 pacman -S $pkg
done
 


#servizi
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable firewalld
systemctl enable bluetooth
systemctl enable cronie
systemctl enable reflector


rm -r /home/2-parte.sh








