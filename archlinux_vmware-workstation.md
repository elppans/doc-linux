# VMware Workstation PRO 17 no ArchLinux

Instalar o [VMWare Workstation](https://aur.archlinux.org/packages/vmware-workstation) no ArchLinux é ligeiramente fácil.  
Aliás, eu NÃO removi o [Virt-Manager](https://elppans.github.io/doc-linux/archlinux_virt-manager_cockpit), simplesmente instalei o VMWare, trabalho conforme as necessidades.  

Aqui mostrarei como instalar da forma tradicional, sem o [yay](https://aur.archlinux.org/packages?O=0&K=yay).  
Para instalar, primeiramente DEVE instalar o pacote [vmware-keymaps](https://aur.archlinux.org/packages/vmware-keymaps).  
Se der erro de que não conseguiu baixar alguma dependência, não tem problema, basta instalar e tentar compilar novamente. Eu tive que instalar primeiro o pacote [libxcrypt-compat](https://archlinux.org/packages/?sort=&q=libxcrypt-compat), que não tinha na minha Distro.  

Na compilação irei utilizar as seguintes opções:  

>-C, --cleanbuild Remove o diretório $srcdir/ antes de compilar o pacote  
-r, --rmdeps     Remove dependências instaladas após uma compilação  
-i, --install    Instala pacote após empacotamento bem-sucedido  
-s, --syncdeps   Instala dependências em falta com pacman  
-L, --log        Gera log do processo de empacotamento

* Instalando:

#### Keymaps required by some VMware packages

```
mkdir ~/build
cd ~/build
git clone https://aur.archlinux.org/vmware-keymaps.git
cd vmware-keymaps
makepkg -Cris -L
```

#### VMware Workstation

```
cd ~/build
git clone https://aur.archlinux.org/vmware-workstation.git
cd vmware-workstation
sudo pacman -S libxcrypt-compat
makepkg -Cris -L
sudo modprobe -a vmw_vmci vmmon
sudo systemctl enable --now vmware-networks.service
systemctl status vmware-networks.service
sudo systemctl enable --now vmware-usbarbitrator.service
systemctl status vmware-usbarbitrator.service
```

* *BONUS:*

[Free VMware Workstation Pro 17 full license keys](https://gist.github.com/PurpleVibe32/30a802c3c8ec902e1487024cdea26251)  
[5000k+ vmware workstation pro 17 (untested)](https://gist.github.com/PurpleVibe32/1e9b30754ff18d69ad48155ed29d83de)  

* Grupo Telegram recomendável: [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
