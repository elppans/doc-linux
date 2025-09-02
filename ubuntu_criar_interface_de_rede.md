# Ubuntu, criar interface de rede

## Gerenciar Bridge com brctl

O comando `brctl` (bridge control) é utilizado no Linux para **gerenciar pontes de rede Ethernet**, permitindo criar, configurar e inspecionar bridges que conectam múltiplas interfaces de rede como se fossem uma só.

### 📦 Pacote no Ubuntu
Para utilizar o `brctl`, você precisa instalar o pacote:

```bash
sudo apt update
sudo apt install bridge-utils
```

Esse pacote fornece as ferramentas necessárias para manipular bridges via linha de comando.

### ⚠️ Observação importante
O `brctl` é considerado **obsoleto** em muitas distribuições modernas. A recomendação atual é utilizar o comando `bridge` do pacote `iproute2`, que oferece suporte mais completo e atualizado para gerenciamento de bridges.

### 🔧 Exemplos de uso com `brctl`
```bash
brctl show                # Lista as bridges existentes
brctl addbr br0           # Cria uma nova bridge chamada br0
brctl addif br0 eth0      # Adiciona a interface eth0 à bridge br0
brctl delif br0 eth0      # Remove a interface eth0 da bridge br0
brctl delbr br0           # Remove a bridge br0 (interface deve estar down)
```
___

## Gerenciar Bridge com comando ip da suíte iproute2

Como usar o **comando `ip` da suíte iproute2** para criar e gerenciar uma bridge de rede no Linux — substituindo o antigo `brctl`.

---

### 🛠️ Criando uma bridge com `iproute2`

```bash
# 1. Criar a bridge chamada br0
sudo ip link add name br0 type bridge

# 2. Ativar a bridge
sudo ip link set dev br0 up

# 3. Adicionar interfaces à bridge (ex: eth0 e eth1)
sudo ip link set dev eth0 master br0
sudo ip link set dev eth1 master br0
```

---

### 🔄 Remover interfaces da bridge

```bash
sudo ip link set dev eth0 nomaster
```

---

### 🧹 Excluir a bridge (após remover interfaces)

```bash
sudo ip link del br0
```

---

### 🔍 Inspecionar a bridge

```bash
# Ver interfaces conectadas
bridge link show

# Ver tabela de encaminhamento (FDB)
bridge fdb show dev br0

# Ver regras de VLAN associadas
bridge vlan show
```

---

### ⚙️ Configurações avançadas

Você pode ajustar atributos como custo de STP, modo hairpin, root guard, etc.:

```bash
bridge link set dev eth1 cost 4
bridge link set dev eth1 root_block on
bridge link set dev eth0 guard on
```
___

## Comandos para criar e gerenciar uma `porta` de rede,

No Linux, você não "cria" uma interface de rede como `eth1` do zero a menos que esteja trabalhando com interfaces virtuais, como em ambientes de virtualização, containers ou tunelamento. Mas se você quer **simular ou configurar uma nova porta de rede**, aqui vão os caminhos possíveis:

---

### 🧱 1. Criar uma interface virtual (dummy)

Se você só precisa de uma interface de rede fictícia para testes ou roteamento:

```bash
# Carregar o módulo dummy
sudo modprobe dummy

# Criar a interface dummy chamada eth1
sudo ip link add eth1 type dummy

# Ativar a interface
sudo ip link set eth1 up

# Atribuir um IP
sudo ip addr add 192.168.100.1/24 dev eth1
```

---

### 🧪 2. Criar uma interface TAP/TUN (para VPNs ou tunelamento)

```bash
# Criar uma interface TAP chamada eth1
sudo ip tuntap add dev eth1 mode tap

# Ativar a interface
sudo ip link set eth1 up
```

---

### 🧩 3. Em ambientes com múltiplas placas físicas

Se você tem mais de uma placa de rede instalada, o sistema geralmente nomeia automaticamente como `eth0`, `eth1`, etc. Você pode configurar essas interfaces manualmente:

```bash
# Verificar interfaces disponíveis
ip link show

# Ativar uma interface física
sudo ip link set eth1 up

# Atribuir IP
sudo ip addr add 192.168.1.10/24 dev eth1
```

---

### 📝 4. Configuração persistente (Debian/Ubuntu)

Edite o arquivo `/etc/network/interfaces`:

```bash
auto eth1
iface eth1 inet static
    address 192.168.1.10
    netmask 255.255.255.0
    gateway 192.168.1.1
```

Depois reinicie a rede:

```bash
sudo systemctl restart networking
```

---

Se você estiver usando CentOS, Fedora ou RHEL, o caminho é diferente (via `nmcli` ou arquivos `ifcfg-eth1`).



