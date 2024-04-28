# Instalação do `makedeb` via código-fonte

O `makedeb` é uma ferramenta essencial no Arch Linux para criar pacotes a partir de arquivos PKGBUILD. Vamos passo a passo:

1. **Instale as dependências básicas do sistema**:
   Certifique-se de ter os seguintes pacotes instalados:

   ```bash
   sudo apt install build-essential linux-headers-$(uname -r) git
   ```

2. **Instale as dependências necessárias para o `makedeb`**:
   Execute o seguinte comando para instalar as dependências:

   ```bash
   sudo apt install apt binutils curl fakeroot file gettext gawk libarchive-tools lsb-release zstd
   ```

3. **Instale as ferramentas de compilação**:
   As seguintes ferramentas são necessárias para compilar o `makedeb`:

   ```bash
   sudo apt install asciidoctor cargo git make jq
   ```

4. **Instale o `just` via Cargo**:
   O `just` é uma ferramenta útil para automatizar tarefas. Instale-o com o seguinte comando:

   ```bash
   cargo install just
   ```

5. **Configure a variável de ambiente**:
   Adicione o diretório `~/.cargo/bin` ao seu `PATH`:

   ```bash
   echo 'export PATH="$PATH:$HOME/.cargo/bin"' >> "$HOME/.bashrc"
   source "$HOME/.bashrc"  # Atualize o ambiente
   ```

6. **Baixe o código-fonte do `makedeb`**:
   Vamos clonar o repositório do `makedeb`:

   ```bash
   cd ~/Downloads/
   git clone 'https://github.com/makedeb/makedeb'
   cd makedeb
   ```

7. **Compile o pacote**:
   Execute os seguintes comandos para compilar o `makedeb`:

   ```bash
   VERSION="16.1.0" RELEASE=alpha TARGET=apt BUILD_COMMIT="$(git rev-parse HEAD)" just prepare
   DPKG_ARCHITECTURE="$(dpkg --print-architecture)" just build
   ```

8. **Instale o `makedeb`**:
   Agora, instale o `makedeb` no sistema:

   ```bash
   sudo DESTDIR='/' ~/.cargo/bin/just package
   ```

9. **Opcional: Crie um pacote .deb para testar**:
   Se desejar, você pode criar um pacote .deb para uso futuro:

   ```bash
   cd PKGBUILD
   TARGET=apt RELEASE=alpha ./pkgbuild.sh > PKGBUILD
   makedeb -s
   ```

Agora você deve ter o `makedeb` instalado e pronto para uso! Lembre-se de verificar se o diretório `~/cargo/bin` está configurado corretamente no seu `PATH`¹[1](https://www.youtube.com/watch?v=dg0O8eoDlTI).  

Fontes:  
(1) Instalar desde AUR solo con makepkg. https://www.youtube.com/watch?v=dg0O8eoDlTI.  
(2) Como baixar e instalar o PACOTE OFFICE de Graça - Vídeo Aula Completa 2023. https://www.youtube.com/watch?v=kVyJ2BVUUSY.  
(3) Como instalar gratuitamente o pacote Office 365 - Word, PowerPoint, Excel, Outlook e muito mais. https://www.youtube.com/watch?v=d1ZDjEqJNcg.  
(4) Makepkg (Português) - ArchWiki. https://wiki.archlinux.org/title/Makepkg_%28Portugu%C3%AAs%29.  
(5) makepkg(8) — Arch manual pages. https://man.archlinux.org/man/makepkg.8.pt_BR.  
(6) makepkg - ArchWiki. https://wiki.archlinux.org/title/Makepkg.  
(7) undefined. https://bing.com/search?q=.  
(8) How to Use the Command `makepkg` (with examples). https://commandmasters.com/commands/makepkg-linux/.  
(9) Creating a PKGBUILD to Make Packages for Arch Linux - It's FOSS. https://itsfoss.com/create-pkgbuild/.  
(10) makepkg Command Examples in Linux – The Geek Diary. https://www.thegeekdiary.com/makepkg-command-examples-in-linux/.  
