# installscript
install script for archlinux [expert mode]

InstallScript
Custom BTRFS subvolumes

![image](https://github.com/ArchItalia/installscript/assets/117321045/ca7d2bbb-490a-420b-917a-3809c3c64bde)


- [It]🇮🇹
Demo video dello script personalizzato in 2 parti per l'installazione di arch linux con file system btrfs e sottovolumi con partizione /home separata, da modificare per la propria macchina e conservata in una piccola partizione dedicata.

Guida: è necessario preparare il disco partizionando come si vede nel video utilizzando "cfdisk", le partizioni necessarie sono 4 efi, root, home, e la piccola partizione dedicata alla clonazione degli script per questa installazione. In questa procedura si assume che Swap sia gestito dopo l'installazione tramite Zram.

Una volta preparato il disco, formattare la partizione 4 in ext4, montare la partizione in /run/mount, andare nella directory /run/mount, installare git, clonare gli script dal repository di ArchItalia: # git clone https : //github .com/architalia/installscript.git , diamo i permessi con chmod +x *

A questo punto possiamo modificare 1-part.sh e 2-part.sh tramite vim per personalizzazioni personali, una volta configurato avviando l'installazione tramite ./1-part alla fine quando entra in chroot da solo spostatevi su cd /home e avviate . /2 parti.

salva la partizione per il futuro con gli script già configurati nel caso tu abbia bisogno di una reinstallazione pulita, basta avviare live e montare la partizione 4 in /run/mount/ e avviare ./1-part.


- [En]🇬🇧
Video demo of custom 2-part script for installing arch linux with btrfs file system and subvolumes with separate /home partition, to be modified for your own machine and kept in a small dedicated partition.

Guide: it is necessary to prepare the disk by partitioning as seen in the video using "cfdisk", the necessary partitions are 4 efi, root, home, and the small partition dedicated to cloning the scripts for this installation. In this procedure it is assumed that Swap is managed after installation using Zram.

Once the disk has been prepared, format partition 4 in ext4, mount the partition in /run/mount, go to the /run/mount directory, install git, clone the scripts from the ArchItalia repository: # git clone https : //github.com/architalia/installscript.git , we give permissions with chmod +x *

At this point we can modify 1-part.sh and 2-part.sh through vim for personal personalities, once configured starting the installation through ./1-part at the end when it enters chroot alone move to cd /home and start ./2-part.

save the partition for future with the scripts already configured in case you need a clean reinstall, just start live and mount partition 4 in /run/mount/ and start ./1-part.

- Github: https://github.com/ArchItalia/installscript
- Video: [Youtube](https://www.youtube.com/watch?v=Yf1HUUUuTA4)
- Facebook: https://www.facebook.com/groups/architalia
