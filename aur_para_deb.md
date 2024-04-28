# Converter pacotes Archlinux para pacotes Debian

Os repositórios do **Arch Linux** são bastante extensos e geralmente contêm software atualizado. E se algo não estiver disponível nos repositórios, provavelmente estará no **AUR** (ArchLinux User Repository).  
É possível converter/adaptar pacotes do Arch Linux, dos repositórios AUR, em pacotes **DEB** para facilitar a instalação no **Debian**, **Ubuntu** e outras distribuições baseadas neles, como o **Pop!_OS** e o **Linux Mint**.  

Aqui estão duas opções para converter pacotes do Arch Linux para pacotes DEB:

1. [**makedeb**](https://www.makedeb.org/):
   - **makedeb** cria pacotes Debian que podem ser instalados usando o **APT** a partir dos arquivos **PKBUILD** do Arch Linux.
   - O desenvolvedor criou um [**Repositório de Usuários do Debian**](https://mpr.makedeb.org/) semelhante ao AUR do Arch Linux, onde você pode encontrar mais pacotes¹[1](https://www.linuxuprising.com/2021/05/new-project-to-convert-arch-linux.html).

2. [**Archalien**](https://aur.archlinux.org/packages/archalien-git):
   - O **Archalien** é uma ferramenta que permite converter pacotes **DEB** em pacotes **Arch Linux**. Você pode usá-lo para transformar pacotes **.deb** em pacotes **.pkg.tar.gz** do Arch Linux²[2](https://blog.desdelinux.net/pt/deb-em-um-pacote-do-arch-linux/).

Para instalar o **makedeb**, no Debian, Ubuntu ou qualquer distribuição baseada neles, siga estas etapas:

1. Adicione o repositório e atualize as fontes de software:
>Como o sistema irá trabalhar com compilação, é bom instalar alguns pacotes essenciais pra isso também:
>>build-essential linux-headers-$(uname -r) git fakeroot

   ```bash
   wget -qO - 'https://proget.makedeb.org/debian-feeds/makedeb.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/makedeb-archive-keyring.gpg 1> /dev/null
echo 'deb [signed-by=/usr/share/keyrings/makedeb-archive-keyring.gpg arch=all] https://proget.makedeb.org/ makedeb main' | sudo tee /etc/apt/sources.list.d/makedeb.list
sudo apt update
   ```

2. Instale os pacotes necessários:

```bash
sudo apt install build-essential linux-headers-$(uname -r) git fakeroot makedeb
```
Para mais informações, leia a página de [documentos do makedeb](https://docs.makedeb.org/).  
- Fontes:  
(1) [New Project To Convert Arch Linux PKGBUILDs (Repositories and AUR) To ....](https://www.linuxuprising.com/2021/05/new-project-to-convert-arch-linux.html).  
(2) [Converter um pacote Debian .deb em um pacote Arch Linux.](https://blog.desdelinux.net/pt/deb-em-um-pacote-do-arch-linux/).  
(3) [Novo projeto para converter PKGBUILDs do Arch Linux ... - Linux Avante.](https://linuxavante.com/novo-projeto-para-converter-pkgbuilds-repositorios-aur-para-pacotes-deb).  
(4) [Converter pacotes DEB em pacotes para Arch Linux | Linux Adictos.](https://www.linuxadictos.com/pt/converter-pacotes-deb-arch-pacotes-linux.html).  
(5) [Instalar pacotes .deb no Arch Linux (Manjaro, Reborn OS...).](https://dev.to/tuliocalil/instalar-pacotes-deb-no-arch-linux-ou-manjaro-5a8l).  
(6) [hunterwittenborn, apt.asc.](https://hunterwittenborn.com/keys/apt.asc).  
(7) [hunterwittenborn, makedeb.](https://repo.hunterwittenborn.com/debian/makedeb).  
(8) [github.com, makedeb README.](https://github.com/hwittenborn/makedeb-db/tree/06b498a2dc1948c9f2c8a78cfcf66b418a5c287f/README.md).  
