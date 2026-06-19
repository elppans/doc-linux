# Ubuntu, otimizacao de rede e comunicação

- Otimizando dns
```
sudo sed -i 's/^hosts:          files.*/hosts:          files dns/' /etc/nsswitch.conf
```
01) Desabilitar IPV6 no Sistema Temporariamente 
```
echo '1' | sudo tee /proc/sys/net/ipv6/conf/all/disable_ipv6
```
- Liberar e testar DNS
```
chmod 644 /etc/resolv.conf 
```
Se o PDV estiver comunicamdo com IPv6 no ping, desative o IPv6 para que o sistema use o IPv4:

 Desabilitar IPV6 no Sistema (Opcional, se o apt não estiver funcionando, apesar do teste ping funcionar):
```
echo -e '
# Desabilitar IPV6 no Sistema
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
' | sudo tee /etc/sysctl.d/99-sysctl.conf | sudo tee -a /dev/null
```
```
sudo sysctl -p
```

### 2. Otimização de Rede no Ubuntu (Kernel TCP Tuning)

Caso o software seja fechado e você precise mitigar o problema via SO no terminal do caixa, otimize o buffer TCP para manter a janela de recepção cheia, acelerando o throughput:

Adicione as seguintes linhas em /etc/sysctl.conf:
```
echo -e '
# Aumenta o tamanho máximo do buffer de recepção TCP
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216

# Ajusta os limites dinâmicos do TCP (min, default, max em bytes)
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216

# Ativa o TCP Window Scaling (essencial para conexões de alta latência)
net.ipv4.tcp_window_scaling = 1
' | sudo tee -a /etc/sysctl.d/99-sysctl.conf | sudo tee -a /dev/null
```
```
sudo sysctl -p
```
### 3. Mitigação na Infraestrutura / Backend

* *MTU/MSS Probing*: Se houver um switch ou roteador aplicando encapsulamento (VPN/SD-WAN) na loja, frames TLS fragmentados podem causar perda de pacotes. Ative o PLPMTU no Ubuntu:
```
echo -e '
net.ipv4.tcp_mtu_probing = 1
' | sudo tee -a /etc/sysctl.d/99-sysctl.conf | sudo tee -a /dev/null
```

# Ver como ficou o arquivo:
```
cat /etc/sysctl.d/99-sysctl.conf
```
```
sudo sysctl -p
```
