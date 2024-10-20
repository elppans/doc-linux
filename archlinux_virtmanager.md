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
---
## Configuração de Bridge (br0) no Virt Manager

### Configuração com Portas Fixas (br0 até br9)

Se você deseja definir **portas específicas** de bridge para uso no Virt Manager (por exemplo, de `br0` a `br9`), use o seguinte comando:

```bash
for i in {0..9}; do echo "allow br$i" | sudo tee -a /etc/qemu/bridge.conf ; done
```

Esse comando adiciona permissões para as interfaces `br0` a `br9` no arquivo `/etc/qemu/bridge.conf`, permitindo que o Virt Manager ou QEMU utilize essas interfaces como bridges para máquinas virtuais.

### Configuração para Liberar Todas as Bridges

Se você prefere liberar o uso de **qualquer bridge** para o Virt Manager/QEMU (sem restringir a interfaces específicas), utilize:

```bash
echo "allow all" | sudo tee -a /etc/qemu/bridge.conf
```

Isso permite que todas as bridges configuradas no sistema sejam usadas pelas VMs, sem a necessidade de especificar individualmente cada interface.

---

### Habilitar Encaminhamento de Pacotes IPv4

Para garantir que o tráfego da rede seja roteado corretamente pela interface bridge (`br0`), você deve habilitar o encaminhamento de pacotes IPv4 no kernel. Isso é especialmente importante ao usar NAT (Network Address Translation).

1. Adicione a configuração persistente no arquivo de configurações do sistema:

```bash
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
```

2. Aplique a configuração imediatamente sem precisar reiniciar o sistema:

```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

Esses comandos garantem que o encaminhamento de pacotes esteja ativo, permitindo que as VMs conectadas à bridge acessem outras redes (como a internet) através da interface host.

---

### Configuração do Firewall Backend

Para garantir que o `libvirt` utilize o `iptables` como backend de firewall, é necessário ajustar o arquivo de configuração `network.conf`. Execute os seguintes comandos:

```bash
# Remove qualquer configuração existente do firewall_backend
sed -i '/^firewall_backend/d' /etc/libvirt/network.conf

# Define o firewall_backend como iptables
echo 'firewall_backend = "iptables"' | sudo tee -a /etc/libvirt/network.conf > /dev/null

# Reinicia o serviço libvirtd para aplicar as mudanças
sudo systemctl restart libvirtd.service
```

Essa configuração assegura que o `libvirt` gerencie as regras de firewall utilizando o `iptables`, o que é essencial para garantir a segurança e o correto funcionamento das redes das máquinas virtuais.

---

>A criação da porta Bridge (br0) será adicionado futuramente. **Está em edição**

