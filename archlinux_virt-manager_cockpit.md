# ArchLinux, Virt-Manager + Cockpit  

Após a instalação do Arch Linux, fiz um teste no Gnome-Boxes, mas achei simples demais, então decidi voltar ao Virt-Manager, que é MUITO mais completo.  

## Instalação do Virt-Manager  

* Verificando  

Antes de tudo, verifique se os 'parâmetros de virtualização' estão habilitados no BIOS usando:  

```bash
LC_ALL=C lscpu | grep Virtualization
```

Se não aparecer nada, deve ir na sua BIOS e habilitar a virtualização, para depois voltar aqui na matéria.  

* Instalando virt-manager, qemu e suas dependências:

Uma observação, antes de iniciar: Houve 2 pacotes que foram retirados do comando, por conta de conflito com pacotes já existentes:  

>***iptables-nft*** = Retirado do comando por causa do conflito com ***iptables***  
***openbsd-netcat*** = Retirado do comando por causa do conflito com ***gnu-netcat***   (NÃO é necessário ter este pacote instalado) 

Instale o Virt-Manager e configure os serviços e grupos:  

```bash
sudo pacman -S --needed --noconfirm virt-manager qemu vde2 dnsmasq bridge-utils edk2-ovmf swtpm dmidecode
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo systemctl status libvirtd.service
sudo usermod -a -G libvirt $USER
sudo usermod -a -G libvirt-qemu $USER
grep libvirt /etc/group
```

* Rede NAT  

Inicie e configure a rede NAT para iniciar de forma automatica:  

```bash
sudo virsh net-start default
sudo virsh net-autostart default
```

Para saber se a configuração deu certo, basta fazer o seguinte comando:  

```bash
sudo virsh net-list
```
* Rede Bridge:

Para quem quer usar a rede Bridge no Virt-Manager e QEMU/KVM, a maneira mais fácil que achei para configurar é usando o aplicativo Web Cockpit. Tentei configurar de outras formas seguindo o Wiki mas não deu certo.

1) Configurando acesso a Rede Bridge para Sessão Usuário:

Para quem usa o Virt-Manager em uma conexão QEMU/KVM Sessão do usuário, deve fazer uma pequena configuração antes de usar este método de rede. Se não fizer, a máquina virtual reclama de falta do arquivo e não funciona.

```
sudo mkdir -p /etc/qemu
echo "allow all" | sudo tee /etc/qemu/libvirt-qemu.conf
echo "include /etc/qemu/libvirt-qemu.conf" | sudo tee --append /etc/qemu/bridge.conf
sudo chown libvirt-qemu:libvirt-qemu /etc/qemu/libvirt-qemu.conf
sudo chmod 640 /etc/qemu/libvirt-qemu.conf
```

2) Configurar rede Bridge pelo Painel Web Cockpit:

Como vamos usar o Cockpit apenas para configurar a rede, não é necessário instalar ele mais o monte de plugins.  
Então apenas faça:  

```bash
sudo pacman -S cockpit
sudo systemctl enable --now cockpit.socket
sudo systemctl status cockpit.socket
```

Para acessar seu Painel Web, vá em seu navegador e acesse [127.0.0.1:9090](127.0.0.1:9090)  
Se seu login não funcionar neste endereço, utilize o endereço [https://127.0.0.1:9090](https://127.0.0.1:9090)  
Se aparecer um popup pedindo direitos administrativos, clique lá e logue também.  
Já no Painel Web, seção Rede, estará a sua rede e também o do Virt-Manager. Minha rede usa a porta enp2s0.  
Para configurar, deve clicar em “Adicionar Ponte”.
Irá aparecer uma nova janela, já indicando um nome para a rede chamada bridge0. Selecione a sua rede e ***OPCIONALMENTE*** também a opção Spanning tree protocol (STP). Então clique em Salvar e pronto, sua rede Bridge já foi criada.

A rede Bridge é configurado usando uma conexão DHCP, se quiser configurar um IP FIXO, faça o seguinte:  

Primeiro, clique no nome da interface, bridge0, na próxima página, vá até **IPv4 Automático (DHCP)** e clique em **Edit** . Em **Endereços** estará selecionado a opção **Automático (DHCP)**, clique nesta opção e escolha **Manual**, Então é só configurar o IP, máscara e Gateway. Se você usa a opção 255.255.255.0, pode deixar o número 24 no lugar.  
Opcionalmente, pode configurar o DNS também, basta clicar no botão + na opção DNS.

* Usar Script `virt-qemu-sh` ***(OPCIONAL)***  

Criei um Script pessoal para criar o HD Virtual para atachar no Virt-Manager. Com ele o HD Virtual é criado já comprimido, e só vai crescendo conforme o uso.
O Virt-Manager, por padrão, cria uma VM com um arquivo GRANDE, que ocupa o espaço de HD conforma foi configurado a máquina virtual. Ou seja, se é criado uma VM com HD de 50 GB, é exatamente isso que será ocupado na pasta. Com o Script, será criado um arquivo de mais ou menos 120 KB.  

Se quiser usar, faça o seguinte:  

Configurar no ambiente:  

```bash
export PATH=$HOME/.local/bin:$PATH
```

Baixar o seguinte arquivo para esta pasta:  

```bash
mkdir -p ~/.local/bin
cd ~/.local/bin
curl -O https://raw.githubusercontent.com/elppans/customshell/master/virt-qemu-sh
chmod +x virt-qemu-sh
```

Faça o comando com a opção --help para ver como usar e também para que seja criado automaticamente um arquivo de configuração de diretório.  
Este comando está configuado para usar a pasta a nível usuário do VirtManager, se quiser usar uma pasta diferente, edite o arquivo:

> ~/.config/virt-qemu-sh/virt-qemu-sh.cfg

E modifique a variável "DIR" para outro diretório

* Grupo Telegram recomendável:  

[Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  


* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)
