# installscript
install script for archlinux [expert mode]

InstallScript
Custom BTRFS subvolumes

![Untitled33333333333333](https://github.com/ArchItalia/installscript/assets/117321045/08205c35-f2fc-4c25-9617-e70680b6964d)



### [It] - Italiano 🇮🇹

Guida: è necessario preparare il disco partizionando come si vede nel [video](https://www.youtube.com/watch?v=OfQpp3B5zc8) utilizzando "cfdisk", le partizioni necessarie sono 4 efi, root, home, e la piccola partizione dedicata alla clonazione degli script per questa installazione. In questa procedura si assume che Swap sia gestito dopo l'installazione tramite Zram.

Una volta preparato il disco, formattare la partizione 4 in ext4, montare la partizione in /run/mount, andare nella directory /run/mount, installare git, clonare gli script dal repository, diamo i permessi con chmod +x *

A questo punto possiamo modificare 1-parte.sh e 2-part.sh tramite vim per personalizzazioni personali, una volta configurato avviando l'installazione tramite ./1-part alla fine quando entra in chroot da solo spostatevi su cd /home e avviate . /2-parte.sh

salva la partizione per il futuro con gli script già configurati nel caso tu abbia bisogno di una reinstallazione pulita, basta avviare live e montare la partizione 4 in /run/mount/ e avviare ./1-part.


### [En] - English 🇬🇧

Guide: it is necessary to prepare the disk by partitioning as seen in the [video](https://www.youtube.com/watch?v=OfQpp3B5zc8) using "cfdisk", the necessary partitions are 4 efi, root, home, and the small partition dedicated to cloning the scripts for this installation. In this procedure it is assumed that Swap is managed after installation using Zram.

Once the disk has been prepared, format partition 4 in ext4, mount the partition in /run/mount, go to the /run/mount directory, install git, clone the scripts from the ArchItalia repository, we give permissions with chmod +x *

At this point we can modify 1-part.sh and 2-part.sh through vim for personal personalities, once configured starting the installation through ./1-part at the end when it enters chroot alone move to cd /home and start ./2-part.

save the partition for future with the scripts already configured in case you need a clean reinstall, just start live and mount partition 4 in /run/mount/ and start ./1-part.

- [website](https://sites.google.com/view/architalia)
- [Github](https://github.com/ArchItalia/installscript)
- [YouTube](https://www.youtube.com/@ArchItalia)
- [Facebook](https://www.facebook.com/groups/architalia)
- [Donate](https://www.paypal.com/donate/?hosted_button_id=3C4YAF9NXMEWL)
