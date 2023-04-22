# Arch Linux com zsh, oh my zsh e powerlevel10k

Fiz leitura de alguns tutoriais a respeito do [zsh](https://wiki.archlinux.org/title/zsh), [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) e [powerlevel10k](https://github.com/romkatv/powerlevel10k) e notei um jeito de se instalar de uma forma fácil, sem fazer muita coisa e depois se quiser, dar uma customizada a gosto.

Em todos os tutoriais que lí, deve baixar o tema e plugins princiais via git, mas se nos repositórios do Arch já tem, dá pra usar eles em vez de baixar da fonte.

* Pacotes:

Para instalar os principais pacotes, além do zsh, basta fazer o comando:

```bash
sudo pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions zsh-theme-powerlevel10k

```

* [Fontes](https://github.com/romkatv/powerlevel10k#fonts):

No repositório AUR, também há 2 pacotes de fontes que devem ser instalados, o [nerd-fonts-noto-sans-mono](https://aur.archlinux.org/packages/nerd-fonts-noto-sans-mono) e [ttf-meslo-nerd-font-powerlevel10k](https://aur.archlinux.org/packages/ttf-meslo-nerd-font-powerlevel10k):

```bash
cd Downloads
git clone https://aur.archlinux.org/nerd-fonts-noto-sans-mono.git
git clone https://aur.archlinux.org/ttf-meslo-nerd-font-powerlevel10k.git
cd nerd-fonts-noto-sans-mono
makepkg -siL --needed --noconfirm
cd ../ttf-meslo-nerd-font-powerlevel10k
makepkg -siL --needed --noconfirm
```

Após a instalação, configure nas preferências do seu Terminal a fonte `MesloLGS NF`.

* Configuração:

Após a instalação dos pacotes, basta instalar o OMZ. Na página github dele ensina vários modos de instalação, aqui vou mostrar o que acho melhor.
Basta fazer este comando e ao aparecer um menú de confirmação, digite "Y" pra confirmar a instalação:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

* [Tema](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes):

Como o tema PowerLevel10K foi instalado via pacote, faça o link dele para a pasta de temas do OMZ:

```bash
ln -sf /usr/share/zsh-theme-powerlevel10k ~/.oh-my-zsh/custom/themes
```

Para adicionar o tema, há 2 formas, pode simplesmente fazer este comando:

```bash
sed -i '/ZSH_THEME/s/robbyrussell/zsh-theme-powerlevel10k\/powerlevel10k/' ~/.zshrc
```

Ou, fazer da forma tradicional, editar o arquivo ~/.zshrc, procurar pela linha ZSH_THEME e trocar o plugin padrão pelo plugin do pacote.  
Vai ficar desta maneira:

```bash
ZSH_THEME="zsh-theme-powerlevel10k/powerlevel10k"
```

Feche e abra o Terminal, na 1ª vez que abrir usando o tema, responda a todas as perguntas, para customizar o tema ao seu gosto.

* [Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins):

Primeiramente, faça um link dos plugins instalados via pacman para a pasta plugins do OMZ:

```bash
ln -sf /usr/share/zsh/plugins/* ~/.oh-my-zsh/custom/plugins
```

Depois edite o arquivo ~/.zshrc e vá até a linha "plugins" e junto com o que estiver na linha, adicione os plugins instalados via pacman.
Já dá pra aproveitar e adicionar mais plugins que interessar da lista de [plugins do Wiki do OMZ](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins):

```
plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
        colored-man-pages
)
```

* Customização ***(OPCIONAL)***  

Eu gostei da idéia do plugin "[rsync](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync)", mas eu decidi criar na pasta de plugins, um com a mesma idéia, mas com uma ligeira diferença,
adicionei outro parâmetro de progresso:

```bash
mkdir -p ~/.oh-my-zsh/plugins/rsync2
touch ~/.oh-my-zsh/plugins/rsync2/rsync2.plugin.zsh
```
Com o editor de texto, foi adicionado o conteúdo:

```
alias rsync-copy="rsync -ahz --info=progress2"  
alias rsync-move="rsync -ahz --info=progress2 --remove-source-files"  
alias rsync-update="rsync -ahzu --info=progress2"  
alias rsync-synchronize="rsync -ahzu --delete --info=progress2"
```

Opcionalmente, pode usar a opção --stats no comando, desta forma ao copiar os arquivos mostra como resultado um resumo do que acabou de fazer.
Depois da customização, basta adicionar na lista de plugins junto com os outros. Pra mim ficou assim:

```
plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
        colored-man-pages
        rsync2
)
```

Com isso, já dá pra saber que além de usar os plugins do OMZ, dá pra criar e customizar seus próprios plugins.  

* Fontes:  

[https://ohmyz.sh/](https://ohmyz.sh/)
[https://alesonmedeiros.dev.br/configurando-o-power-level-10k-com-oh-my-zsh](https://alesonmedeiros.dev.br/configurando-o-power-level-10k-com-oh-my-zsh)  
[https://blog.betrybe.com/ferramentas/oh-my-zsh/](https://blog.betrybe.com/ferramentas/oh-my-zsh/)  
[https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a](https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a)  
[https://www.linuxfordevices.com/tutorials/linux/make-arch-terminal-awesome](https://www.linuxfordevices.com/tutorials/linux/make-arch-terminal-awesome)
[https://linuxhint.com/setup-configure-autocomplete-zsh/](https://linuxhint.com/setup-configure-autocomplete-zsh/)  
[https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync)  

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
