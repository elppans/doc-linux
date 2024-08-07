# Archlinux Plasma Minimal

Uma maneira simples de se instalar o [Plasma](https://wiki.archlinux.org/title/KDE_(Portugu%C3%AAs)) no [ArchLinux](https://wiki.archlinux.org/title/Main_page_(Portugu%C3%AAs)) é usando o [grupo de pacotes](https://wiki.archlinux.org/title/Meta_package_and_package_group_(Portugu%C3%AAs)) [plasma](https://archlinux.org/groups/x86_64/plasma/), mas se na confirmação de pacotes apenas apertar ENTER, vai instalar todos os pacotes referentes ao Plasma e então vai ser um KDE Plasma completo.  
Porém, a idéia desta nota é usar uma instalação limpa e mínima, para isso deve fazer uma instalação apenas do pacote minimal ([plasma-desktop](https://archlinux.org/packages/?sort=&q=plasma-desktop)) ou básica ([plasma-meta](https://archlinux.org/packages/?sort=&q=plasma-meta)).  

### Comparando plasma-desktop e plasma-meta:

*  [plasma-desktop](https://www.archlinux.org/packages/extra/x86_64/plasma-desktop/)

Este é o menor pacote KDE Plasma no repositório Arch. Eu o instalei várias vezes, é apenas uma área de trabalho KDE Plasma simples, sem nenhum aplicativo KDE.

* [plasma-meta](https://www.archlinux.org/packages/extra/any/plasma-meta/)

É o 2º menor pacote. Um pouco mais completo, contém bluetooth (bluedevil), gerenciador de som (plasma-pa), gerenciador de tela (kscreen) e assim por diante.  
Esta é a melhor recomendação para quem quer "menos trabalho". Para usar este método veja: [Instalando Plasma Minimal (Meta)](https://elppans.github.io/doc-linux/archlinux_plasma_meta)  


### Pacotes Plasma (Mínimo):

Antes de instalar o Plasma Mínimo, é bom conhecer alguns aplicativos 

>[plasma-nm](https://archlinux.org/packages/extra/x86_64/plasma-nm/). Gerente de rede que podemos instalar e usar para conectar-se a uma rede (Wifi / Ethernet).  
[plasma-pa](https://archlinux.org/packages/extra/x86_64/plasma-pa/). Gerenciador de áudio que se integra ao Plasma desktop.  
[Dolphin](https://archlinux.org/packages/extra/x86_64/dolphin/). Gerenciador de arquivos do KDE Plasma.  
[Konsole](https://archlinux.org/packages/extra/x86_64/konsole/). Aplicativo de terminal padrão para o KDE Plasma  
[kate](https://archlinux.org/packages/extra/x86_64/kate/). Editor de texto avançado  
[kdeplasma-addons](https://archlinux.org/packages/extra/x86_64/kdeplasma-addons/)(**OPCIONAL**). Ele fornece alguns widgets extras para a barra de status, como indicador de bloqueio de caps, indicador de microfone, comutador de cores noturno, etc.  
[kde-gtk-config](https://archlinux.org/packages/extra/x86_64/kde-gtk-config/). Estilo GTK, correção de estilos. P/ configurar, após instalação, vá em Configurações> Aparência> Estilo de aplicativo> Estilo de aplicativo GNOME/GTK.  
[powerdevil](https://archlinux.org/packages/extra/x86_64/powerdevil/) (**OPCIONAL**). Se estiver instalando o kde em um dispositivo como um laptop ou notebook (**Já contém no pacote plasma-desktop**).  
[xdg-user-dirs](https://archlinux.org/packages/extra/x86_64/xdg-user-dirs/) (**OPCIONAL**). Ferramenta para ajudar a gerenciar diretórios de usuário” (**Já contém no pacote plasma-desktop**).  
Após a instalação, é recomendável fazer o comando: xdg-user-dirs-update  
[Baloo](https://archlinux.org/packages/?sort=&q=baloo). Pesquisa de ambiente, uma solução de indexação e busca de arquivos (**Já contém no pacote plasma-desktop**).  
[kdenetwork-filesharing](https://archlinux.org/packages/extra/x86_64/kdenetwork-filesharing/) (**OPCIONAL**). Configuração do compartilhamento de arquivos utilizando [samba](https://archlinux.org/packages/extra/x86_64/samba/).

## Instalando Plasma

Para instalar o mínimo, o comando deve ser feito desta maneira:  

> [plasma-workspace](https://archlinux.org/packages/?sort=&q=plasma-workspace). Sessão Plasma Wayland,  
plasma-desktop e outros aplicativos plasma requerem e instalam este pacote

```
sudo pacman -S plasma-desktop plasma-nm plasma-pa dolphin konsole kate kde-gtk-config
sudo systemctl enable --now NetworkManager
```
### Gerenciador de login padrão do KDE Plasma

> [sddm](https://archlinux.org/packages/extra/x86_64/sddm/) = X11 baseado em QML e gerenciador de exibição Wayland  
[sddm-kcm](https://archlinux.org/packages/extra/x86_64/sddm-kcm/) = Módulo de configuração do KDE para SDDM

```
sudo pacman -S sddm sddm-kcm
```

- Ativar gerenciador de login

```
sudo systemctl enable sddm
```

- Configurar Temas para o SDDM

> system settings->startup and shutdown->login screen(SDDM).  

### Pacotes de media

> [gst-libav](https://archlinux.org/packages/extra/x86_64/gst-libav/) — Codecs de libav.  
[gst-plugins-good](https://archlinux.org/packages/extra/x86_64/gst-plugins-good/) — Suporte a PulseAudio e codecs adicionais.  
[gst-plugins-ugly](https://archlinux.org/packages/extra/x86_64/gst-plugins-ugly/) — codecs adicionais.  
[gst-plugins-bad](https://archlinux.org/packages/extra/x86_64/gst-plugins-bad/) — codecs adicionais.  

```
sudo pacman -S gst-libav gst-plugins-good gst-plugins-ugly gst-plugins-bad
```

  
# Lista de pacotes para o Plasma

Fiz uma pesquisa de pacotes a dedo e testei e depois montei uma lista com pacotes que julguei serem úteis para usar no Plasma e que também são leves o suficiente, sem perder funcionalidades. E claro, além disso são pacotes que gostei de usar.  

Pacotes do repositório [AUR](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs)) devem ser compilados com [makepkg](https://wiki.archlinux.org/title/Makepkg_(Portugu%C3%AAs)) ou ser instalados com um [AUR Helper](https://elppans.github.io/doc-linux/archlinux_aur_helpers).  


### Pacotes Plasma  

> [dolphin-plugins](https://archlinux.org/packages/extra/x86_64/dolphin-plugins/). Plugins extras para o Dolphin  
[kscreen](https://archlinux.org/packages/extra/x86_64/kscreen/). Ajuste de tela  
[kinfocenter](https://archlinux.org/packages/extra/x86_64/kinfocenter/). Um utilitário que fornece informações sobre o sistema de computador  
[kfind](https://archlinux.org/packages/extra/x86_64/kfind/). Procurar arquivos e pastas  
[kcalc](https://archlinux.org/packages/extra/x86_64/kcalc/). Calculadora cientifica  
[spectacle](https://archlinux.org/packages/extra/x86_64/spectacle/). Utilitário de captura de tela do KDE.  
[ark](https://archlinux.org/packages/extra/x86_64/ark/). Gerenciador de compactação  

### Pacotes Plasma (Complementos)  

> [plasma-systemmonitor](https://archlinux.org/packages/extra/x86_64/plasma-systemmonitor/). Interface para monitorar sensores do sistema, informações de processo e outros recursos do sistema  
[yakuake](https://archlinux.org/packages/extra/x86_64/yakuake/) (**OPCIONAL**). Emulador de terminal suspenso do KDE  
[filelight](https://archlinux.org/packages/extra/x86_64/filelight/) (**Opcional**). Estatisticas de uso de discos  
[plasma-browser-integration](https://archlinux.org/packages/extra/x86_64/plasma-browser-integration/) (**OPCIONAL**). Componentes necessários para [integrar navegadores](https://community.kde.org/Plasma/Browser_Integration) no Plasma Desktop.  

### Dependências opcionais para ark  

> [p7zip](https://archlinux.org/packages/extra/x86_64/p7zip/). 7Z format support  
[unarchiver](https://archlinux.org/packages/community/x86_64/unarchiver/). unar e lsar: ferramentas Objective-C para descompactar arquivos compactados  
[unrar](https://archlinux.org/packages/extra/x86_64/unrar/).  Utilitário CLI para **des**compressão rar  

### Dependências opcionais para dolphin  

> [kdegraphics-thumbnailers](https://archlinux.org/packages/extra/x86_64/kdegraphics-thumbnailers/). Miniaturas para vários formatos de arquivos gráficos  
[ffmpegthumbs](https://archlinux.org/packages/extra/x86_64/ffmpegthumbs/). Criador de miniaturas baseado em FFmpeg para arquivos de vídeo  


### Aplicativos KDE  

> [kgamma](https://archlinux.org/packages/extra/x86_64/kgamma/) (**OPCIONAL**). Ajuste as configurações de gama do monitor  
[qbittorrent](https://archlinux.org/packages/?sort=&q=qbittorrent). Gerenciador de Torrent do KDE  
[kio-gdrive](https://archlinux.org/packages/extra/x86_64/kio-gdrive/). KIO Slave para acessar o Google Drive  
[gamemode](https://archlinux.org/packages/community/x86_64/gamemode/). Uma combinação de daemon/lib que permite que os jogos solicitem um conjunto de otimizações temporariamente aplicadas ao sistema operacional host  

### Outros pacotes  

> [guvcview](https://archlinux.org/packages/community/x86_64/guvcview/) (**OPCIONAL**). Webcam  
[skanpage](https://archlinux.org/packages/extra/x86_64/skanpage/) (**OPCIONAL**). Digitalização de Imagens  
[dragon](https://archlinux.org/packages/extra/x86_64/dragon/). Dragon Player é um reprodutor multimídia com foco na simplicidade  
[juk](https://archlinux.org/packages/extra/x86_64/juk/). Uma jukebox, tagger e gerenciador de coleção de música  
[gwenview](https://archlinux.org/packages/extra/x86_64/gwenview/). Um visualizador de imagens rápido e fácil de usar  
[okular](https://archlinux.org/packages/extra/x86_64/okular/). Visualizador de documentos  
[fastfetch](https://archlinux.org/packages/?sort=&q=fastfetch). Ferramenta de informações do sistema de linha de comando.  

### Dependências opcionais para gwenview  

> [kimageformats](https://archlinux.org/packages/extra/x86_64/kimageformats/). Support for dds, xcf, exr, psd, and more image formats  
[qt6-imageformats](https://archlinux.org/packages/extra/x86_64/qt5-imageformats/). Support for tiff, webp, and more image formats  

### Dependência opcional para okular  

> [poppler-data](https://archlinux.org/packages/extra/any/poppler-data/). Dados de codificação para a biblioteca de renderização de PDF popler  

### Navegadores

Lista dos principais navegadores usados pela maioria, pode escolher um ou mais para instalar.  

> [brave-bin (AUR)](https://aur.archlinux.org/packages/brave-bin). Navegador da Web que bloqueia anúncios e rastreadores por padrão (versão binária)  
[firefox](https://archlinux.org/packages/?sort=&q=firefox-i18n-pt-br/). Navegador da Web do mozilla.org  
[google-chrome (AUR)](https://aur.archlinux.org/packages/google-chrome). O navegador popular e confiável do Google (Stable Channel)  
[microsoft-edge-stable-bin (AUR)](https://aur.archlinux.org/packages/microsoft-edge-stable-bin). Navegador com base no Chromium  
[midori](https://archlinux.org/packages/?sort=&q=midori/). Navegador da Web leve  
[opera](https://archlinux.org/packages/?sort=&q=opera/). Um navegador da Web rápido e seguro  
[yandex-browser (AUR)](https://aur.archlinux.org/packages/yandex-browser). Navegador Web Yandex. Design minimalista com tecnologia sofisticada para tornar a web mais rápida, segura e fácil  
[vivaldi](https://archlinux.org/packages/?sort=&q=vivaldi). Um navegador avançado feito com o usuário avançado em mente.  

### Pacotes AUR

> [kde-service-menu-reimage-mod (AUR)](https://aur.archlinux.org/packages/kde-service-menu-reimage-mod). Manipulador de imagens e seus metadados.   
[simplescreenrecorder (AUR)](https://aur.archlinux.org/packages/simplescreenrecorder) (**OPCIONAL**). Gravador de tela  
[mystiq (AUR)](https://aur.archlinux.org/packages/mystiq). Converter audio e video  

## Instalando os pacotes listados:

>Não terá exemplos de instalação de navegadores.  

### Pacotes de repositorios oficiais

```
sudo pacman -S --needed dolphin-plugins kscreen kinfocenter kfind kcalc spectacle ark 
sudo pacman -S --needed plasma-systemmonitor yakuake filelight fastfetch
sudo pacman -S --needed p7zip unarchiver unrar
sudo pacman -S --needed kdegraphics-thumbnailers ffmpegthumbs 
sudo pacman -S --needed kgamma qbittorrent kio-gdrive gamemode
sudo pacman -S --needed guvcview skanpage
sudo pacman -S --needed dragon juk gwenview okular 
sudo pacman -S --needed kimageformats qt6-imageformats poppler-data
```

### Pacotes de repositorios AUR

```
yay -S kde-service-menu-reimage-mod
yay -S mystiq
yay -S simplescreenrecorder
```

### Sugestão

Se assim como eu, em seu sistema é utilizado o yay (Não sei se funciona com outros Wrappers), pode instalar um ADDON para o Plasma chamado [Arch Update](https://elppans.github.io/doc-linux/archlinux_aur_helpers#arch-update-para-quem-usa-plasma-kde) após subir o sistema com o GUI Plasma funcionando.  

### Configurar Layout teclado no Plasma  

Acesse "Configurações";  
Vá até "Hardware, Dispositivos de entrada, Teclado", aba "Layouts";  
Marque a opção "Configurar layouts";  
Clique em "Adicionar" e escolha "**Português (Brasil)**" e clique em aplicar.  

Vai aparecer o Widget de teclado no Systray, perto do ícone de rede e do relógio. É só clicar pra trocar de Layout.  

Opcionalmente, após adicionar o Layout do seu teclado, pode remover o padrão da instalação, "**Inglês (EUA)**".  

# Wayland no Plasma

- LEIA os seguintes links para compreender o que configurar em seu arquivo de variáveis:

  [Wayland, Português](https://wiki.archlinux.org/title/Wayland_(Portugu%C3%AAs))  
  [Wayland, Ing., Requiriments](https://wiki.archlinux.org/title/Wayland#Requirements)  
  [KDE, Iniciando o Plasma](https://wiki.archlinux.org/title/KDE_(Portugu%C3%AAs)#Iniciando_o_Plasma)  
  [NVidia, Vertical sync using TwinView](https://wiki.archlinux.org/title/NVIDIA_(Portugu%C3%AAs)#Vertical_sync_using_TwinView)  
  
- Pacotes usados:

  [xorg-xwayland](https://archlinux.org/packages/?sort=&q=xorg-xwayland). Usa clientes X dentro do Wayland (Parte do pacote plasma-wayland-session).  
  [plasma-wayland-protocols](https://archlinux.org/packages/?sort=&q=plasma-wayland-protocols). Protocolos específicos de plasma para Wayland (Parte do pacote plasma-wayland-session).  
  [egl-wayland](https://archlinux.org/packages/?sort=&q=egl-wayland). Plataforma externa Wayland baseada em EGLStream (Usado no [Archinstall](https://wiki.archlinux.org/title/Archinstall_(Portugu%C3%AAs))).  

Com o pacote [plasma-wayland-protocols](https://archlinux.org/packages/extra/any/plasma-wayland-protocols/) instalado, adicione no arquivo /etc/environment a variável `QT_QPA_PLATFORM=xcb` OU `QT_QPA_PLATFORM=wayland-egl`.  
Se você usa o navegador Firefox, adicione a variável `MOZ_ENABLE_WAYLAND=1`.  

> Em meus testes, Wayland com NVidia ainta está MUITO instável em comparação ao xorg, então é recomendável usar XORG como gerenciador gráfico.  
Você pode manter esta minha configuração de exemplo OU **NÃO**, é por sua conta.  

```
## KDE Wayland
#KWIN_COMPOSE=0 # Screen, Spactacle não funciona com esta linha ativada
#QT_QPA_PLATFORMTHEME=qt6ct
QT_IM_MODULE=ibus
QT_AUTO_SCREEN_SCALE_FACTOR=1
QT_QPA_EGLFS_ALWAYS_SET_MODE=1

#QT_QPA_PLATFORM=wayland
QT_QPA_PLATFORM=xcb
#QT_QPA_PLATFORM=wayland-egl
#QT_QPA_PLATFORM=eglfs
#QT_QPA_PLATFORM=linuxfb
#QT_QPA_PLATFORM=qt5cb
#QT_QPA_PLATFORM=minimal

QSG_RENDERER_LOOP=basic # Necessário para não haver BUG de processamento alto.  
GBM_BACKEND=nvidia-drm
#__GLX_VENDOR_LIBRARY_NAME=nvidia # NVidia 470.182.03-1+ não inicia login gráfico.  

__GL_SYNC_TO_VBLANK=0
KWIN_DRM_FORM_EGL_STREAMS=1
NV_PRIME_RENDER_OFFLOAD=1
VK_LAYER_NV_optimus=NVIDIA_only
#CLUTTER_DEFAULT_FPS=YOUR_MAIN_DISPLAY_REFRESHRATE
#__GL_SYNC_DISPLAY_DEVICE=YOUR_MAIN_DISPLAY_OUTPUT_NAME
__GL_ExperimentalPerfStrategy=1
__GL_MaxFramesAllowed=1
GLX_SGI_video_sync=1
GLX_OML_sync_control=1
#MOZ_ENABLE_WAYLAND=1

```
### Chromium ou baseado com Wayland  

Pra quem usa o navegador Chrome ou algum outro com base no mesmo, como o Chrome, Edge, etc. deve configurar um parâmetro no comando do arquivo .desktop ou então irá ficar muito lento.  
Primeiro copie o .desktop encontrado em `/usr/share/applications/` para `~/.local/share/applications` e depois edite.  
No exemplo, mostro como ficou a linha Exec do meu Edge:  

```
Exec=/usr/bin/microsoft-edge-stable --enable-features=UseOzonePlatform --ozone-platform=wayland %U
```

Para quem usa toutch, pode adicionar também a opção **--touch-events=enabled**.  
Para mais informações acesse [Chromium, Dicas e Truques](https://wiki.archlinux.org/title/chromium#Tips_and_tricks_2). 

# Solução de problemas no Plasma

Uma lista do que ví no Arch Wiki e também em outros locais.  
Se por acaso ocorrer um deles, vai uma dica pra ajudar.  

1) Fontes:  

Fontes em uma sessão do Plasma têm visual ruim:  
Tente instalar os pacotes [ttf-dejavu](https://archlinux.org/packages/?sort=&q=ttf-dejavu) e [ttf-liberation](https://archlinux.org/packages/?sort=&q=ttf-liberation).  

```
sudo pacman -S ttf-dejavu ttf-liberation
```

Fontes são gigantes ou parecem desproporcionais:  
Tente forçar o DPI da fonte para 96 em Configurações do sistema > Fontes.  

2) Tema:  

Não é possível alterar o tema, ícones, fontes, cores nas configurações do sistema; a maioria dos ícones não é exibida.  
Certifique-se de que a variável de ambiente QT_QPA_PLATFORMTHEME esteja desmarcada, o comando printenv QT_QPA_PLATFORMTHEME deve mostrar a saída vazia.   A variável é usada normalmente para forçar as configurações qt5ct nos aplicativos Qt.  

3) Media:  

Teclas de controle do volume, notificações e multimídia não funcionam  
Ocultar determinados itens nas configurações da área de notificação (por exemplo, Volume do áudio, Reprodutor de mídia ou Notificações) também desativa os recursos relacionados.   Ao ocultar o Volume do áudio desativa as teclas de controle de volume, Reprodutor de mídia desativa as teclas multimídia (rebobinar, parar, pausar) e ocultar Notificações desativa a exibição de notificações.  

4) Resolução:  

Não é possível alterar a resolução da tela ao executar em uma máquina virtual  
Ao executar o Plasma em uma máquina virtual VMware, VirtualBox ou QEMU, o kscreen pode não permitir alterar a resolução da tela do convidado para uma resolução superior a 800×600.  

A solução alternativa é definir a opção PreferredMode em xorg.conf.d(5). Como alternativa, tente usar um adaptador gráfico diferente na VM, por exemplo, VBoxSVGA em vez de VMSVGA para VirtualBox e Virtio em vez de QXL para QEMU. Veja [KDE Bug 407058](https://bugs.kde.org/show_bug.cgi?id=407058) para obter detalhes.  

5) CPU:  

Alto uso de CPU de kscreenlocker_greet com drivers da NVIDIA  
Como descrito no [Bug 347772](https://bugs.kde.org/show_bug.cgi?id=347772) do KDE, os drivers NVIDIA OpenGL e QML podem não funcionar bem junto com o Qt 5. Isso pode levar kscreenlocker_greet a um alto uso da CPU após desbloquear a sessão. Para contornar esse problema, defina a variável de ambiente QSG_RENDERER_LOOP como basic.  
Em seguida, mate as instâncias anteriores do greeter com killall kscreenlocker_greet.  

6) Execução administrativa:  

Senha administrativa não funciona ao executar algo que pede senha, usando o KDE  
Adicione esta variável em um arquivo do KDE:  

```
echo -e "[super-user-command]\nsuper-user-command=sudo" > $HOME/.kde4/share/config/kdesurc
```

Fontes:  

https://wiki.archlinux.org/title/KDE_(Portugu%C3%AAs)  
https://tuxinit.com/minimal-kde-plasma-install-arch-linux/  
https://www.reddit.com/r/archlinux/comments/i18oov/how_to_install_a_minimal_kde_setup/  
https://github.com/XxAcielxX/arch-plasma-install  
https://wiki.archlinux.org/title/Samba_(Portugu%C3%AAs)  
https://unix.stackexchange.com/questions/458203/smb-protocol-min-max-values-available  
https://github.com/swl-x/MystiQ/  
https://apps.kde.org/pt-br/  
https://askubuntu.com/questions/719262/how-do-i-add-custom-items-to-the-context-menu-in-dolphin-in-kde-5  
https://wiki.samba.org/index.php/Setting_up_a_Share_Using_Windows_ACLs  
https://magazine.regataos.com.br/2022/08/kde-plasma-como-personalizar-papel-de-parede-da-area-de-trabalho.html  
https://gist.github.com/winkey728/2508fa5aded52ab128163421d53428e0  
https://forum.endeavouros.com/t/change-sddm-background-picture/29812  
https://wiki.archlinux.org/title/SDDM  
https://github.com/tkashkin/GameHub/issues/681

ver também:  

https://archlinux.org/packages/extra/x86_64/plasma-desktop/  
https://archlinux.org/packages/extra/any/plasma-meta/  
https://archlinux.org/groups/x86_64/kde-applications/  
https://archlinux.org/packages/?name=kde-applications-meta  
https://archlinux.org/packages/extra/x86_64/plasma-wayland-session/  
https://github.com/XxAcielxX/arch-plasma-install  

* ### Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


* ### Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
