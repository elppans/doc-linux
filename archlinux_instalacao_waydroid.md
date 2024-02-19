# ArchLinux, Instalação e configuração do Waydroid

Uma instalação "padrão" do Waydroid, geralmente funciona como um AndroidOS, portanto existe aplicativos que NÃO tem suporte para a instalação porque o sistema não é da arquitetura ARM.  
O Waydroid também fica "mesclado" com o sistema ao ser usado, mas tem gente que não gosta disso, é onde entra o Weston, que é um compositor Waydroid.  
Quem usa X11 por algum motivo não pode usar o Waydroid nativamente, então deve usar um compositor para poder usar. Aqui, uso o Weston mesmo, mas tem outros.  
Nesta instalação, vai ser configurado para que o Waydroid funcione com suporte a aplicativos com arquitetura ARM (Para mais informações leia [Waydroid Extras Script](https://github.com/casualsnek/waydroid_script/blob/main/README.md)).  

>É necessário **atualizar** o sistema antes de iniciar a configuração e ter o pacote Kernel headers instalado.  
Em uma sessão Wayland, NÃO é necessário usar o Weston para iniciar a sessão do Waydroid e fazer as configurações necessárias  
Em uma sessão X11, DEVE usar o Weston a partir do momento que for iniciar uma sessão Waydroid  

#### - Pacotes utilizados:  

[waydroid (AUR)](https://aur.archlinux.org/packages/waydroid). Contêiner para inicializar um sistema Android completo em um sistema Linux.  
[waydroid-image-gapps (AUR)](https://aur.archlinux.org/packages/waydroid-image-gapps). Imagem Android + GAPPS pra usar no Waydroid.  
[waydroid-script-git (AUR)](https://aur.archlinux.org/packages/waydroid-script-git). Script Python para adicionar OpenGapps, Magisk, biblioteca de tradução ARM ao waydroid.  
[weston](https://archlinux.org/packages/?sort=&q=weston). Implementação de referência de um compositor Wayland.  
[binder_linux-dkms (AUR)](https://aur.archlinux.org/packages/binder_linux-dkms). Fork do driver do kernel Android por @choff em formato DKMS, apenas binder.  
[python-pyclip (AUR)](https://aur.archlinux.org/packages/python-pyclip). Utilitários de área de transferência multiplataforma que suportam dados binários e de texto.  


#### Verificar e instalar o Kernel "headers" e pré requisitos para o Waydroid:  

```
sudo pacman --needed -S "$(pacman -Qqs | grep ^linux | head -n1)"-headers curl lxc ca-certificates
```

#### Instalar Waydroid:  

```
yay --needed --noconfirm -S waydroid waydroid-image-gapps waydroid-script-git weston binder_linux-dkms python-pyclip
```

#### Corrigindo ícone do Weston:  

```
mkdir -p $HOME/.local/share/applications
cp -a /usr/share/wayland-sessions/weston.desktop $HOME/.local/share/applications
echo -e 'Categories=Utility;\nIcon=wayland\n' | tee -a $HOME/.local/share/applications/weston.desktop
```

#### Iniciar instância do Waydroid  

>Se estiver **ATUALIZANDO** a imagem do Android, DEVE adicionar o parâmetro `-f` na frente:  

```
sudo waydroid init -s GAPPS
```

#### Iniciar o container Waydroid (via SystemD)  

>Se estiver **ATUALIZANDO** a imagem do Android, DEVE utilizar o parâmetro `restart`:  
>Sempre que for usar o Waydroid, o container **DEVE** estar ativado.  

```
sudo systemctl start waydroid-container
```

#### Instalar tradutor libhoudini ARM  

```
sudo waydroid-extras install libhoudini
```

#### Configurar [emulação de entradas de toque](https://docs.waydro.id/usage/waydroid-prop-options#modify-app-behaviour):  

```
waydroid session start &
waydroid status
waydroid prop set key persist.waydroid.fake_touch
waydroid session stop
sudo systemctl restart waydroid-container
```

#### Permissão total para apps data (HACK)  

Com a sessão ativada, ative o Shell do Waydroid.  
Denstro do Shell faça toda a sequência de comandos a seguir  

```
sudo waydroid shell
```

##### - Sequência de comandos:  

```
chmod 777 -R /sdcard/Android
chmod 777 -R /data/media/0/Android
chmod 777 -R /sdcard/Android/data
chmod 777 -R /data/media/0/Android/obb
chmod 777 -R /mnt/*/*/*/*/Android/data
chmod 777 -R /mnt/*/*/*/*/Android/obb
exit
```

Agora para usar o Waydroid configurado, use o seguinte comando pra iniciar:  

```
waydroid first-launch
```

### -  Registro do Dispositivo:  

**Seguir o link** [Docs Waydroid, Google Play Certification](https://docs.waydro.id/faq/google-play-certification)  

## **EXTRA:**

[TESTE](archlinux_instalacao_waydroid.md#iniciar-o-container-waydroid-via-systemd)

* Fontes:  

https://wiki.archlinux.org/title/Waydroid#Installation  
https://docs.waydro.id/usage/install-on-desktops  
https://docs.waydro.id/faq/setting-up-waydroid-only-sessions  
https://forum.manjaro.org/t/how-to-install-run-waydroid-on-xfce-or-other-non-wayland-desktops/152925  
https://katzenbiber.de/posts/android-emulation-on-linux/  
https://github.com/waydroid/waydroid/issues/195  
https://github.com/waydroid/waydroid/issues/653#issuecomment-1368214462  
https://github.com/n1lby73/waydroid-installer/tree/main  
https://git.toradex.com/cgit/meta-toradex-demos.git/tree/recipes-graphics/wayland-app-launch/wayland-app-launch/wayland-app-launch.sh.in?h=dunfell-5.x.y  
https://gitlab.freedesktop.org/wayland/weston/-/issues/867  
https://www.proli.net/2020/04/03/developing-kwin-wayland/  
https://unix.stackexchange.com/questions/723196/font-smoothing-issues-in-flatpak-firefox-on-kde  
https://gist.github.com/stevebrun/f6739e84be26e60dfdf3c0516d580532  
https://askubuntu.com/questions/1288624/how-to-open-gnome-terminal-in-a-nested-mutterwayland-window  
https://docs.waydro.id/development/compile-waydroid-lineage-os-based-images  
https://ubuntuhandbook.org/index.php/2023/12/waydroid-run-android-apps-ubuntu/  

[Waydroid Installation on Arch Linux (Custom), YouTube (Inglês)](https://www.youtube.com/watch?v=IS219G2Je7g)  
[Install Android 11 on Arch Linux Using Waydroid (BlissOS/Lineage), YouTube (Inglês)](https://www.youtube.com/watch?v=6ib0A0hs7JM)  


