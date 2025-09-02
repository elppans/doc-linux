# ubuntu full wifi hotspot only commands

Somente comandos.
Note sem Ethernet, apenas WiFi, configurar note para compartilhar WiFi para o celular.
___
## Instalação de pacotes
```bash
sudo apt install hostapd
```
```bash
sudo nano /etc/hostapd/hostapd.conf
```
```ini
interface=ap0
driver=nl80211
ssid=WiFi-AP0       
hw_mode=g
channel=6
auth_algs=1
wmm_enabled=0
wpa=2
wpa_passphrase=senha123
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
```
```bash
sudo nano /etc/default/hostapd
```
>Adicionar ao final do arquivo

```ini
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```
___
```bash
sudo apt install dnsmasq
```
## sudo nano /etc/dnsmasq.conf
>Adicionar ao final do arquivo
```ini
interface=ap0
dhcp-range=192.168.150.10,192.168.150.50,12h
port=0
dhcp-option=option:dns-server,8.8.8.8
```
___
## Liberar forward
```bash
echo "net.ipv4.ip_forward=1" | sudo tee -a /etc/sysctl.conf
```
___
## Comandos para adicionar/configurar AP0
```bash
iw list | grep -A 10 "Supported interface modes"
sudo iw dev wlo1 interface add ap0 type __ap
sudo ip addr add 192.168.150.1/24 dev ap0
sudo ip link set ap0 up

sudo iptables -t nat -A POSTROUTING -o wlo1 -j MASQUERADE
sudo iptables -A FORWARD -i ap0 -o wlo1 -j ACCEPT
sudo iptables -A FORWARD -i wlo1 -o ap0 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo sysctl -w net.ipv4.ip_forward=1

#sudo systemctl unmask hostapd # Se estiver mascarado
sudo systemctl restart hostapd
sudo systemctl status hostapd

sudo systemctl restart dnsmasq
sudo systemctl status dnsmasq
```
___
### Fonte:
### https://github.com/elppans/doc-linux/blob/main/ubuntu_criar_interface_de_rede.md





