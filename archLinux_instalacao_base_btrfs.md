# Instalando o Arch Linux (BASE) configurando BTRFS

Partindo do ponto de que [foi feito o boot do instalador no computador "1.1 a 1.4"](https://wiki.archlinux.org/title/Installation_guide_(Portugu%C3%AAs)):

1) Teclado:

```bash
loadkeys br-abnt2
```

2) Lista de espelhos:

Primeiro, fazer um teste de comunicação com a internet:

```bash
ping -c 4 archlinux.org
```

Se não tiver comunicação com a internet, seguir as etapas descritas no [Arch Wiki, guia de instalação](https://wiki.archlinux.org/title/Installation_guide_(Portugu%C3%AAs)#Conectar_%C3%A0_internet)

Também pode dar uma lida nestes links:  
[Diolinux, Como instalar ArchLinux](https://diolinux.com.br/sistemas-operacionais/arch-linux/como-instalar-arch-linux-tutorial-iniciantes.html)  
[Arch Wiki, Network configuration](https://wiki.archlinux.org/title/Network_configuration#Static_IP_address)

Configurar espelhos:

```bash
reflector --verbose --latest 3 --sort rate --country Brazil --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
pacman -Syy
```


3) Configurando partições e usando BTRFS, usando como exemplo: /dev/sda de 35 GB:

```bash
cgdisk /dev/sda
```

Configuração:

> sda1 = Swap, Código 8200, 2GB ([Se tiver 4+ GB RAM, recomendável 4 GB Swap](https://access.redhat.com/documentation/pt-br/red_hat_enterprise_linux/6/html/installation_guide/s2-diskpartrecommend-x86))  
sda2 = EFI, Código ef00, 600MB (Recomendado ter no mínimo 512mb)  
sda3 = ROOT, Código 8300, 32,4GB

3.1) Formatando

```bash
mkswap -L swap /dev/sda1 && swapon /dev/sda1
mkfs.fat -F32 -n EFI /dev/sda2
mkfs.btrfs /dev/sda3
```

3.2) Montando partição BTRFS e criando subvolumes:

Sobre os principais subvolumes:


> @ - Este é o subvolume raiz principal no topo do qual todos os subvolumes serão montados.  
@home - Diretório HOME, se for usar uma partição separada, não adicionar nos comandos  
@cache - Contém [dados armazenados em cache de aplicativos](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch05s05.html)  
@log - Contém todos os [arquivos de logs do Linux](https://www.cyberciti.biz/faq/linux-log-files-location-and-how-do-i-view-logs-files/)  
@var - Contém logs, temp. arquivos, caches, jogos, etc. ***(Recomendável NÃO USAR ESTE SUBVOLUME. Use @cache e @log)***  
@opt - Contém produtos de terceiros ***(Opcional)***  
@tmp - Contém certos arquivos e caches temporários ***(por ser uma pasta volátil, é recomendável NÃO USAR ESTE SUBVOLUME)***  
@.snapshots - Diretório para armazenar instantâneos para o pacote snapper ***(pode excluir isso se você planeja usar Timeshift)***  

Pode-se usar o subvolume e a configuração que quiser, dependendo do que for fazer com o sistema;  

> Se você usa a pasta /home em uma partição separada, não é necessário criar um subvolume @home, monte diretamente o seu /home na sua partição respectiva;  

```bash
mount /dev/sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@log
umount /mnt
```

3.3) Montando subvolumes BTRFS:

Opções utilizadas:

> noatime - Sem tempo de acesso. Melhora o desempenho do sistema ao não escrever a hora em que o arquivo foi acessado (relatime é o mesmo, mas para arquivos e pastas)  
commit - Intervalo peridóico (em segundos) no qual os dados são sincronizados com o armazenamento permanente  
compress - Escolhendo o algoritmo para compactar. Zstd, tem um bom nível de compactação e velocidade.  
space_cache - Permite que o kernel saiba onde o bloco de espaço livre está em um disco para permitir que ele grave dados imediatamente após a criação do arquivo.  
subvol - Escolhendo o subvol para montar.  
discard=async - [Suporte a descarte assíncrono](https://wiki.archlinux.org/title/btrfs#SSD_TRIM)  
autodefrag - [Auxiliar de desfragmentação automática](https://www.thegeekdiary.com/how-to-tune-btrfs-filesystem-for-better-performance/).  
ssd - Se está instalando no ssd, use a opção "ssd".

Montando volume principal (root):

```bash
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@ /dev/sda3 /mnt
```

Criando pastas para os subvolumes:

```bash
mkdir -p /mnt/{boot/efi,home,var/cache,var/log}
```

Montando os subvolumes:

```bash
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@home  /dev/sda3 /mnt/home
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@cache  /dev/sda3 /mnt/var/cache
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@log  /dev/sda3 /mnt/var/log
```

3.4) Montando EFI:

```bash
mount /dev/sda2 /mnt/boot/efi
```

3.5) Verificar se as partições montadas estão realmente montadas:

```bash
mount
```

5) Instalar o sistema base

Sobre os principais pacotes:

base - sistema linux básico  
linux - [Kernel](https://wiki.archlinux.org/title/Kernel_(Portugu%C3%AAs)) e módulos linux mais recentes (você pode substituir por linux-lts se quiser um kernel mais estável)  
linux-headers - Cabeçalhos e scripts para construir módulos para o kernel Linux (também pode substituir por linux-lts-headers)  
linux-firmware - Arquivos de firmware para linux (você pode pular isso em uma vm)  
intel-ucode - Arquivos de atualização de [microcódigo](https://wiki.archlinux.org/title/Microcode) para CPUs Intel  
amd-ucode - Imagem de atualização de [microcódigo](https://wiki.archlinux.org/title/Microcode) para CPUs AMD  
btrfs-progs - utilitários do sistema de arquivos Btrfs  
nano - Um editor de texto simples baseado em terminal  
ntp - Implementação de referência do Network Time Protocol  
reflector - [Update mirrors](https://wiki.archlinux.org/title/Reflector_(Portugu%C3%AAs)) ***(Opcional)***  


Um sistema mínimo exige o pacote do grupo base, também a instalação do grupo de pacote base-devel neste momento é altamente recomendado.  
> Ps.: Eu uso uma máquina com CPU Intel, então vou usar o pacote ***"intel-ucode"***. Se você usa máquina com CPU AMD, troque o pacote por ***"amd-ucode"***.  

```bash
pacstrap /mnt base base-devel linux linux-headers linux-firmware intel-ucode btrfs-progs nano ntp reflector
```

6) Gerar o fstab

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

7) Acesso ao sistema via Chroot

```bash
arch-chroot /mnt
```
8) Fuso horário

```bash
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
ntpdate a.ntp.br
hwclock -w
```

9) Locales

```bash
sed -i '/en_US/s/^/#/' /etc/locale.gen
sed -i '/pt_BR.UTF-8/s/#//' /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
echo KEYMAP=br-abnt2 >> /etc/vconsole.conf
export LANG=pt_BR.UTF-8
```

10) HOSTNAME:

> Ps.: Hostname criado para o teste: ***archvm***  

```bash
HOSTNAME="archvm"
echo -e "$HOSTNAME" | tee /etc/hostname
echo -e "
127.0.0.1  localhost
127.0.1.1  "$HOSTNAME"
::1        localhost ip6-localhost ip6-loopback
ff02::1    ip6-allnodes
ff02::2    ip6-allrouters
" | tee -a /etc/hosts
```

11) Usuários:

Nesta configuração, é ativado a linha do grupo "wheel" no arquivo sudoers e posteriormente é criado o usuário já adicionado no grupo do sudo e criação automática da pasta HOME do mesmo.  
Opcionalmente, foi adicionado o usuário em mais 3 grupos. Pode adicionar os grupos que achar necessário ou não adicionar, é de preferência de cada um.  
Depois é feito o comando passwd para adicionar uma senha ao usuário.

> Ps.: Usuário criado para o teste: ***arch***  

```bash
sed -i '/NOPASSWD/!s/# %wheel/%wheel/' /etc/sudoers
grep wheel /etc/sudoers
useradd -m -G wheel arch
usermod -a -G storage,power,audio arch
passwd arch
```

12) Pacotes:

Os pacotes foram instalados por categorias:  

Pacotes de manuais, pois são muito úteis para consultas;  
Pacotes para a instalação do gerenciador de boot. Se não for usar Dual Boot, só é necessário o pacote GRUB e o EFI;  
Pacotes para o gerenciamento de rede.  

```bash
pacman -Syy
pacman -S --needed --noconfirm man-db man-pages texinfo
pacman -S --needed --noconfirm grub-efi-x86_64 efibootmgr dosfstools os-prober mtools
pacman -S --needed --noconfirm networkmanager network-manager-applet wpa_supplicant wireless_tools dialog sudo
systemctl enable NetworkManager
```


13) Instalação do GRUB EFI:

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux --recheck
grub-mkconfig -o /boot/grub/grub.cfg
```

14) Sair e rebootar

```bash
exit
reboot
```

15) Após o boot:

Opcional, se estiver configurando o sistema via conexão remota:

```bash
sudo systemctl start sshd
sudo systemctl enable sshd
```

A partir daqui, basta configurar a Distro conforme as suas necessidades.  

Leitura recomendada:  

[Recomendações Gerais](https://wiki.archlinux.org/title/General_recommendations_(Portugu%C3%AAs))  
[Lista de aplicações](https://wiki.archlinux.org/title/List_of_applications_(Portugu%C3%AAs))

Antes de continuar a instalação e configuração do sistema, se assim como eu, usa aplicações como VPN ou jogos que exigem bibliotecas 32 bits, é recomendável habilitar o repositório [multilib](https://wiki.archlinux.org/title/Official_repositories#multilib). Se pra você, não for necessário, não precisa.
Para configurar multilib, edite o arquivo `/etc/pacman.conf` e descomente as seguintes linhas:  

> [multilib]  
Include = /etc/pacman.d/mirrorlist

Aproveitando que já está editando o arquivo, descomente a seguinte linha para ativar instâncias de Download e configure o número de instâncias que quiser (Padrão 5):  

> ParallelDownloads = 10

Para a instalação do driver de vídeo, Intel, NVidia ou AMD, siga este link: [ArchWiki, Xorg, Driver Installation](https://wiki.archlinux.org/title/Xorg#Driver_installation)  

16) Artigos e link's fonte, usados para compreender e instalar o ArchLinux:  

ArchLinux em BTRFS:  

[https://wiki.archlinux.org/title/Btrfs_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/Btrfs_(Portugu%C3%AAs))  
[https://plus.diolinux.com.br/t/tuto-instalacao-do-arch-uefi-com-btrfs-e-snapshots-15-09-2021/38384](https://plus.diolinux.com.br/t/tuto-instalacao-do-arch-uefi-com-btrfs-e-snapshots-15-09-2021/38384)  
[https://danielsales.com.br/pt-br/instalacao-arch-linux-com-btrfs/](https://danielsales.com.br/pt-br/instalacao-arch-linux-com-btrfs/)  
[https://thelostwanderer.tedomum.org/linux/3_install_guide_arch/](https://thelostwanderer.tedomum.org/linux/3_install_guide_arch/)  
[https://www.nishantnadkarni.tech/posts/arch_installation/](https://www.nishantnadkarni.tech/posts/arch_installation/)  
[https://www.arcolinuxd.com/installing-arch-linux-with-a-btrfs-filesystem/](https://www.arcolinuxd.com/installing-arch-linux-with-a-btrfs-filesystem/)  

Outros tópicos:  

[...btrfs root partition mounted on /,/var/cache & log](https://forum.manjaro.org/t/why-is-my-btrfs-root-partition-mounted-on-var-cache-log/83076)  
[https://diolinux.com.br/2019/07/como-instalar-arch-linux-tutorial-iniciantes.html](https://diolinux.com.br/2019/07/como-instalar-arch-linux-tutorial-iniciantes.html)  
[https://livrelinux.wordpress.com/2016/05/11/instalando-arch-linux-descomplicado/](https://livrelinux.wordpress.com/2016/05/11/instalando-arch-linux-descomplicado/)  
[https://wiki.archlinux.org/index.php/Installation_guide_(Portugu%C3%AAs)](https://wiki.archlinux.org/index.php/Installation_guide_(Portugu%C3%AAs))  
[https://forum.archlinux-br.org/viewtopic.php?id=3624](https://forum.archlinux-br.org/viewtopic.php?id=3624)  
[https://wiki.archlinux.org/title/GRUB#UEFI_systems_2](https://wiki.archlinux.org/title/GRUB#UEFI_systems_2)  
[https://wiki.archlinux.org/title/EFI_system_partition#Mount_the_partition](https://wiki.archlinux.org/title/EFI_system_partition#Mount_the_partition)  

Link's recomendáveis:  

[https://btrfs.readthedocs.io/en/latest/index.html](https://btrfs.readthedocs.io/en/latest/index.html)  
[https://wiki.manjaro.org/index.php/Btrfs](https://wiki.manjaro.org/index.php/Btrfs)  

Vídeos ensinando a fazer instalação usando Archinstall, [canal Caravana Cloud](https://www.youtube.com/c/CaravanaCloud):  

[Nova Instalação do Arch Linux 2021 - Archinstall](https://www.youtube.com/watch?v=eRruveslMBY)  
[Arch Linux Instalação 2022 - DEFINITIVA](https://www.youtube.com/watch?v=8jnjjYmuq3s)  

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  

