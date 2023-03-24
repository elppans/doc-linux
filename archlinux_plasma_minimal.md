# Archlinux Plasma Minimal

Uma maneira simples de se instalar o [Plasma](https://wiki.archlinux.org/title/KDE_(Portugu%C3%AAs)) no [ArchLinux](https://wiki.archlinux.org/title/Main_page_(Portugu%C3%AAs)) é usando o [grupo de pacotes](https://wiki.archlinux.org/title/Meta_package_and_package_group_(Portugu%C3%AAs)), porém, se na confirmação de pacotes apenas apertar ENTER, vai instalar todos os pacotes referentes ao Plasma e então vai ser um KDE Plasma completo.

### Para obter apenas o mínimo do plasma, deve fazer a seguinte instalação

```
sudo pacman -S plasma-desktop
```

### Para obter apenas o básico do plasma, deve fazer a seguinte instalação

```
sudo pacman -S plasma-meta
```

### Comparando plasma-desktop e plasma-meta:

*  [plasma-desktop](https://www.archlinux.org/packages/extra/x86_64/plasma-desktop/)

Este é o menor pacote KDE Plasma no repositório Arch. Eu o instalei várias vezes, é apenas uma área de trabalho KDE Plasma simples, sem nenhum aplicativo KDE.

* [plasma-meta](https://www.archlinux.org/packages/extra/any/plasma-meta/)

É o 2º menor pacote. Contém bluetooth (bluedevil) e gerenciador de som (plasma-pa), gerenciador de tela (kscreen) e assim por diante. São todos pacotes separados.

### Gerenciador de login padrão do KDE Plasma

> [sddm](https://archlinux.org/packages/extra/x86_64/sddm/) = X11 baseado em QML e gerenciador de exibição Wayland  
[sddm-kcm](https://archlinux.org/packages/extra/x86_64/sddm-kcm/) = Módulo de configuração do KDE para SDDM

```
sudo pacman -S sddm sddm-kcm
```

#### Ativar gerenciador de login

```
sudo systemctl enable sddm
```

#### Configurar Temas para o SDDM

> system settings->startup and shutdown->login screen(SDDM).  

### Pacotes conjunto para o Plasma (Mínimo):

>[plasma-nm](https://archlinux.org/packages/extra/x86_64/plasma-nm/). Gerente de rede que podemos instalar e usar para conectar-se a uma rede (Wifi / Ethernet).  
[plasma-pa](https://archlinux.org/packages/extra/x86_64/plasma-pa/). Gerenciador de áudio que se integra ao Plasma desktop.  
[Dolphin](https://archlinux.org/packages/extra/x86_64/dolphin/). Gerenciador de arquivos do KDE Plasma.  
[Konsole](https://archlinux.org/packages/extra/x86_64/konsole/). Aplicativo de terminal padrão para o KDE Plasma  
[kate](https://archlinux.org/packages/extra/x86_64/kate/). Editor de texto avançado  
[kdeplasma-addons](https://archlinux.org/packages/extra/x86_64/kdeplasma-addons/)(**OPCIONAL**). Ele fornece alguns widgets extras para a barra de status, como indicador de bloqueio de caps, indicador de microfone, comutador de cores noturno, etc.  
[kde-gtk-config](https://archlinux.org/packages/extra/x86_64/kde-gtk-config/). Estilo GTK, correção de estilos. P/ configurar, após instalação, vá em Configurações> Aparência> Estilo de aplicativo> Estilo de aplicativo GNOME/GTK.  
[powerdevil](https://archlinux.org/packages/extra/x86_64/powerdevil/) (**OPCIONAL**). Se estiver instalando o kde em um dispositivo como um laptop ou notebook. **Já contém no pacote plasma-desktop**.  
 [plasma-wayland-session](https://archlinux.org/packages/?name=plasma-wayland-session) (**OPCIONAL**). Para habilitar o suporte a Wayland no Plasma  
[xdg-user-dirs](https://archlinux.org/packages/extra/x86_64/xdg-user-dirs/) (**OPCIONAL**). Ferramenta para ajudar a gerenciar diretórios de usuário”.  
Após a instalação, é recomendável fazer o comando: xdg-user-dirs-update  
Assim como powerdevil, este pacote **Já contém no pacote plasma-desktop**.    

## Instalando Plasma

Eu escolhí instalar o mínimo, então o comando para instalar deve ser feito desta maneira:  

> Como quero usar Wayland, também adicionei o pacote opcional no comando, remova o pacote da instalação se não quiser.  

> Não consegui fazer funcionar direito o compartilhamento de arquivos, nem usando o [kdenetwork-filesharing](https://archlinux.org/packages/extra/x86_64/kdenetwork-filesharing/) e nem configurando o [samba](https://archlinux.org/packages/extra/x86_64/samba/) manualmente.  
Então não vou listar o mesmo aqui.  
Se alguém, consegue fazer funcionar, por favor, comente sobre como fazer.  

```
sudo pacman -S plasma-desktop plasma-wayland-session plasma-nm plasma-pa dolphin konsole kate kde-gtk-config
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

### Pacotes de media

> [gst-libav](https://archlinux.org/packages/extra/x86_64/gst-libav/) — Codecs de libav.  
[gst-plugins-good](https://archlinux.org/packages/extra/x86_64/gst-plugins-good/) — Suporte a PulseAudio e codecs adicionais.  
[gst-plugins-ugly](https://archlinux.org/packages/extra/x86_64/gst-plugins-ugly/) — codecs adicionais.  
[gst-plugins-bad](https://archlinux.org/packages/extra/x86_64/gst-plugins-bad/) — codecs adicionais.  

```
sudo pacman -S gst-libav gst-plugins-good gst-plugins-ugly gst-plugins-bad
```

### Pesquisa do ambiente

O KDE implementa a pesquisa na área de trabalho com um software chamado [Baloo](https://archlinux.org/packages/extra/x86_64/baloo/), uma solução de indexação e busca de arquivos.  
Eu não uso Baloo, mas é uma boa dica.  

> [KWin-lowlatency](https://aur.archlinux.org/packages/kwin-lowlatency). É uma tentativa de reduzir a latência e falhas no popular compositor KWin quando estiver usando Wayland.  
Este pacote está **Sinalizado como desatualizado**, mas se quiser pode instalar.  

# Lista de pacotes para o Plasma

Fiz uma pesquisa de pacotes a dedo e testei e depois montei uma lista com pacotes que julguei serem úteis para usar no Plasma e que também são leves o suficiente, sem perder funcionalidades. E claro, além disso são pacotes que gostei de usar.  

>Se alguém souber de algum pacote que dá pra substituir um outro desta lista por ser mais leve e funcional, por favor, deixe um comentário.  

Alguns pacotes da lista são do repositório [AUR](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs)), então fiz a instalação usando o yay em vez do pacman.  
Se não usa o yay, por favor, substitua o comando para o Helper de seu uso.  
Para saber mais sobre Helper, veja [Arch Linux AUR Helpers](https://elppans.github.io/doc-linux/archlinux_aur_helpers)

## LISTA  

### Pacotes conjunto (Para um melhor uso)  

> [dolphin-plugins](https://archlinux.org/packages/extra/x86_64/dolphin-plugins/). Plugins extras para o Dolphin  
[kscreen](https://archlinux.org/packages/extra/x86_64/kscreen/). Ajuste de tela  
[kinfocenter](https://archlinux.org/packages/extra/x86_64/kinfocenter/). Um utilitário que fornece informações sobre o sistema de computador  
[kfind](https://archlinux.org/packages/extra/x86_64/kfind/). Procurar arquivos e pastas  
[kcalc](https://archlinux.org/packages/extra/x86_64/kcalc/). Calculadora cientifica  
[spectacle](https://archlinux.org/packages/extra/x86_64/spectacle/). Utilitário de captura de tela do KDE.  
[ark](https://archlinux.org/packages/extra/x86_64/ark/). Gerenciador de compactação  

### Complementos KDE  

> [plasma-systemmonitor](https://archlinux.org/packages/extra/x86_64/plasma-systemmonitor/). Interface para monitorar sensores do sistema, informações de processo e outros recursos do sistema  
[yakuake](https://archlinux.org/packages/extra/x86_64/yakuake/) (**OPCIONAL**). Emulador de terminal suspenso do KDE  
[filelight](https://archlinux.org/packages/extra/x86_64/filelight/) (**Opcional**). Estatisticas de uso de discos  
[neofetch](https://archlinux.org/packages/community/any/neofetch/). Ferramenta de informações do sistema de linha de comando.  
[btrfs-assistant (AUR)](https://aur.archlinux.org/packages/btrfs-assistant) (**OPCIONAL**). Aplicativo para gerenciar subvolumes BTRFS e instantâneos do Snapper  

### Dependências opcionais para ark  

> [p7zip](https://archlinux.org/packages/extra/x86_64/p7zip/). 7Z format support  
[unarchiver](https://archlinux.org/packages/community/x86_64/unarchiver/). unar e lsar: ferramentas Objective-C para descompactar arquivos compactados  
[rar (AUR)](https://aur.archlinux.org/packages/rar).  Utilitário CLI para compressão rar  

### Dependências opcionais para dolphin  

> [kde-service-menu-reimage (AUR)](https://aur.archlinux.org/packages/kde-service-menu-reimage). Manipulador de imagens e seus metadados. Deve instalar jhead junto  
[jhead](https://archlinux.org/packages/community/x86_64/jhead/). Analisador de informações EXIF ​​JPEG e removedor de miniaturas  
[kdegraphics-thumbnailers](https://archlinux.org/packages/extra/x86_64/kdegraphics-thumbnailers/). Miniaturas para vários formatos de arquivos gráficos  
[ffmpegthumbs](https://archlinux.org/packages/extra/x86_64/ffmpegthumbs/). Criador de miniaturas baseado em FFmpeg para arquivos de vídeo  
[ruby](https://archlinux.org/packages/community/x86_64/ruby/). Uma linguagem orientada a objetos para programação rápida e fácil  

### Aplicativos para o KDE  

> [kgamma5](https://archlinux.org/packages/extra/x86_64/kgamma5/) (**OPCIONAL**). Ajuste as configurações de gama do monitor  
[qbittorrent](https://archlinux.org/packages/community/x86_64/qbittorrent/). Gerenciador de Torrent do KDE  
[kio-gdrive](https://archlinux.org/packages/extra/x86_64/kio-gdrive/). KIO Slave para acessar o Google Drive  
[gamemode](https://archlinux.org/packages/community/x86_64/gamemode/). Uma combinação de daemon/lib que permite que os jogos solicitem um conjunto de otimizações temporariamente aplicadas ao sistema operacional host  

### Outros bons aplicativos  

> [simplescreenrecorder](https://archlinux.org/packages/community/x86_64/simplescreenrecorder/) (**OPCIONAL**). Gravador de tela  
[guvcview](https://archlinux.org/packages/community/x86_64/guvcview/) (**OPCIONAL**). Webcam  
[skanpage](https://archlinux.org/packages/extra/x86_64/skanpage/) (**OPCIONAL**). Digitalização de Imagens  
[dragon](https://archlinux.org/packages/extra/x86_64/dragon/). Dragon Player é um reprodutor multimídia com foco na simplicidade  
[clementine](https://archlinux.org/packages/community/x86_64/clementine/). Um reprodutor de música moderno e organizador de biblioteca  
[gwenview](https://archlinux.org/packages/extra/x86_64/gwenview/). Um visualizador de imagens rápido e fácil de usar  
[okular](https://archlinux.org/packages/extra/x86_64/okular/). Visualizador de documentos  
[mystiq (AUR)](https://aur.archlinux.org/packages/mystiq). Converter audio e video  

### Navegadores

Lista dos principais navegadores usados pela maioria, pode escolher um ou mais para instalar.  

> [brave-bin (AUR)](https://aur.archlinux.org/packages/brave-bin). Navegador da Web que bloqueia anúncios e rastreadores por padrão (versão binária)  
[firefox](https://archlinux.org/packages/extra/any/firefox-i18n-pt-br/). Navegador da Web do mozilla.org  
[google-chrome (AUR)](https://aur.archlinux.org/packages/google-chrome). O navegador popular e confiável do Google (Stable Channel)  
[microsoft-edge-stable-bin (AUR)](https://aur.archlinux.org/packages/microsoft-edge-stable-bin). Navegador com base no Chromium  
[midori](https://archlinux.org/packages/community/x86_64/midori/). Navegador da Web leve  
[opera](https://archlinux.org/packages/community/x86_64/opera/). Um navegador da Web rápido e seguro  
[yandex-browser (AUR)](https://aur.archlinux.org/packages/yandex-browser). O navegador da Web do Yandex. Design minimalista com tecnologia sofisticada para tornar a web mais rápida, segura e fácil  
[vivaldi](https://archlinux.org/packages/community/x86_64/vivaldi/). Um navegador avançado feito com o usuário avançado em mente.  

### Dependências opcionais para gwenview  

> [kimageformats](https://archlinux.org/packages/extra/x86_64/kimageformats/). Support for dds, xcf, exr, psd, and more image formats  
[qt5-imageformats](https://archlinux.org/packages/extra/x86_64/qt5-imageformats/). Support for tiff, webp, and more image formats  

### Dependência opcional para okular  

> [poppler-data](https://archlinux.org/packages/extra/any/poppler-data/). Dados de codificação para a biblioteca de renderização de PDF popler  
  

### Temas para o KDE (**OPCIONAL**)  

> [arch-kde-theme-git (AUR)](https://aur.archlinux.org/packages/arch-kde-theme-git). Tema elegante para o KDE Plasma com modo claro e escuro  
[archlinux-artwork (AUR)](https://aur.archlinux.org/packages/archlinux-artwork). Logotipos oficiais, ícones, rótulos de CD e outras artes do Arch Linux  
[arc-icon-theme](https://archlinux.org/packages/community/any/arc-icon-theme/). Tema do ícone do Arc. Somente lançamentos oficiais.  
[archlinux-wallpaper](https://archlinux.org/packages/community/any/archlinux-wallpaper/) (**OPCIONAL**). Os papeis de parede do pacote ficam localizadas em **/usr/share/backgrounds/archlinux**.  

## Instalando os pacotes listados:

### Pacotes de repositorios oficiais

```
sudo pacman -S --needed dolphin-plugins kscreen kinfocenter kfind kcalc spectacle ark 
sudo pacman -S --needed plasma-systemmonitor yakuake filelight neofetch
sudo pacman -S --needed p7zip unarchiver
sudo pacman -S --needed kdegraphics-thumbnailers ffmpegthumbs ruby
sudo pacman -S --needed kgamma5 qbittorrent kio-gdrive gamemode
sudo pacman -S --needed simplescreenrecorder guvcview skanpage
sudo pacman -S --needed dragon clementine gwenview okular kimageformats qt5-imageformats poppler-data
```

### Pacotes AUR

```
yay -S btrfs-assistant
yay -S rar 
yay -S kde-service-menu-reimage jhead
yay -S mystiq 
yay -S microsoft-edge-stable-bin
yay -S arch-kde-theme-git archlinux-artwork arc-icon-theme
```
### Sugestão

Se assim como eu, em seu sistema é utilizado o yay (Não sei se funciona com outros Wrappers), pode instalar um ADDON para o Plasma chamado [Arch Update](https://elppans.github.io/doc-linux/archlinux_aur_helpers#arch-update-para-quem-usa-plasma-kde) após subir o sistema com o GUI Plasma funcionando.  

# Solução de problemas no Plasma

Uma lista do que ví no Arch Wiki e também em outros locais.  
Se por acaso ocorrer um deles, vai uma dica pra ajudar.  

1) Fontes:  

Fontes em uma sessão do Plasma têm visual ruim:  
Tente instalar os pacotes [ttf-dejavu](https://archlinux.org/packages/community/any/ttf-dejavu/) e [ttf-liberation](https://archlinux.org/packages/community/any/ttf-liberation/).  

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
