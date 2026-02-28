# Arch Linux com zsh, oh my zsh e powerlevel10k

Fiz leitura de alguns tutoriais a respeito do [zsh](https://wiki.archlinux.org/title/zsh), [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) e [powerlevel10k](https://github.com/romkatv/powerlevel10k) e notei um jeito de se instalar de uma forma fácil, sem fazer muita coisa e depois se quiser, dar uma customizada a gosto.

Em todos os tutoriais que lí, deve baixar o tema e plugins princiais via git, mas se nos repositórios do Arch já tem, dá pra usar eles em vez de baixar da fonte.

* Pacotes:

Para instalar os principais pacotes, além do zsh, basta fazer o comando:

```bash
yay -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-fast-syntax-highlighting

```
* Temas:

Um bom pacote para configurar o tema é o [powerlevel10k](https://github.com/romkatv/powerlevel10k).  
No AUR tem o pacote [zsh-theme-powerlevel10k](https://aur.archlinux.org/packages/zsh-theme-powerlevel10k), mas está dando erro ao compilar. Então baixei este pacote e criei meu próprio PKGBUILD.  
O pacote depende de um outro pacote também do AUR, [gitstatus-bin](https://aur.archlinux.org/packages/gitstatus-bin). Para instalar, faça:  

```
yay -S gitstatus-bin
git clone https://github.com/elppans/zsh-theme-powerlevel10k.git
zsh-theme-powerlevel10k
makepkg -Cris
```

* [Fontes](https://github.com/romkatv/powerlevel10k#fonts):

No repositório AUR há 2 pacotes de fontes, o [nerd-fonts-noto-sans-mono](https://aur.archlinux.org/packages/nerd-fonts-noto-sans-mono) e [ttf-meslo-nerd-font-powerlevel10k](https://aur.archlinux.org/packages/ttf-meslo-nerd-font-powerlevel10k). Para instalar, basta usar o yay.  
Porém, existem 2 pacotes no repositório oficial que é equivalente ou instala a mesma coisa. Então recomendo usar estes 2 pacotes:

1. [ttf-noto-nerd](https://archlinux.org/packages/extra/any/ttf-noto-nerd/) - Equivalente ao **nerd-fonts-noto-sans-mono**
2. [ttf-meslo-nerd](https://archlinux.org/packages/extra/any/ttf-meslo-nerd/) - Equivalente ao **ttf-meslo-nerd-font-powerlevel10k**

Instalando as fontes:

```bash
sudo pacman -S ttf-noto-nerd ttf-meslo-nerd
```

Após a instalação, configure nas preferências do seu Terminal a fonte **`MesloLGS NF`**.

* Configuração:

Após a instalação dos pacotes, instale o [OMZ (Oh My Zsh)](https://github.com/ohmyzsh/ohmyzsh).  
Na página github dele ensina vários modos de instalação, aqui vou mostrar o que acho melhor e mais fácil.  
Basta fazer este comando:  

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
 Ao aparecer um menú de confirmação, digite "Y" pra confirmar a instalação.  
 
* [Tema](https://github.com/ohmyzsh/ohmyzsh/wiki/Themes):

Como o tema **PowerLevel10K** foi instalado via pacote, faça o link dele para o **diretório de temas do OMZ**:  

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

Feche e abra o Terminal.  
Na 1ª vez que abrir usando o tema, responda a todas as perguntas, para customizar o tema ao seu gosto.  

* [Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins):  

Primeiramente, faça um link dos plugins instalados via pacman para o **diretório plugins do OMZ**:  

```bash
ln -sf /usr/share/zsh/plugins/* ~/.oh-my-zsh/custom/plugins
```

Depois edite o arquivo ~/.zshrc e vá até a linha "plugins" e junto com o que estiver na linha, adicione os plugins que foram instalados via pacman:  

```
plugins=(
    git
    sudo
    web-search
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
    colored-man-pages
)
```
>Opcionalmente, já dá pra aproveitar e adicionar mais plugins que interessar da lista de [plugins do Wiki do OMZ](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins).

* Customização ***(OPCIONAL)***  

Eu gostei da idéia do plugin "[rsync](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync)", mas eu decidi criar na pasta de plugins, um com a mesma idéia, mas com uma ligeira diferença,
adicionei outro parâmetro de progresso:

```bash
mkdir -p ~/.oh-my-zsh/plugins/rsync2
touch ~/.oh-my-zsh/plugins/rsync2/rsync2.plugin.zsh
```
Com o editor de texto, adicione o conteúdo:

```
alias rsync-copy="rsync -ahz --info=progress2"  
alias rsync-move="rsync -ahz --info=progress2 --remove-source-files"  
alias rsync-update="rsync -ahzu --info=progress2"  
alias rsync-synchronize="rsync -ahzu --delete --info=progress2"
```
Com esta configuração, é feito a cópia/sincronização informando apenas uma barra de progresso.  
Para configurar como está na página, em modo verbose, deve adicionar o conteúdo desta forma:  

```
alias rsync-copy="rsync -avz --progress -h"
alias rsync-move="rsync -avz --progress -h --remove-source-files"
alias rsync-update="rsync -avzu --progress -h"
alias rsync-synchronize="rsync -avzu --delete --progress -h"
```

Há um outro modo de configurar, que fica mais fácil decorar os comandos. Só seguir este exemplo:  

```
alias cpr="rsync -ahz --info=progress2"
alias mvr="rsync -ahz --info=progress2 --remove-source-files"
alias cprup="rsync -ahzu --info=progress2"
alias cprsync="rsync -ahzu --delete --info=progress2"
alias cpr-v="rsync -avz --progress -h"
alias mvr-v="rsync -avz --progress -h --remove-source-files"
alias cprup-v="rsync -avzu --progress -h"
alias cprsync-v="rsync -avzu --delete --progress -h"
```

>Opcionalmente, pode usar a opção --stats no comando, desta forma ao copiar os arquivos mostra como resultado um resumo do que acabou de fazer.  

Depois da customização, basta adicionar na lista de plugins, no arquivo ~/.zshrc junto com os outros. Vai ficar assim:  

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
___
ZSH no [ML4W](https://www.ml4w.com/) ([Hyprland](https://hypr.land/)) 

Após instalar o ML4W, é usado o bash por padrão, mas dá pra customizar como iniciar o zsh nele, sem configurar o Shell do usuário.
Clone o repositório do oh-my-zsh para o home e instale os plugins
```bash
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME"/.oh-my-zsh
yay -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-fast-syntax-highlighting
ln -sf /usr/share/zsh/plugins/* "$HOME"/.oh-my-zsh/custom/plugins/
```
O arquivo de plugins do ZSH para configurar é este
```ini
$HOME/.config/zshrc/20-customization
```
Deve desativar o "fastfetch" no arquivo `"$HOME"/.config/bashrc/30-autostart`
```ini
if [[ $(tty) == *"pts"* ]]; then
    if [ ! -f $HOME/.config/ml4w/settings/hide-fastfetch ]; then
        #fastfetch
	       echo
    fi
fi
```
Adicionar no final do arquivo `"$HOME"/.bashrc` 
```ini
zsh
exit 0
```
Os plugins, basta deixar configurado como já mencionado mais acima.
___
* Fontes:  

[https://ohmyz.sh/](https://ohmyz.sh/)
[https://alesonmedeiros.dev.br/configurando-o-power-level-10k-com-oh-my-zsh](https://alesonmedeiros.dev.br/configurando-o-power-level-10k-com-oh-my-zsh)  
[https://blog.betrybe.com/ferramentas/oh-my-zsh/](https://blog.betrybe.com/ferramentas/oh-my-zsh/)  
[https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a](https://medium.com/tech-notes-and-geek-stuff/install-zsh-on-arch-linux-manjaro-and-make-it-your-default-shell-b0098b756a7a)  
[https://www.linuxfordevices.com/tutorials/linux/make-arch-terminal-awesome](https://www.linuxfordevices.com/tutorials/linux/make-arch-terminal-awesome)
[https://linuxhint.com/setup-configure-autocomplete-zsh/](https://linuxhint.com/setup-configure-autocomplete-zsh/)  
[https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/rsync)  

- Grupo Telegram recomendável: [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
- Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
