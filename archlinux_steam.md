# Instalando [Steam](https://wiki.archlinux.org/title/Steam_(Portugu%C3%AAs)) no ArchLinux

* Instalação pacote 32 bits, driver de vídeo:

Para instalar o Steam, deve primeiro instalar o pacote 32 bits do driver de vídeo, como mencionado em minha marcação [ArchLinux NVidia Legacy + Wayland no Gnome](https://elppans.github.io/doc-linux/archlinux_nvidia_legacy_wayland_gnome).  

Se sua placa de vídeo for da mais atual, instale o pacote [lib32-nvidia-utils](https://archlinux.org/packages/multilib/x86_64/lib32-nvidia-utils/) usando o pacman:

```bash
sudo pacman -S lib32-nvidia-utils
```

Se sua placa for como a minha, versão legacy, instale o pacote da mesma versão encontrado no AUR.  
Minha placa de vídeo no momento usa o pacote [nvidia-470xx-dkms](https://aur.archlinux.org/packages/nvidia-470xx-dkms), então devo instalar o pacote [lib32-nvidia-470xx-utils](https://aur.archlinux.org/packages/lib32-nvidia-470xx-utils):  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/lib32-nvidia-470xx-utils.git
cd lib32-nvidia-470xx-utils
makepkg -siL --needed --noconfirm
```

* Instalação do Steam:

Após a instalação do seu pacote 32 bits do driver de vídeo, finalmente, instale o Steam:

```bash
sudo pacman -S steam
```

* Corrigindo problemas:

Em minha instalação, ocorreu 2 problemas ao tentar iniciar o Steam, mas foi fácil corrigir:


1) locale:

Ao tentar iniciar o Steam, não houve resposta, e ao tentar iniciar via linha de comando, me deparei com esta mensagem:

> WARNING: setlocale('en_US.UTF-8') failed, using locale: 'C'. International characters may not work.

***Solução:***

Quando eu instalei o Arch, comentei a linha `"en_US.UTF-8 UTF-8"` no arquivo `/etc/locale.gen` e descomentei o que eu uso, porém, o Steam depende deste "locale".  
A solução foi, editar o arquivo `/etc/locale.gen` e ***DESCOMENTAR*** a linha "`en_US.UTF-8 UTF-8`" e depois gerar o locale:

```bash
sudo locale-gen
```
2) Erro 2:

Junto com o 1º erro e mesmo após soluciona-lo, continuei obtendo este erro ao tentar iniciar o Steam:

> steam.sh[8825]: Can't' find 'steam-runtime-check-requirements', continuing anyway

***Solução:***

Se sua placa de vídeo for legacy, não instale o pacote [lib32-nvidia-utils](https://archlinux.org/packages/multilib/x86_64/lib32-nvidia-utils/) do repositório multilib, instale a versão AUR da sua placa de vídeo. Para mim, [lib32-nvidia-470xx-utils](https://aur.archlinux.org/packages/lib32-nvidia-470xx-utils).  
Se já instalou, remova o Steam e o lib32-nvidia-utils:

```bash
sudo pacman -R steam lib32-nvidia-utils
```

Depois instale o pacote 32 bits da mesma versão do seu driver e somente depois, instale o Steam.  

* Fontes:

[https://wiki.archlinux.org/title/Steam/Troubleshooting](https://wiki.archlinux.org/title/Steam/Troubleshooting)  
[https://wiki.archlinux.org/title/Locale#Generating_locales](https://wiki.archlinux.org/title/Locale#Generating_locales)

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  

Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
