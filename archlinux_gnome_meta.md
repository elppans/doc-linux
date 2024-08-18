---

# Configuração do Ambiente Gnome (Meta) no Arch Linux

Esta nota descreve os passos para configurar o ambiente Gnome no Arch Linux.  

## 1. Atualização do Sistema

Execute o seguinte comando para atualizar completamente os repositórios e o sistema:

```bash
sudo pacman -Syyu
```

## 2. Instalação do Gnome Shell e Ferramentas

Instale o Gnome Shell e outras ferramentas necessárias:

```bash
sudo pacman --needed -S gdm gnome gnome-tweaks htop iwd nano openssh smartmontools vim wget wireless_tools wpa_supplicant xdg-utils
```

## 3. Ativação do Gerenciador de Login do Gnome

Habilite o gerenciador de login do Gnome para iniciar automaticamente:

```bash
sudo systemctl enable gdm
```

## 4. Criação/Atualização dos Diretórios Padrões de Usuário

Execute o seguinte comando para criar ou atualizar os diretórios padrões de usuário:

```bash
xdg-user-dirs-update
```

## 5. Configurações da Barra Superior

Para mostrar a data e os segundos na barra superior, use os seguintes comandos:

```bash
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
```

## 6. Instalação do Tema Yaru

O tema Yaru é uma ótima escolha para o Gnome. Siga as instruções abaixo:
>Este pacote de tema cria vários pacotes de instalação, então a melhor opção para instalar é via makepkg ou o Helper paru, pois o yay não instala os pacotes, tendo que instalar manualmente via `sudo pacman -U yaru*any.pkg.tar.*`  
- Instale o pacote via AUR (use o helper `paru` ou `yay`):

  ```bash
  paru --needed --noconfirm -S --batchinstall --skipreview --removemake --mflags -Cris inkscape xorg-server-xvfb yaru-gnome-shell-theme
  ```

- Ative a extensão "User Themes" no gnome-tweaks e configure o tema.

## 7. Extensões Úteis

Instale as seguintes extensões para melhorar a experiência no Gnome:

- [**AppIndicator and KStatusNotifierItem Support**](https://extensions.gnome.org/extension/615/appindicator-support/):  
  Adiciona suporte a ícones herdados da bandeja ao Shell.
  Instale via reposiótio "Extra":  
  
  ```bash
  sudo pacman -S gnome-shell-extension-appindicator
  ```

- Outras extensões úteis (instale via navegador):
  - [**Boost Volume**](https://extensions.gnome.org/extension/6928/boost-volume/): Aumenta o volume acima dos limites.
  - [**Gradient Top Bar**](https://extensions.gnome.org/extension/4955/gradient-top-bar/): Torna o gradiente de fundo do painel do GNOME.
  - [**Transparent Top Bar**](https://extensions.gnome.org/extension/1708/transparent-top-bar/): Barra superior transparente ao flutuar livremente no GNOME.
  - [**IP Finder**](https://extensions.gnome.org/extension/2983/ip-finder/): Exibe informações úteis sobre seu endereço IP público e status da VPN.

Lembre-se de consultar a documentação para mais detalhes sobre cada etapa.  

---
- Fontes:  
[https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs))  
[https://extensions.gnome.org/](https://extensions.gnome.org/)
___
