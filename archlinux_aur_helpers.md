# Arch Linux AUR Helpers

### Helper Gráfico:  

Pra quem já tá acostumado com o pamac, existem 2 pacotes no AUR que dá pra usar:  

[pamac-aur](https://aur.archlinux.org/packages/pamac-aur) – Inclui apenas acessibilidade para o AUR.  
[pamac-all](https://aur.archlinux.org/packages/pamac-all) – Permite acessar não apenas o AUR, mas também os repositórios flatpak e snap.  

### Instalar o pamac apenas com o suporte a AUR:  
>Usando o pacote [pamac-aur](https://aur.archlinux.org/packages/pamac-aur).  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/libpamac-aur.git
cd libpamac-aur
makepkg -Cris
cd -
git clone https://aur.archlinux.org/pamac-aur.git
cd pamac-aur
makepkg -Cris -L --needed --noconfirm
```

#### Instalar pamac com suporte a AUR, Flatpak e Snap:
>Usando o pacote [pamac-all](https://aur.archlinux.org/packages/pamac-all).

```bash
mkdir -p ~/build
cd ~/build
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -Cris
cd -
git clone https://aur.archlinux.org/snapd-glib.git
cd snapd-glib
makepkg -Cris
cd -
git clone https://aur.archlinux.org/libpamac-full.git
cd libpamac-full
makepkg -Cris
cd -
git clone https://aur.archlinux.org/pamac-cli.git
cd pamac-cli
makepkg -Cris
cd -
git clone https://aur.archlinux.org/pamac-all.git
cd pamac-all
makepkg -Cris --needed --noconfirm
```

Pra quem usa Plasma KDE, se não estiver aparecendo o pamac no Systray, pode dar uma olhada no pacote [pamac-tray-icon-plasma](https://aur.archlinux.org/packages/pamac-tray-icon-plasma)  
Ou pode usar também o pacote [update-notifier](https://aur.archlinux.org/packages/update-notifier), que inclusive, tem suporte a mais outros Helpers  

### Wrapper:  

Dos Wrappers do pacman, o que me chamou mais atenção foi o [Yay](https://aur.archlinux.org/packages/yay).  
Com ele, dá pra usar os pacotes [pacman-contrib](https://archlinux.org/packages/community/x86_64/pacman-contrib/) e também o [arch-update](https://aur.archlinux.org/packages/arch-update).  

### Instalar o yay:  

```bash
sudo pacman -S --needed pacman-contrib mlocate
sudo updatedb
cd ~/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -siL --needed --noconfirm
```
### Instalação de pacotes com yay

Se você instalou o yay, já pode usar ele mesmo para instalar os pacotes do AUR, em vez de compilar.  
Fica até mais fácil. Por exemplo:

```
yay -S pacote
```

Além da opção -S, também pode usar as opções -y -u e é até bom ter este costume. Exemplo:  

```
yay -Syu pacote
```

Também existem outros Helpers, que as pessoas também gostam de usar:  

[pacaur](https://aur.archlinux.org/packages/pacaur). Porém, este Helper já é bem antigo, a última versão dele foi em 2019, então não é recomendável.  
[trizen](https://aur.archlinux.org/packages/trizen). Um bom Helper, tão conhecido quanto o Yay.  

Para mais informações, consulte [AUR_helpers (Português)](https://wiki.archlinux.org/title/AUR_helpers_(Portugu%C3%AAs)).  
Recomendavel ler também [Arch User Repository (Português)](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs))

#### Arch Update

Instalar o pacote [arch-update](https://aur.archlinux.org/packages/arch-update):   

```
yay -S arch-update
systemctl --user enable --now arch-update.timer
```

Verificar o Status:  

```
systemctl --user status arch-update.timer
```

Após instalar o pacote, se estiver no Plasma, vá ao menu e ache o ícone do arch-update, clique e segure e arraste para sua barra de tarefas, deixando onde quiser.

Para mais informações, veja o [README](https://github.com/Antiz96/arch-update/blob/main/README.md) e também assista o [video com o desenvolvedor explicando como usar](https://www.youtube.com/watch?v=QkOkX70SEmo).  

__

- Grupo Telegram recomendável: [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
- Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
