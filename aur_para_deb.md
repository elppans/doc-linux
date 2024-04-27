# Converter pacotes Archlinux para pacotes Debian

[1]: https://www.linuxuprising.com/2021/05/new-project-to-convert-arch-linux.html ""
[2]: https://blog.desdelinux.net/pt/deb-em-um-pacote-do-arch-linux/ ""
[3]: https://linuxavante.com/novo-projeto-para-converter-pkgbuilds-repositorios-aur-para-pacotes-deb ""
[4]: https://www.linuxadictos.com/pt/converter-pacotes-deb-arch-pacotes-linux.html ""
[5]: https://dev.to/tuliocalil/instalar-pacotes-deb-no-arch-linux-ou-manjaro-5a8l ""
[6]: https://hunterwittenborn.com/keys/apt.asc ""
[7]: https://repo.hunterwittenborn.com/debian/makedeb ""

Os repositórios do **Arch Linux** são bastante extensos e geralmente contêm software atualizado. E se algo não estiver disponível nos repositórios, provavelmente estará no **AUR** (ArchLinux User Repository). Você sabia que é possível converter pacotes do Arch Linux, tanto dos repositórios quanto do AUR, em pacotes **DEB** para facilitar a instalação no **Debian**, **Ubuntu** e outras distribuições baseadas neles, como o **Pop!_OS** e o **Linux Mint**? Bem, você pode fazer isso com a ajuda de algumas ferramentas.

Aqui estão duas opções para converter pacotes do Arch Linux para pacotes DEB:

1. **makedeb, mpm e makedeb-db**:
   - **makedeb** cria pacotes Debian que podem ser instalados usando o **APT** a partir dos arquivos **PKBUILD** do Arch Linux.
   - **mpm** é um gerenciador de pacotes para o **makedeb**, permitindo instalar, atualizar e clonar pacotes do AUR e dos repositórios do Arch Linux no Debian e distribuições baseadas no Debian.
   - **makedeb-db** converte os nomes das dependências do Arch Linux para seus equivalentes no Debian.
   - No entanto, este projeto ainda está em seus estágios iniciais, e apenas alguns pacotes do Arch Linux podem ser instalados no Debian ou Ubuntu. Você pode ajudar o desenvolvedor a expandir a lista de pacotes suportados¹[1].
   - Além disso, o desenvolvedor criou um **Repositório de Usuários do Debian** semelhante ao AUR do Arch Linux, onde você pode encontrar mais pacotes¹[1].

2. **Archalien**:
   - O **Archalien** é uma ferramenta que permite converter pacotes **DEB** em pacotes **Arch Linux**. Você pode usá-lo para transformar pacotes **.deb** em pacotes **.pkg.tar.gz** do Arch Linux²[2].

Para instalar o **makedeb**, **mpm** e **makedeb-db** no Debian, Ubuntu ou qualquer distribuição baseada neles, siga estas etapas:

1. Adicione o repositório e atualize as fontes de software:
   ```bash
   sudo wget 'https://hunterwittenborn.com/keys/apt.asc' -O /etc/apt/trusted.gpg.d/hwittenborn.asc
   echo 'deb [arch=all] https://repo.hunterwittenborn.com/debian/makedeb any main' | sudo tee /etc/apt/sources.list.d/makedeb.list
   sudo apt update
   ```

2. Instale a versão estável do **makedeb**, **mpm** e **makedeb-db**:
   ```bash
   sudo apt install mpm makedeb makedeb-db
   ```

>A versão estável suporta apenas o **AUR**. Para suporte aos repositórios do Arch Linux, você precisará instalar a versão alfa do **mpm** e **makedeb** (mpm-alpha e makedeb-alpha)¹[1].  

- Fontes:  
(1) [New Project To Convert Arch Linux PKGBUILDs (Repositories and AUR) To ....](https://www.linuxuprising.com/2021/05/new-project-to-convert-arch-linux.html).  
(2) [Converter um pacote Debian .deb em um pacote Arch Linux.](https://blog.desdelinux.net/pt/deb-em-um-pacote-do-arch-linux/).  
(3) [Novo projeto para converter PKGBUILDs do Arch Linux ... - Linux Avante.](https://linuxavante.com/novo-projeto-para-converter-pkgbuilds-repositorios-aur-para-pacotes-deb).  
(4) [Converter pacotes DEB em pacotes para Arch Linux | Linux Adictos.](https://www.linuxadictos.com/pt/converter-pacotes-deb-arch-pacotes-linux.html).  
(5) [Instalar pacotes .deb no Arch Linux (Manjaro, Reborn OS...).](https://dev.to/tuliocalil/instalar-pacotes-deb-no-arch-linux-ou-manjaro-5a8l).  
(6) [hunterwittenborn, apt.asc.](https://hunterwittenborn.com/keys/apt.asc).  
(7) [hunterwittenborn, makedeb.](https://repo.hunterwittenborn.com/debian/makedeb).  
(8) [github.com, makedeb README.](https://github.com/hwittenborn/makedeb-db/tree/06b498a2dc1948c9f2c8a78cfcf66b418a5c287f/README.md).  
