# Gerenciadores de Snapshots

# Alternativas ao [btrfs-assistant](https://aur.archlinux.org/packages/btrfs-assistant)

O `btrfs-assistant (AUR)`, é uma ferramenta GUI (interface gráfica) projetada para facilitar o gerenciamento de sistemas de arquivos BTRFS. 
Porém, existem algumas alternativas nos repositórios oficiais do Arch Linux que podem oferecer funcionalidades semelhantes:  

## [grub-btrfs](https://archlinux.org/packages/extra/any/grub-btrfs/)
O pacote `grub-btrfs` inclui snapshots do BTRFS nas opções de boot do GRUB.  
```bash
sudo pacman -S grub-btrfs
```

## [snapper](https://archlinux.org/packages/extra/x86_64/snapper/)
O `snapper` é uma ferramenta de gerenciamento de snapshots para sistemas de arquivos BTRFS e LVM. Ele permite criar, listar, excluir e comparar snapshots. 
```bash
sudo pacman -S snapper
```

## [timeshift](https://archlinux.org/packages/extra/x86_64/timeshift/)
O `timeshift` é uma ferramenta popular para backups e restauração de snapshots, especialmente útil para sistemas BTRFS.  
```bash
sudo pacman -S timeshift
```

Essas ferramentas podem ajudar a gerenciar snapshots e restaurar o sistema de maneira eficiente.  
