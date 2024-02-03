# Archinstall, Tips pós instalação  

- -1.  Vídeo Auto-Resizing no VMWare  

Se for usar uma instalação em VMWare, mesmo que escolha o tipo de vídeo durante a instalação:  

>"... Graphics driver: VMWare/VirtualBox (open-source)"  

O vídeo após o sistema instalado e iniciado em seu Desktopo GUI, não será redimencionado para o tamanho da tela correta.  
Para resolver isso, deve instalar o pacote open-vm-tools e ativar o serviço, não é necessário reiniciar:  
>Não testei em Virtual Box  

```
sudo pacman -Syu open-vm-tools
sudo systemctl enable --now vmtoolsd vmware-vmblock-fuse
```

- -2. Gnome Software

O Gnome Software fornece apenas aplicativos em Flatpak. SE quiser usar o aplicativo para gerenciar as instalações no Arch Gnome, deve instalar o Plugin que está no AUR:  

>[gnome-software-packagekit-plugin-git (AUR)](https://aur.archlinux.org/packages/gnome-software-packagekit-plugin-git). PackageKit support plugin for GNOME Software  
>Será atualizado apenas pacotes oficiais, não há suporte ao AUR.  

Ao instalar, será instalado como dependência o pacote [gnome-software.git](https://aur.archlinux.org/packages/gnome-software-git) e será informado que ele e o [gnome-software](https://archlinux.org/packages/?sort=&q=gnome-software) estão em conflito.  
Responda "**S**" para remover o que está instalado e instalar a versão do AUR:

```
yay -Syu gnome-software-packagekit-plugin-git
```
- -3. Discover

O Discover, que é a Central de Software do Plasma, NÃO fornece suporte aos pacotes do Archlinux.  
Pra resovler deve ser instalado o pacote [packatekit-qt5](https://archlinux.org/packages/?sort=&q=packagekit-qt5):  

```
sudo pacman -Syu packatekit-qt5
```

* Fontes:

[https://arcolinux.com/installing-and-removing-software-using-gnome-software/](https://arcolinux.com/installing-and-removing-software-using-gnome-software/)  
[https://linuxdicasesuporte.blogspot.com/2022/05/discover-no-arch-linux.html](https://linuxdicasesuporte.blogspot.com/2022/05/discover-no-arch-linux.html)


