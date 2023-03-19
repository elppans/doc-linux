# Arch Linux AUR Helpers

### Helper Gráfico:  

Pra quem já tá acostumado com o pamac, existem 2 pacotes no AUR que dá pra usar:  

[pamac-aur](https://aur.archlinux.org/packages/pamac-aur) – Inclui apenas acessibilidade para o AUR.  
[pamac-all](https://aur.archlinux.org/packages/pamac-all) – Permite acessar não apenas o AUR, mas também os repositórios flatpak e snap.  

Porém, o pacote pamac-all, está sinalizado como "Desatualizado". Então, pra quem quer usar o pamac com suporte a Flatpak e Snap, melhor instalar o pacote pamac-aur e logo em seguida, instalar o pacote [libpamac-full](https://aur.archlinux.org/packages/libpamac-full)

Existe um pacote que seria interessante, o [pamac-zsh-completions](https://aur.archlinux.org/packages/pamac-zsh-completions), porém, o pamac a partir da versão 10.2.2 já inclui esta funcionalidade neste pacote, então NÃO instale este pacote, pois entrará em conflito com o já incluso.

### Instalar o pamac:  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/pamac-aur.git
cd pamac-aur
makepkg -siL --needed --noconfirm
```

#### Se quiser o suporte a Flatpak e Snap:

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/libpamac-full.git
cd libpamac-full
makepkg -siL --needed --noconfirm
```

Pra quem usa Plasma KDE, se não estiver aparecendo o pamac no Systray, pode dar uma olhada no pacote [pamac-tray-icon-plasma](https://aur.archlinux.org/packages/pamac-tray-icon-plasma)
Ou pode usar também o pacote [update-notifier](https://aur.archlinux.org/packages/update-notifier), que inclusive, tem suporte a mais outros Helpers

### Wrapper:

Dos Wrappers do pacman, o que me chamou mais atenção foi o [Yay](https://aur.archlinux.org/packages/yay). 
Com ele, dá pra instalar também os pacotes [pacman-contrib](https://archlinux.org/packages/community/x86_64/pacman-contrib/) e também o [arch-update](https://aur.archlinux.org/packages/arch-update).  
Pra quem usa Gnome, em vez do arch-update, pode experimentar usar o pacote [gnome-shell-extension-arch-update](https://aur.archlinux.org/packages/gnome-shell-extension-arch-update).  
Pra quem usa Plasma, pode experimentar o pacote [plasma5-applets-kde-arch-update-notifier](https://aur.archlinux.org/packages/plasma5-applets-kde-arch-update-notifier).  

### Instalar o yay:  

```bash
sudo pacman -S --needed pacman-contrib mlocate
sudo updatedb
cd ~/Downloads
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -siL --needed --noconfirm
```

#### Arch Update para quem usa Gnome:  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/gnome-shell-extension-arch-update.git
cd gnome-shell-extension-arch-update
makepkg -siL --needed --noconfirm
```

Após instalar o pacote gnome-shell-extension-arch-update, basta ir no aplicativo de extensões e ativar. Em propriedades, aba avançada, pode configurar substituindo no comando o `pamac` por `yay`.  

#### Arch Update para quem usa Plasma KDE:  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/plasma5-applets-kde-arch-update-notifier.git
cd plasma5-applets-kde-arch-update-notifier
makepkg -siL --needed --noconfirm
```
Após instalar o pacote plasma5-applets-kde-arch-update-notifier, clique com o botão direito no Painel e depois selecione "Adicionar widget".
Escolha o Widget "`Arch updater`". Após adicionar o Widget, posicione ele em alguma parte do Painel de sua preferência e então, já pode usar.
Se quiser, configurar o Arch Updater, clique com o botão direito no ícone do mesmo e depois em "Configurar Arch Updater".  

### Instalação de pacotes com yay

Se você instalou o yay, já pode usar ele mesmo para instalar os pacotes do AUR, em vez de compilar.  
Fica até mais fácil. Por exemplo:

```
yay -S gnome-shell-extension-arch-update
```

Além da opção -S, também pode usar as opções -y -u e é até bom ter este costume. Exemplo:  

```
yay -Syu plasma5-applets-kde-arch-update-notifier
```

Também existem outros Helpers, que as pessoas também gostam de usar:  

[pacaur](https://aur.archlinux.org/packages/pacaur). Porém, este Helper já é bem antigo, a última versão dele foi em 2019, então não é recomendável.  
[trizen](https://aur.archlinux.org/packages/trizen). Um bom Helper, tão conhecido quanto o Yay.  

Para mais informações, consulte [AUR_helpers (Português)](https://wiki.archlinux.org/title/AUR_helpers_(Portugu%C3%AAs)).  
Recomendavel ler também [Arch User Repository (Português)](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs))

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  

Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
