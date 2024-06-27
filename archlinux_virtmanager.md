# ArchLinux, Virt-Manager  

## Instalação do Virt-Manager  

- Verificando  

Antes de tudo, verifique se os ‘parâmetros de virtualização’ estão habilitados no BIOS usando:  

```
LC_ALL=C lscpu | grep Virtualization
```

Se não aparecer nada, deve ir na sua BIOS e habilitar a virtualização, para depois voltar aqui na matéria.  

- Instalação do Virt-Manager  

>qemu-desktop já é bom. Para instalar COMPLETO (1 GB) trocar o pacote para `qemu-full` na instalação.  


```
sudo pacman -S virt-manager qemu-desktop swtpm dmidecode dnsmasq bridge-utils
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
grep libvirt /etc/group
sudo systemctl enable --now libvirtd.service
```

- Rede NAT  

Inicie e configure a rede NAT para iniciar de forma automatica:  

```
sudo virsh net-start default
sudo virsh net-autostart default
```

Para saber se a configuração deu certo, basta fazer o seguinte comando:  

```
sudo virsh net-list
```

- Rede Bridge  

>Será adicionado futuramente  
