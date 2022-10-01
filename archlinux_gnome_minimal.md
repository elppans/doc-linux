# Instalando Gnome Minimal no ArchLinux

Uma maneira simples de se instalar o [GNOME](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs)) no [ArchLinux](https://wiki.archlinux.org/title/Main_page_(Portugu%C3%AAs)) é usando o [grupo de pacotes](https://wiki.archlinux.org/title/Meta_package_and_package_group_(Portugu%C3%AAs)), porém, se na confirmação de pacotes apenas apertar ENTER, vai instalar todos os pacotes referentes ao Gnome e então vai ser um [Gnome Shell](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs)) completo.  

### Para obter apenas o mínimo do Gnome, deve fazer a seguinte instalação:

```bash
pacman -S gnome-shell nautilus gnome-terminal gnome-tweak-tool gnome-control-center xdg-user-dirs gdm archlinux-wallpaper
```
> archlinux-wallpaper = Os papeis de parede do ArchLinux ficam localizadas em `/usr/share/backgrounds/archlinux/`. ***(OPCIONAL)***  
[xdg-user-dirs](https://wiki.archlinux.org/title/XDG_user_directories_(Portugu%C3%AAs)) = "Ferramenta para ajudar a gerenciar diretórios de usuário". Após a instalação, é recomendável fazer o comando:

```bash
xdg-user-dirs-update
```

### Para uma instalação de uma forma que fique o melhor "usável" possível deixando leve, recomendo fazer esta instalação:

```bash
sudo pacman -S gnome-shell gnome-tweaks gdm file-roller gedit gnome-control-center gnome-system-monitor gnome-terminal gvfs-google nautilus xdg-user-dirs archlinux-wallpaper
sudo systemctl enable gdm
xdg-user-dirs-update
```
* Sobre os pacotes da sugestão:  

> gvfs-google - ***OPCIONAL***, eu instalo porque gosto de acessar meu GDrive pelo gerenciador de arquivos, se não quer, tire da linha ao instalar;  
nautilus - Fiz um teste de instalação do gerenciador nemo, mas achei bem ruim no Gnome, então pra mim, a melhor opção é ele;  
gnome-tweaks - É o conhecido Gnome Tweak Tool, sempre é bom ter ele pra fazer algumas configurações que seriam trabalhosas;  
gnome-control-center - Ele não faz parte das dependências do gnome-shell, então deve adicionar na linha de instalação, ou não vai dar pra configurar o Gnome;  
[gdm](https://wiki.archlinux.org/title/GDM_(Portugu%C3%AAs)) - Gerenciador de login do Gnome. Fiz um teste com lightdm e também com o sddm e, claro, melhor o GDM mesmo.  

### Aplicação de Imagens:  

O Gnome tem seu próprio aplicativo de imagens, mas por algum motivo pra mim não funcionou corretamente.  
A melhor opção que achei foi o gthumb, que ficou perfeito. Se quiser instalar, faça:

```bash
sudo pacman -S gthumb
```

### Aplicação de Vídeos/Músicas

O padrão do Gnome é o Totem, mas em meu teste, o vídeo que usei só tocou o som e não mostrou a imagem, e além disso, não ficou integrado, por algum motivo.  
A melhor opção foi o Celluloid, que é o frontend do MPV, que funcionou perfeitamente. Se quiser usar o MPV de forma fácil sem o Celluloid, há a opção de instalar o gnome-mpv via Flatpak. Se quiser instalar o Celluloid, faça:

```bash
sudo pacman -S celluloid
```
### Aplicativos no System Tray  

O Gnome não vem com suporte a adicionar ícones dos aplicativos no Systray, como o [Telegram](https://archlinux.org/packages/community/x86_64/telegram-desktop/), [Steam](https://archlinux.org/packages/multilib/x86_64/steam/), etc.  
Para resolver, existem algumas extensões para ajudar:  

1) [gnome-shell-extension-appindicator](https://archlinux.org/packages/community/any/gnome-shell-extension-appindicator/) ***(RECOMENDÁVEL)***:  

Este é o conhecido [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/), pelos meus testes é o que melhor se integrou no Gnome-Shell e é bem leve. Tem no repositório Comunidade, então melhor instalar por ele:

```bash
sudo pacman -S gnome-shell-extension-appindicator
```

Após a instalação, reinicie o sistema e após logar, vá até o aplicativo de extensões e ative.

2) [gnome-shell-extension-tray-icons (AUR)](https://aur.archlinux.org/packages/gnome-shell-extension-tray-icons):  

Este pacote também funciona muito bem e também é bem fluido e MUITO simples. Para instalar, deve baixar do AUR:

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/gnome-shell-extension-tray-icons.git
cd gnome-shell-extension-tray-icons
makepkg -siL --needed --noconfirm
```

Após a instalação, vá até o aplicativo "Extenção" e ative-o.  
Agora, os aplicativos que adicionam ícones no Systray irão aparecer normalmente.

3) Uma outra alternativa é ativar a extenção do site [extensions.gnome, tray-icons-reloaded](https://extensions.gnome.org/extension/2890/tray-icons-reloaded/). Para usar uma extenção do site, deve seguir [mais adiante, como configurar](https://github.com/elppans/doc-linux/edit/main/archlinux_gnome_minimal.md#gnome-extensions)  

Exta extensão também tem no AUR, se quiser usar:

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/gnome-shell-extension-tray-icons-reloaded
cd gnome-shell-extension-tray-icons-reloaded
makepkg -siL --needed --noconfirm
```
### GNOME Extensions

Se quer usar as extensoes do site [Gnome Extensions](https://extensions.gnome.org/), instale o pacote [gnome-browser-connector (AUR)](https://aur.archlinux.org/packages/gnome-browser-connector), um Conector de navegador nativo para integração com [extensions.gnome.org](https://extensions.gnome.org/):

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/gnome-browser-connector.git
cd gnome-browser-connector
makepkg -siL --needed --noconfirm
```
Também deve integrar uma extenção em seu navegador:  

Chrome ou qualquer navegador com base nele: [Chrome - GNOME Shell integration](https://chrome.google.com/webstore/detail/gnome-shell-integration/gphhapmejobijbbhgpjhcjognlahblep)  

Firefox ou qualquer navegador com base nele: [Firefox - GNOME Shell integration](https://addons.mozilla.org/pt-BR/firefox/addon/gnome-shell-integration/)  

Com uma destas extensões no navegador mais o pacote Gnome Browser Connector, você já consegue instalar/habilitar/desabilitar/remover as extensões que quiser em sua Distro.  
Para mais informações, acesse [nocache, Gnome extensions no ArchLinux/Manjaro](https://nocache.org/p/how-to-install-gnome-extensions-on-arch-linux-manjaro)  

* Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
