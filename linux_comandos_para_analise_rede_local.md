# Linux, comandos para análise rede local

1. **Instalar ferramentas**:

- Ubuntu:
```bash
sudo apt install arping arp-scan tshark
```
- ArchLinux
```bash
sudo pacman -S iputils arp-scan termshark
```

2. **Verificar se o IP está ativo**:
```bash
sudo arping -D -I enp0s31f6 -c 2 192.168.0.31
```

3. **Escanear a rede local**:
```bash
sudo arp-scan -I enp0s31f6 -l
```

4. **Limpar tabela ARP**:
```bash
sudo ip -s -s neigh flush all
```

5. **Exibir tabela ARP**:
```bash
arp -a
```

6. **Capturar pacotes de rede**:
```bash
sudo tshark -i enp0s31f6 host 192.168.0.31
```

7. **Filtrar pacotes por IP e mostrar endereços MAC**:
```bash
sudo tshark -i enp0s31f6 -Y "ip.addr == 192.168.0.31" -T fields -e eth.src -e eth.dst
```

