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
___

## Criei um eth1, como compartilho a internet dele pro celular?

Se você criou a interface `eth1` e quer compartilhar a internet dela com o celular (via cabo ou adaptador USB Ethernet, por exemplo), você pode transformar o Linux em um roteador simples. Aqui vai o passo a passo:

---

### 🔧 Pré-requisitos

- A interface que **tem acesso à internet** (ex: `enp1s0`)
- A interface que será usada para **compartilhar a internet** (ex: `eth1`)
- O celular conectado via cabo à `eth1` (com DHCP ou IP fixo)

---

### 🛠️ Etapas para compartilhar a internet

#### 1. **Ativar o encaminhamento de pacotes**
```bash
sudo sysctl -w net.ipv4.ip_forward=1
```

Para tornar permanente:
```bash
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
```

---

#### 2. **Configurar NAT com iptables**
Supondo que `enp1s0` é sua interface com internet:

```bash
sudo iptables -t nat -A POSTROUTING -o enp1s0 -j MASQUERADE
sudo iptables -A FORWARD -i eth1 -o enp1s0 -j ACCEPT
sudo iptables -A FORWARD -i enp1s0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

---

#### 3. **Configurar IP na interface `eth1`**
Você pode atribuir um IP fixo:

```bash
sudo ip addr add 192.168.100.1/24 dev eth1
sudo ip link set eth1 up
```

---

#### 4. **Configurar DHCP (opcional)**
Se quiser que o celular receba IP automaticamente, instale e configure um servidor DHCP como `dnsmasq`.

Exemplo básico de configuração:

```bash
sudo apt install dnsmasq
```

Adicione ao `/etc/dnsmasq.conf`:

```ini
interface=eth1
dhcp-range=192.168.100.10,192.168.100.50,12h
```

Reinicie o serviço:

```bash
sudo systemctl restart dnsmasq
```

---

### 📱 No celular
- Conecte via cabo à interface `eth1`
- Configure IP manual (se não usar DHCP):  
  IP: `192.168.100.10`  
  Gateway: `192.168.100.1`  
  DNS: `8.8.8.8`

---

___

## Transformar seu Linux com Wi-Fi (wlo1) em um roteador via cabo Ethernet (eth1) para o celular.

---

### ✅ Passo a passo otimizado

#### 1. **Ative o encaminhamento de pacotes**
```bash
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
```

---

#### 2. **Configure IP fixo na `eth1`**
```bash
sudo ip addr flush dev eth1
sudo ip addr add 192.168.88.1/24 dev eth1
sudo ip link set eth1 up
```

---

#### 3. **Configure NAT para compartilhar a internet do Wi-Fi**
```bash
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -i eth1 -o wlo1 -j ACCEPT
sudo iptables -A FORWARD -i wlo1 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

---

#### 4. **Servidor DHCP (opcional, mas recomendado)**
Instale e configure `dnsmasq` para o celular receber IP automaticamente:

```bash
sudo apt install dnsmasq
```

Adicione ao final do `/etc/dnsmasq.conf`:

```ini
interface=eth1
dhcp-range=192.168.88.10,192.168.88.50,12h
```

Reinicie:
```bash
sudo systemctl restart dnsmasq
```

---

### 📱 No celular
- Conecte via cabo à `eth1`
- Se não usar DHCP, configure manualmente:
  - IP: `192.168.88.10`
  - Gateway: `192.168.88.1`
  - DNS: `8.8.8.8`

---

### 🧠 Extras que podem te interessar
- Quer que isso funcione automaticamente no boot? Posso te ajudar a criar um serviço `systemd`.
- Quer monitorar o tráfego entre interfaces? Dá pra usar `iftop`, `nload` ou até `tcpdump`.

___

## Transformar seu Linux com Wi-Fi (wlo1) em um roteador via Wi-Fi (ap0) para o celular.

Essa é uma solução bem interessante: transformar seu Linux em um **hotspot Wi-Fi** usando a conexão já ativa no `wlo1`, sem perder o acesso à internet no próprio computador. O truque é criar uma **rede Wi-Fi separada** (virtual) que compartilha a internet do `wlo1` com o celular. Aqui vai o caminho das pedras:

---

### 🧭 Objetivo
- Usar **`wlo1` como cliente Wi-Fi** (conectado à internet)
- Criar um **hotspot Wi-Fi virtual** para o celular, sem desconectar o `wlo1`

---

### 🛠️ Solução: Usar `hostapd` + `dnsmasq` + `iptables`

#### 1. **Verifique se sua placa Wi-Fi suporta modo AP + cliente**
Nem todas suportam isso simultaneamente. Teste com:

```bash
iw list | grep -A 10 "Supported interface modes"
```

Procure por:
```
* AP
* station
```

Se ambos aparecerem, ótimo!

---

#### 2. **Crie uma interface virtual**
```bash
sudo iw dev wlo1 interface add ap0 type __ap
```

Isso cria `ap0`, que será usada para o hotspot.

---

#### 3. **Configure IP para `ap0`**
```bash
sudo ip addr add 192.168.150.1/24 dev ap0
sudo ip link set ap0 up
```

---

#### 4. **Configure o `hostapd`**
Crie o arquivo `/etc/hostapd/hostapd.conf`:

```ini
interface=ap0
driver=nl80211
ssid=WiFi-do-Marcelo
hw_mode=g
channel=6
auth_algs=1
wmm_enabled=0
wpa=2
wpa_passphrase=senha123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```

E edite `/etc/default/hostapd` para apontar para esse arquivo:

```ini
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

---

#### 5. **Configure DHCP com `dnsmasq`**
Adicione ao `/etc/dnsmasq.conf`:

```ini
interface=ap0
dhcp-range=192.168.150.10,192.168.150.50,12h
```

Reinicie:
```bash
sudo systemctl restart dnsmasq
```

---

#### 6. **Configure NAT para compartilhar a internet**
```bash
sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -i ap0 -o wlo1 -j ACCEPT
sudo iptables -A FORWARD -i wlo1 -o ap0 -m state --state RELATED,ESTABLISHED -j ACCEPT
```

---

#### 7. **Inicie o hotspot**
```bash
sudo systemctl start hostapd
```

---

### 📱 No celular
Procure pela rede **WiFi-do-Marcelo**, conecte com a senha `senha123` e pronto — internet compartilhada via Wi-Fi sem perder a conexão no seu PC.

---

# Problema ao Atribuir IP ao `ap0`
>Meu IP é 192.168.15.234 com GW 192.168.15.1

Tem um detalhe importante que pode te salvar de dor de cabeça com roteamento e conflitos de IP.

---

### ⚠️ O problema de usar `192.168.15.236/24` na `ap0`

Você está atribuindo à interface `ap0` um IP **dentro da mesma sub-rede** da sua conexão Wi-Fi (`wlo1`), que já está em `192.168.15.234/24`. Isso pode causar:

- Conflitos de roteamento
- Problemas de NAT
- Dificuldade para o celular entender quem é o gateway

---

### ✅ O ideal: usar uma **sub-rede diferente** para `ap0`

Por exemplo:

```bash
sudo ip addr add 192.168.88.1/24 dev ap0
```

Assim, o Wi-Fi (`wlo1`) continua na rede `192.168.15.0/24`, e o hotspot (`ap0`) opera em `192.168.88.0/24`. Isso separa bem as funções:

| Interface | IP             | Função               |
|-----------|----------------|----------------------|
| wlo1      | 192.168.15.234 | Cliente da internet  |
| ap0       | 192.168.88.1   | Gateway pro celular  |

---

### 🧠 Por que isso importa?

O Linux vai saber claramente que:
- Tudo que vem da rede `192.168.88.0/24` é do hotspot
- Tudo que vai pra `192.168.15.0/24` é pra internet
- O NAT vai funcionar sem ambiguidade

---

