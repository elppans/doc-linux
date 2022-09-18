# Escolhendo e instalando uma Suite Office no ArchLinux

Existem muitas marcas de uma suite office para instalar, como por exemplo, o [CrosOver](https://wiki.archlinux.org/title/CrossOver) e o [WPS Office](https://wiki.archlinux.org/title/WPS_Office). Mas eu testei apenas 2 até o momento, e são estes:

[libreoffice](https://wiki.archlinux.org/title/LibreOffice) - São 2 versões para escolher e instalar:  

> still - Versão estável, para usuários conservadores.  
fresh - Versão corrente, com pacotes mais atuais, novos aprimoramentos do programa para os primeiros usuários ou usuários avançados.  

Se quiser instalar, escolha a versão e faça, como no exemplo:

```bash
sudo pacman -S libreoffice-fresh-pt-br
```

[onlyoffice](https://www.onlyoffice.com/blog/pt-br/) - Uma boa alternativa de uma suite office. Mais fácil de usar, principalmente para os novatos no Linux.  
Este pacote fica no repositório AUR, então se quiser instalar, faça:  

```bash
cd ~/Downloads
git clone https://aur.archlinux.org/onlyoffice-bin.git
cd onlyoffice-bin
makepkg -sirL --needed --noconfirm
```

Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
