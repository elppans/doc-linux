# Archlinux Plasma Minimal ([Meta](https://github.com/archlinux/archinstall/blob/master/archinstall/default_profiles/desktops/plasma.py))

- Partindo do ponto em que a Distro Base já esteja instalada e funcionando.

Plasma Meta é o pacote utilizado para instalar o Plasma Minimal, porém contém um conjunto de pacotes mais completo do que o pacote Plasma Desktop.  
>Para ver a diferença leia: [ArchLinux Plasma Minimal, comparando plasma-desktop e plasma-meta](https://elppans.github.io/doc-linux/archlinux_plasma_minimal#comparando-plasma-desktop-e-plasma-meta).  

Para fazer esta instalação e deixar funcional, instale desta forma:  

```
sudo pacman --needed -Syu plasma-meta konsole kate dolphin ark plasma-workspace egl-wayland
```
Para instalar o gerenciador de login gráfico padrão do Plasma:  

```
sudo pacman -Syu sddm
sudo systemctl enable sddm
```

Para a Media, uso Pipewire em meu sistema, se for usar também:

```
sudo pacman -Syu pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire libpulse wireplumber
systemctl enable --user pipewire-pulse.service
```

## Solução de problemas

Se for testar o Discover e ver que está com [problemas](https://bbs.archlinux.org/viewtopic.php?id=289814), instale o pacote [packagekit-qt6](https://archlinux.org/packages/?sort=&q=packagekit-qt6).  

```
sudo pacman -Syu packagekit-qt6
```
>Para mais soluções de problemas veja: [KDE, Soluções de problemas](https://wiki.archlinux.org/title/KDE_(Portugu%C3%AAs)#Solu%C3%A7%C3%A3o_de_problemas).  

Esta instalação mínima já deixa o Archlinux junto com o Plasma completamente funcional.  
Porém, se quiser mais informações sobre instalação do Plasma: [ Instalando Plasma Minimal + Aplicativos no Archlinux](https://elppans.github.io/doc-linux/archlinux_plasma_minimal).  

* Grupo Telegram recomendável: [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
