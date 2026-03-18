# Investigando qual serviço está demorando durante o boot

O comando clássico para isso é o **`systemd-analyze`**. Ele é o seu "raio-X" do tempo de boot.

Aqui estão as três variações mais úteis para o que você precisa:

### 1. O resumo (Tempo total)
Para ter uma ideia geral de quanto tempo o kernel, o initrd e os serviços (userspace) levaram:
```bash
systemd-analyze
```

### 2. A lista dos culpados (Ranking)
Este é o que você quer agora. Ele lista os serviços do mais lento para o mais rápido:
```bash
systemd-analyze blame
```
> **Dica:** Pressione `q` para sair da lista. Se um serviço como o `network-online.target` estiver no topo, geralmente é porque ele está esperando o DHCP ou o Wi-Fi conectar.

### 3. A linha do tempo (Gráfico)
Se quiser ver exatamente **quem esperou quem** (a árvore de dependências), você pode gerar um gráfico SVG e abrir no navegador:
```bash
systemd-analyze plot > boot_analysis.svg
```

---

### Bônus: O "Caminho Crítico"
Às vezes um serviço demora 10 segundos, mas ele roda em paralelo com outros e não atrasa o boot final. Para ver apenas os serviços que **realmente** seguraram a inicialização, use:
```bash
systemd-analyze critical-chain
```
Isso vai te mostrar uma árvore onde os serviços em **vermelho** são os que fazem parte da corrente que atrasou a chegada no prompt de login.

---

## Dica de Performance (Boot Demorado) - Resumo
Se o sistema estiver demorando a iniciar, use os comandos abaixo para diagnosticar:
* `systemd-analyze blame`: Lista serviços mais lentos.
* `systemd-analyze critical-chain`: Mostra a árvore de dependências que trava o boot.
* **Atenção:** Verifique o `/etc/fstab`. UUIDs incorretos (especialmente de **Swap**) podem causar atrasos de até 90 segundos.
