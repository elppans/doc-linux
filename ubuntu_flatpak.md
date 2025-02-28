# Ubuntu, o que é Flatpak e como instalar

### O que é Flatpak?
Flatpak é uma tecnologia de empacotamento de software para Linux que permite a instalação de aplicativos de maneira fácil e consistente em diferentes distribuições. Ele cria um ambiente isolado (sandbox) para os aplicativos, o que aumenta a segurança e a estabilidade do sistema. Com o Flatpak, os desenvolvedores podem empacotar seus programas com todas as dependências necessárias, garantindo que eles funcionem de maneira consistente em qualquer distribuição Linux.

### Como instalar Flatpak no Ubuntu
Aqui está um guia passo a passo para instalar o Flatpak no Ubuntu:

1. **Atualize seu sistema**:
   Abra o terminal e execute o comando:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instale o Flatpak**:
   No terminal, digite o seguinte comando:
   ```bash
   sudo apt install flatpak -y
   ```

3. **Adicione o repositório Flathub**:
   Flathub é a principal fonte de aplicativos para Flatpak. Para adicionar o repositório, execute:
   ```bash
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

4. **Reinicie seu sistema**:
   Para garantir que todas as alterações sejam aplicadas corretamente, reinicie seu sistema:
   ```bash
   sudo reboot
   ```

5. **Instale aplicativos com Flatpak**:
   Agora você está pronto para instalar aplicativos via Flatpak. Por exemplo, para instalar o GIMP, use:
   ```bash
   sudo flatpak install flathub org.gimp.GIMP
   ```

Você pode encontrar mais informações sobre o Flatpak e como utilizá-lo [aqui](https://maisgeek.com/o-que-e-um-flatpak-no-linux-e-como-instala-lo/).
___
# GNOME Software Flatpak Plugin

### O que é o GNOME Software Flatpak Plugin?
O GNOME Software Flatpak Plugin é um complemento para o GNOME Software que permite instalar e gerenciar aplicativos Flatpak diretamente pela interface gráfica, sem a necessidade de usar o terminal. Isso facilita a instalação de aplicativos Flatpak para usuários que preferem uma abordagem mais visual e intuitiva.

### Como instalar o GNOME Software Flatpak Plugin no Ubuntu
Aqui está um guia passo a passo para instalar o GNOME Software Flatpak Plugin no Ubuntu:

1. **Atualize seu sistema**:
   Abra o terminal e execute o comando:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Instale o GNOME Software**:
   No terminal, digite o seguinte comando:
   ```bash
   sudo apt install gnome-software -y
   ```

3. **Instale o GNOME Software Flatpak Plugin**:
   No terminal, execute o comando:
   ```bash
   sudo apt install gnome-software-plugin-flatpak -y
   ```

4. **Adicione o repositório Flathub**:
   Flathub é a principal fonte de aplicativos para Flatpak. Para adicionar o repositório, execute:
   ```bash
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```

5. **Reinicie seu sistema**:
   Para garantir que todas as alterações sejam aplicadas corretamente, reinicie seu sistema:
   ```bash
   sudo reboot
   ```

Agora você pode usar o GNOME Software para instalar e gerenciar aplicativos Flatpak de maneira fácil e intuitiva.
___

### Links recomendados

- [Flatpak, Ubuntu Quick Setup](https://flatpak.org/setup/Ubuntu)  
- [Pacotes Flatpak: como instalar no Ubuntu Linux, SempreUpdate](https://sempreupdate.com.br/linux/tutoriais/pacotes-flatpak-como-instalar-no-ubuntu-linux/)  
- [Youtube. INSTALE APPS FACIL NO UBUNTU COM FLATPAK, Canal Tecnollar Tecnologia](https://www.youtube.com/watch?v=dn4L39KUAqc)  
- [Como ativar o suporte a FLATPAK no UBUNTU](https://www.youtube.com/watch?v=1wHwciUikHs)
___

