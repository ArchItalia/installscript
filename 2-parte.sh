#!/bin/bash
# author Jonathan Sanfilippo
# installazione parte seconda chroot



localhost="archlinux"
user="username"
realname="John Wick"
rootpw="password"
userpw="password"
localegen="en_US.UTF-8 UTF-8"
localeconf="LANG=en_US.UTF-8"
km="us"
localtime="Europe/London"
p="sda2"
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
usermod -aG wheel $user
usermod -aG video $user
#usermod -c '$realname' $user
echo "$user ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/$user
echo "$user ALL=NOPASSWD: /usr/bin/pacman" >> /etc/sudoers.d/$user
echo "$user ALL=NOPASSWD: /usr/bin/yay" >> /etc/sudoers.d/$user
echo "$user ALL=NOPASSWD: /usr/bin/vim" >> /etc/sudoers.d/$user



#systemd-boot
pacman -S efibootmgr
bootctl --path=/boot install
echo "default arch-*" >> /boot/loader/loader.conf
echo "timeout 3" >> /boot/loader/loader.conf
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=/dev/$p rootflags=subvol=@ rw quiet loglevel=3 rd.system.show_status=auto rd.udev.log_level=3" > /boot/loader/entries/arch.conf


#GNOME Minimal gnome installation
 pacman -S wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils pipewire-pulse firewalld mtools dosfstools gparted reflector acpi cronie git gnome-tweaks gnome-shell nautilus gnome-console gvfs gnome-control-center xdg-user-dirs-gtk gdm xorg evince eog gnome-text-editor gnome-keyring
 systemctl enable gdm

#Cinnamon
# pacman -S cinnamon nemo-fileroller gnome-terminal lightdm-gtk-greeter lightdm-gtk-greeter-settings xdg-user-dirs-gtk xorg wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils pipewire-pulse firewalld mtools dosfstools gparted bluez bluez-utils reflector acpi cronie git xed evince eog gnome-calculator gnome-clocks gnome-system-monitor gparted  
# systemctl enable lightdm

#XFCE
# pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings epiphany xorg wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils pipewire-pulse firewalld mtools dosfstools gparted bluez bluez-utils reflector acpi cronie pacman-contrib git wget jq gparted 
# systemctl enable lightdm

#KDE
# pacman -S sddm plasma ark konsole dolphin xorg wpa_supplicant wireless_tools netctl net-tools iw networkmanager alsa-utils  firewalld mtools dosfstools gparted bluez bluez-utils reflector acpi cronie pacman-contrib git wget jq gparted 
# systemctl enable sddm  

#servizi
systemctl enable NetworkManager
systemctl enable firewalld
#systemctl enable bluetooth
systemctl enable cronie
#systemctl enable reflector


rm -r /home/2-parte.sh








