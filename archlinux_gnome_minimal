# Instalndo Gnome Minimal no ArchLinux

* [GNOME](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs))  

Após uma pequena pesquisa na internet, achei uma boa combinação de pacotes para uma [instalação mínima do Gnome](https://gist.github.com/thacoon/96e66f5d475a059cc6d66b61c6366b7a):

```bash
pacman -S gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center xdg-user-dirs gdm archlinux-wallpaper
```
> archlinux-wallpaper = Os papeis de parede do ArchLinux ficam localizadas em `/usr/share/backgrounds/archlinux/`. ***(OPCIONAL)***  
[xdg-user-dirs](https://wiki.archlinux.org/title/XDG_user_directories_(Portugu%C3%AAs)) = "Ferramenta para ajudar a gerenciar diretórios de usuário". Após a instalação, é recomendável fazer o comando:

```bash
xdg-user-dirs-update
```

16.1) Para uma instalação de uma forma que fique o melhor "usável" possível deixando leve, recomendo fazer esta instalação:

```bash
sudo pacman -S gnome-shell gnome-tweaks gdm file-roller gedit gnome-control-center gnome-system-monitor gnome-terminal gvfs-google nautilus xdg-user-dirs archlinux-wallpaper
sudo systemctl enable gdm
xdg-user-dirs-update
```
Sobre os pacotes da sugestão:  

gvfs-google - ***OPCIONAL***, eu instalo porque gosto de acessar meu GDrive pelo gerenciador de arquivos, se não quer, tire da linha ao instalar;  
nautilus - Fiz um teste de instalação do gerenciador nemo, mas achei bem ruim no Gnome, então pra mim, a melhor opção é ele;  
gnome-tweaks - É o conhecido Gnome Tweak Tool, sempre é bom ter ele pra fazer algumas configurações que seriam trabalhosas;  
gnome-control-center - Ele não faz parte das dependências do gnome-shell, então deve adicionar na linha de instalação, ou não vai dar pra configurar o Gnome;  
gdm - Gerenciador de login do Gnome. Fiz um teste com lightdm e também com o sddm e, claro, melhor o GDM mesmo.  

16.2) Aplicação de Imagens ***(Sugestão)***:  

O Gnome tem seu próprio aplicativo de imagens, mas por algum motivo pra mim não funcionou corretamente.  
A melhor opção que achei foi o gthumb, que ficou perfeito. Se quiser instalar, faça:

```bash
sudo pacman -S gthumb
```

16.3) Aplicação de Vídeos/Músicas

O padrão do Gnome é o Totem, mas em meu teste, o vídeo que usei só tocou o som e não mostrou a imagem, e além disso, não ficou integrado, por algum motivo.  
A melhor opção foi o Celluloid, que é o frontend do MPV, que funcionou perfeitamente. Se quiser usar o MPV de forma fácil sem o Celluloid, há a opção de instalar o gnome-mpv via Flatpak. Se quiser instalar o Celluloid, faça:

```bash
sudo pacman -S celluloid
```
17) Suite Office ***(OPCIONAL)***

[libreoffice](https://wiki.archlinux.org/title/LibreOffice) - São 2 versões para escolher e instalar:  

> still - Versão estável, para usuários conservadores.  
fresh - Versão corrente, com pacotes mais atuais, novos aprimoramentos do programa para os primeiros usuários ou usuários avançados.  

Se quiser instalar, escolha a versão e faça, como no exemplo:

```bash
sudo pacman -S libreoffice-fresh-pt-br
```

[onlyoffice](https://www.onlyoffice.com/blog/pt-br/) - Uma boa alternativa de uma suite office. Mais fácil de usar, principalmente para os novatos no Linux.  
Este pacote fica no repositório AUR, então se quiser instalar, faça:  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/onlyoffice-bin.git
cd onlyoffice-bin
makepkg -sirL --needed --noconfirm
```

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


Para comentários e sugestões, [clique aqui](https://github.com/elppans/guias/issues)
