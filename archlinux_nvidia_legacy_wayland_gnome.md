# ArchLinux NVidia Legacy + Wayland no Gnome

Uso uma placa de vídeo NVidia, então procurei no [Wiki ArchLinux, NVidia](https://wiki.archlinux.org/title/NVIDIA_(Portugu%C3%AAs)) como instalar e, descobri que minha placa de vídeo é uma versão legada.  
Para verificar se a placa de vídeo NVidia é legada, vá até a página [nvidia, legacy-gpu](https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/) e verifique se está na lista. Se não estiver, pode instalar os pacotes oficiais do Arch Linux.  
Se sua placa de vídeo for das mais recentes, apenas instale o pacote [nvidia](https://archlinux.org/packages/extra/x86_64/nvidia) se seu kernel for versão [corrente](https://archlinux.org/packages/core/x86_64/linux/), OU [nvidia-lts](https://archlinux.org/packages/extra/x86_64/nvidia-lts) se seu Kernel for versão [lts](https://archlinux.org/packages/core/x86_64/linux-lts/).  
Antes de instalar qualquer driver NVidia, é bom verificar se a sua Distro tem o pacote [linux-headers](https://archlinux.org/packages/core/x86_64/linux-headers/) OU [linux-lts-headers](https://archlinux.org/packages/core/x86_64/linux-lts-headers/). Se não tiver, instale antes de instalar o driver.  

### Instalando o driver legado:

Para verificar qual placa de vídeo está sendo usada:  

```bash
lspci -k | grep -A 2 -E "(VGA|3D)"
```
A resposta para mim:  

> 01:00.0 VGA compatible controller: NVIDIA Corporation GK208B [GeForce GT 710] (rev a1)  

Após uma breve pesquisa, ví que tenho que instalar o pacote do AUR, [nvidia-470xx-dkms](https://aur.archlinux.org/packages/nvidia-470xx-dkms):  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/nvidia-470xx-utils.git
cd nvidia-470xx-utils
makepkg -siL --needed --noconfirm
sudo nvidia-xconfig
```
Com esta versão não é necessário configurar mais nada, então basta reiniciar o computador.  
Se seu driver de vídeo NÃO for versão legado, NÃO reinicie. Veja o resto da matéria, para configurar o módulo e o GRUB, somente depois de configurar os 2, reinicie.  

Para saber se realmente está usando o driver da NVidia após a inicialização, dê o comando:  

```bash
lsmod | grep nv
```

Deverá aparecer os módulos sendo usados:  

> nvidia_modeset       1478656  4 nvidia_drm  
nvidia              40071168  351 nvidia_uvm,nvidia_modeset

Porém, ao instalar o pacote NVidia, é desabilitado o Wayland por padrão e a Distro automaticamente começa a usar o Xorg.  
Se sua placa de vídeo usa um driver versão 470 ou menor, recomendável continuar no XORG mesmo.  
Se sua placa de vídeo usa um driver versão MAIOR que 470 e quiser usar o Wayland, deve fazer uma pequena configuração.  
Se você for usar aplicativos que usam bibliotecas 32 bits, como Jogos por exemplo, instale também o pacote [lib32-nvidia-utils](https://wiki.archlinux.org/title/Xorg_(Portugu%C3%AAs)#Instala%C3%A7%C3%A3o_de_driver). Se for usar o [Steam](https://archlinux.org/packages/multilib/x86_64/steam/) por exemplo, será listado para escolher o pacote 32 bits do driver para instalar como dependência, porém, é recomendável instalar este pacote ***ANTES*** do Steam.  

Para instalar o pacote 32 bits do driver que se encontra no repositório AUR, [nvidia-470xx-dkms](https://aur.archlinux.org/packages/nvidia-470xx-dkms), deve usar o pacote [lib32-nvidia-470xx-utils](https://aur.archlinux.org/packages/lib32-nvidia-470xx-utils):  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/lib32-nvidia-470xx-utils.git
cd lib32-nvidia-470xx-utils
makepkg -siL --needed --noconfirm
```

### Configurando o GRUB:

O Driver da versão do AUR, já é configurado de um jeito que não precisa configurar mais nada, porém, como eu estava procurando na internet como fazer o Wayland funcionar, adicionei estas opções no arquivo `/etc/default/grub`:  

```bash
i915.modeset=0 nouveau.modeset=0 nvidia-drm.modeset=1
```

Exemplo de como fica:  

> GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet i915.modeset=0 nouveau.modeset=0 nvidia-drm.modeset=1"

Depois executar:  

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot
```
Só que deu na mesma, então se não quiser adicionar, deixe como está.  
> Se sua placa de vídeo for do repositório oficial, ***DEVE*** adicionar estas opções no GRUB.  

### Configurando o módulo no initramfs:

Seguindo mais dicas do Wiki e outras páginas, também adicionei os módulos no arquivo `/etc/mkinitcpio.conf`, porém, com este pacote do AUR também não é necessário.
> Se sua placa de vídeo for do repositório oficial, ***DEVE*** adicionar estes módulos no arquivo mkinitcpio.conf:  

```bash
nvidia nvidia_modeset nvidia_uvm nvidia_drm
```

Exemplo:  

> MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)


Depois executar:  

```bash
sudo /usr/bin/mkinitcpio -P
```

> Se sua placa de vídeo for do repositório oficial, ***DEVE*** configurar também um arquivo chamado nvidia.hook, então veja [Wiki ArchLinux, NVidia, pacman hook](https://wiki.archlinux.org/title/NVIDIA_(Portugu%C3%AAs)#pacman_hook) para saber como configurar.  

### Configurando regras de inicialização:

Finalmente, após ler algumas páginas e fóruns ví algo que talvez desse certo.  

Para usar o Wayland em ez do XORG, no Gnome, após instalar o driver NVidia, edite o arquivo:

> ***/usr/lib/udev/rules.d/61-gdm.rules***

E onde está a seguinte configuração:

```bash
LABEL="gdm_disable_wayland"
RUN+="/usr/lib/gdm-runtime-config set daemon WaylandEnable false"
GOTO="gdm_end"
```

Troque o parâmetro "***false***" para "***true***". Ficando desta forma:

```bash
LABEL="gdm_disable_wayland"
RUN+="/usr/lib/gdm-runtime-config set daemon WaylandEnable true"
GOTO="gdm_end"
```

Depois reinicie.  

Após reiniciar, na hora de logar clique em seu usuário e depois na engrenagem que aparecerá no canto inferior, e escolha a opção "***Gnome sobre Wayland***". Depois logue em seu sistema.  
Após logar, abra o Terminal faça o comando para ter certeza de que está usando XORG ou Wayland:  


```bash
echo $XDG_SESSION_TYPE
```

Se retornar como resposta:

> wayland

Significa que a configuração deu certo e finalmente está usando NVidia + Wayland no Gnome.  

## Resolvendo problema de [Flickering](https://en.wikipedia.org/wiki/Flicker_(screen))  

O problema de Flickering/Tearing independe da versão do driver de vídeo.  
Em meu sistema, com interface Gnome-Shell e gerenciador de login GDM com NVidia + Wiland, estava enfrentando problemas de [Flickering](https://www.tecmundo.com.br/voxel/especiais/183041-defeitos-graficos-flicker.htm).  
Eram problemas de inconsistências com o vídeo e alguns ícones ficavam com cores estranhas, dava para perceber um certo atraso com o FPS e problema de buffer ou algo assim, na imagem.  
Seguindo o [Wiki do Arch Linux, referente ao problema de Flickering/Tearing](https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend), foi configurado apenas 2 parâmetros no sistema e deu certo:  

```bash
echo -e 'options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/tmp/' | sudo tee /etc/modprobe.d/nvidia-power-management.conf
sudo systemctl enable nvidia-suspend.service nvidia-hibernate.service
sudo reboot
```

Após bastante uso, percebi que o problema foi resolvido, pois os ícones pararam de ficar com cores estranhas e outros aplicativos pararam com o delay na imagem.

* Fontes e recomendações:

[https://wiki.archlinux.org/title/NVIDIA_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/NVIDIA_(Portugu%C3%AAs))  
[https://wiki.archlinux.org/title/Wayland_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/Wayland_(Portugu%C3%AAs))  
[https://wiki.archlinux.org/title/Kernel_mode_setting](https://wiki.archlinux.org/title/Kernel_mode_setting)  
[https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start](https://wiki.archlinux.org/title/Kernel_mode_setting#Early_KMS_start)  
[https://wiki.archlinux.org/title/Hardware_video_acceleration#NVIDIA](https://wiki.archlinux.org/title/Hardware_video_acceleration#NVIDIA)  
[https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs))  
[https://wiki.archlinux.org/title/GDM_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/GDM_(Portugu%C3%AAs))  
[https://en.wikipedia.org/wiki/GeForce_700_series](https://en.wikipedia.org/wiki/GeForce_700_series)  
[https://en.wikipedia.org/wiki/Direct_Rendering_Manager](https://en.wikipedia.org/wiki/Direct_Rendering_Manager)  
[https://howto.lintel.in/install-nvidia-arch-linux/](https://howto.lintel.in/install-nvidia-arch-linux/)  
[https://www.reddit.com/r/archlinux/comments/oq1cqg/how_to_get_nvidia_wayland_session_under_gnome/](https://www.reddit.com/r/archlinux/comments/oq1cqg/how_to_get_nvidia_wayland_session_under_gnome/)  
[https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend](https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend)  

* Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  

* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
