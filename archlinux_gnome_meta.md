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

---

# Sugestão de Aplicativos para o Gnome

Aqui estão alguns aplicativos opcionais e úteis que você pode instalar e usar no ambiente Gnome:  

1. [**gnome-firmware**](https://archlinux.org/packages/?sort=&q=gnome-firmware&maintainer=&flagged=):  
   - Gerencia firmware em dispositivos suportados pelo `fwupd`.  
   - Útil para manter seus dispositivos atualizados.  

2. [**gnome-shell-extension-caffeine**](https://archlinux.org/packages/?sort=&q=gnome-shell-extension-caffeine&maintainer=&flagged=):  
   - Uma extensão para o Gnome Shell que desativa o protetor de tela e a suspensão automática.  
   - Ideal para evitar que a tela desligue automaticamente durante tarefas específicas.  

3. [**power-profiles-daemon**](https://archlinux.org/packages/?sort=&q=power-profiles-daemon&maintainer=&flagged=) (ótimo para quem usa notebooks):  
   - Disponibiliza o manuseio de perfis de potência no D-Bus.  
   - Permite ajustar as configurações de economia de energia com mais flexibilidade.  

4. [**gufw**](https://archlinux.org/packages/?sort=&q=gufw&maintainer=&flagged=):  
   - Uma maneira descomplicada de gerenciar o firewall no Linux.  
   - Permite configurar regras de firewall de forma intuitiva.  

5. [**deja-dup**](https://archlinux.org/packages/?sort=&q=deja-dup&maintainer=&flagged=):  
   - Uma ferramenta de backup simples com interface gráfica GTK.  
   - Facilita a criação e restauração de backups.  

6. [**timeshift**](https://archlinux.org/packages/?sort=&q=timeshift&maintainer=&flagged=):  
   - Um utilitário de restauração do sistema para Linux.  
   - Permite criar pontos de restauração e voltar a um estado anterior do sistema.  

7. [**gdm-settings** (disponível no AUR)](https://aur.archlinux.org/packages?O=0&K=gdm-settings):  
   - Um aplicativo de configurações para o Gerenciador de Login do Gnome (GDM).  
   - Personalize as opções de login e aparência do GDM.  

8. [**dynamic-wallpaper** (disponível no AUR)](https://aur.archlinux.org/packages?O=0&SeB=nd&K=dynamic-wallpaper&outdated=&SB=p&SO=d&PP=50&submit=Go):  
   - Crie papéis de parede dinâmicos para o Gnome 42+.  
   - Altere automaticamente o papel de parede com base no horário do dia ou outras condições.  

9. [**collision** (disponível no AUR (padrão no Manjaro))](https://aur.archlinux.org/packages/collision):  
   - Verifique os hashes de seus arquivos.  
   - Uma ferramenta GUI simples para gerar, comparar e verificar hashes MD5, SHA1 e SHA256.  

10. [**gtkhash-git** (disponível no AUR)](https://aur.archlinux.org/packages?O=0&SeB=nd&K=gtkhash&outdated=&SB=p&SO=d&PP=50&submit=Go):  
    - Um utilitário de desktop multiplataforma para computar resumos de mensagens ou somas de verificação.  
    - Útil para verificar a integridade de arquivos.  

Lembre-se de consultar a documentação de cada aplicativo para obter mais detalhes sobre como usá-los.   

---
- Fontes:  
[https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs)](https://wiki.archlinux.org/title/GNOME_(Portugu%C3%AAs))  
[https://extensions.gnome.org/](https://extensions.gnome.org/)  
[https://apps.gnome.org/pt/Software/](https://apps.gnome.org/pt/Software/)  
[https://apps.gnome.org/pt-BR/](https://apps.gnome.org/pt-BR/)  
[https://apps.gnome.org/pt/](https://apps.gnome.org/pt/)  
[https://apps.gnome.org/pt-BR/Software/](https://apps.gnome.org/pt-BR/Software/)  
___
