# Instalando [Steam](https://wiki.archlinux.org/title/Steam_(Portugu%C3%AAs)) no ArchLinux

### Instalação pacote 32 bits, driver de vídeo:

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

### Instalação do Steam:

Após a instalação do seu pacote 32 bits do driver de vídeo, finalmente, instale o Steam:

```bash
sudo pacman -S steam
```

### Corrigindo problemas:

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

### DICAS:  

* Configurar o botão fechar para minimizar a janela:  

Para fechar a janela do Steam (e removê-lo da barra de tarefas) quando pressionar x, mas continuar funcionando o Steam na bandeja, deve exportar a variável de ambiente `STEAM_FRAME_FORCE_CLOSE=1`.  

Para fazer o export da variável há 2 formas, configurando apenas para o seu usuário e para todos os usuários, caso tiver mais de 1 usuário no sistema:  

1) Para fazer o export ***apenas para o usuário***, apenas execute este comando em um terminal:  

```bash
echo 'STEAM_FRAME_FORCE_CLOSE DEFAULT=1' >> ~/.pam_environment
```

2) Alternativamente, para adicioná-lo para ***todos os usuários*** (o que eu uso), faça este comando:  

```bash
echo 'STEAM_FRAME_FORCE_CLOSE=1' | sudo tee -a /etc/environment
```
Em qualquer uma das 2 formas, para ter o efeito, deve deslogar e logar novamente.  

* Configurar início automático minimizado:  

Há algumas formas de se configurar, dependendo do GUI utilizado também. Eu uso Gnome-Shell, então irei explicar como configurar nele.  

1) Gnome-Shell:  

Abra o aplicativo "***Ajustes***" e vá até a opção "***Aplicativos de inicialização***". Clique no botão `+`, procure por Steam e selecione.  

2) Terminal:

Copie o arquivo `steam.desktop` para a pasta de usuário `~/.config/autostart`. Se não existir, crie a pasta:  

```bash
mkdir -p ~/.config/autostart
cp -a /usr/share/applications/steam.desktop ~/.config/autostart
chmod +x ~/.config/autostart/steam.desktop
```
3) Configurando Start Steam via Steam:  

Abra o Steam e clique no menú `Steam > Configurações`, vá até a aba lateral com o nome Interface e marque `Iniciar o Steam ao ligar o computador` e clique em OK.

Em qualquer uma destas opções, quando fizemos logout/login, o Steam é iniciado já na janela principal sem minimizar para o Systray. Então, se quiser que o Steam seja iniciado minimizado para o Systray, vá ao gerenciador de arquivos e vá até a pasta `~/.config/autostart`.  

Clique com o botão direito em "steam.desktop" e vá em Propriedades. Em comando adicione no final da linha o parâmetro "-silent".  
Se no seu Gnome não tiver a aba `Comandos`, clique com o botão direito e em editar. Na linha `Exec` vai ter o comando para iniciar o Steam, então coloque o parâmetro `-silent` e salve o arquivo. Vai ficar assim:  

> Exec=/usr/bin/steam-runtime %U -silent  

Após salvar, deslogue e logue no sistema para ver se deu certo.

### Instalando driver GamePad, Steam

Alguns jogos não funcionam sem ao menos reconhecer um Gamepad no sistema e, pra quem não tem um na hora de jogar, chega a ser um incômodo.  
Para resolver, a melhor maneira é instalar um [driver para XBox One Joystic](https://aur.archlinux.org/packages/xboxdrv) para emular no Steam como se estivesse usando um Controle. Assim o jogo funciona normalmente, mesmo se estiver usando um teclado. E é fácil:

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/xboxdrv.git
cd xboxdrv
makepkg -siLCfc --needed --noconfirm
sudo systemctl enable --now xboxdrv.service
```

Com isso, o problema é resolvido.  

### Configurar Gamepad

Há alguns aplicativos bons para testar e configurar os Gamepads

[jstest-gtk-git](https://aur.archlinux.org/packages/jstest-gtk-git)  
[sdl2-jstest-git](https://aur.archlinux.org/packages/sdl2-jstest-git)  
[evtest](https://archlinux.org/packages/?name=evtest)  
[evtest-qt-git](https://aur.archlinux.org/packages/evtest-qt-git)  
[qjoypad](https://aur.archlinux.org/packages/qjoypad)  
[sc-controller](https://aur.archlinux.org/packages/sc-controller)  
[antimicrox](https://aur.archlinux.org/packages/antimicrox)  


Para mim, pareceu mais fácil configurar o Gamepad usando o antimicrox, então instalei ele mesmo:  

```
cd ~/build
git clone https://aur.archlinux.org/antimicrox.git
cd antimicrox
makepkg -siLCfc --needed --noconfirm
```

Para mais informações ou se estiver usando um GamePad específico e quer instalar um driver para ele, verificar no [Wiki do ArchLinux, GamePad](https://wiki.archlinux.org/index.php/Gamepad).  

### Fontes:

[https://wiki.archlinux.org/title/Steam/Troubleshooting](https://wiki.archlinux.org/title/Steam/Troubleshooting)  
[https://wiki.archlinux.org/title/Locale#Generating_locales](https://wiki.archlinux.org/title/Locale#Generating_locales)  
[http://askubuntu.com/questions/318688/how-to-minimise-steam-to-the-unity-panel-system-tray](http://askubuntu.com/questions/318688/how-to-minimise-steam-to-the-unity-panel-system-tray)  
[https://wiki.archlinux.org/title/Steam_(Português)#Iniciar_minimizado](https://wiki.archlinux.org/title/Steam_(Portugu%C3%AAs)#Iniciar_minimizado)  

* Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  

* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
