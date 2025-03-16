# Instalar e configurar o ZRAM no Linux

Instalar e configurar o ZRAM no Linux é um processo simples. O ZRAM é um módulo do kernel que cria um dispositivo de swap comprimido na memória RAM, melhorando o desempenho do sistema, especialmente em máquinas com pouca memória RAM. Vou guiar você passo a passo para instalar e configurar o ZRAM em sistemas baseados em Arch Linux (como o Arch Linux ou o Manjaro) e em distribuições baseadas em Debian/Ubuntu.

---

### Passos para instalar e configurar o ZRAM:

#### 1. Verifique se o módulo ZRAM está carregado
O ZRAM é um módulo do kernel, então primeiro verifique se ele já está carregado:

```bash
lsmod | grep zram
```

Se não houver saída, carregue o módulo manualmente:

```bash
sudo modprobe zram
```

#### 2. Instale o `zram-generator` (para Arch Linux)
No Arch Linux, o pacote `zram-generator` facilita a configuração automática do ZRAM. Instale-o com:

```bash
sudo pacman -S zram-generator
```

#### 3. Configure o ZRAM
Crie ou edite o arquivo de configuração do ZRAM em `/etc/systemd/zram-generator.conf`. Por exemplo:

```ini
[zram0]
zram-size = min(ram, 4096)  # Usa metade da RAM ou 4 GB, o que for menor
compression-algorithm = lz4  # Algoritmo de compressão (lz4, zstd, lzo, etc.)
swap-priority = 100          # Prioridade do swap
```

- `zram-size`: Define o tamanho do ZRAM. Você pode usar valores fixos (por exemplo, `2G` para 2 GB) ou expressões como `min(ram, 4096)` para usar metade da RAM ou 4 GB, o que for menor.
- `compression-algorithm`: Escolha o algoritmo de compressão. Os mais comuns são `lz4`, `zstd`, e `lzo`.
- `swap-priority`: Define a prioridade do swap. Quanto maior o valor, maior a prioridade.

#### 4. Reinicie o serviço ZRAM
Após configurar o arquivo, reinicie o serviço ZRAM:

```bash
sudo systemctl restart systemd-zram-setup@zram0.service
```

#### 5. Verifique se o ZRAM está ativo
Verifique se o ZRAM foi configurado corretamente e está em uso:

```bash
swapon --show
```

Você verá uma entrada para `/dev/zram0` com o tamanho e a prioridade configurados.

---

### Instalação em distribuições baseadas em Debian/Ubuntu
Em distribuições como Ubuntu, você pode usar o pacote `zram-tools` para configurar o ZRAM.

#### 1. Instale o `zram-tools`
```bash
sudo apt update
sudo apt install zram-tools
```

#### 2. Configure o ZRAM
Edite o arquivo de configuração em `/etc/default/zramswap`. Por exemplo:

```bash
ALGO=lz4
PERCENT=50
PRIORITY=100
```

- `ALGO`: Algoritmo de compressão (`lz4`, `zstd`, `lzo`, etc.).
- `PERCENT`: Percentual da memória RAM a ser usado para o ZRAM (por exemplo, `50` para 50% da RAM).
- `PRIORITY`: Prioridade do swap.

#### 3. Reinicie o serviço ZRAM
Reinicie o serviço para aplicar as configurações:

```bash
sudo systemctl restart zramswap
```

#### 4. Verifique se o ZRAM está ativo
Verifique o swap ativo com:

```bash
swapon --show
```

---

### Configuração manual do ZRAM (sem pacotes)
Se preferir configurar o ZRAM manualmente, siga estes passos:

1. Crie um dispositivo ZRAM:
   ```bash
   echo 1 | sudo tee /sys/class/zram-control/hot_add
   ```

2. Defina o tamanho do ZRAM (por exemplo, 2 GB):
   ```bash
   echo 2G | sudo tee /sys/block/zram0/disksize
   ```

3. Configure o algoritmo de compressão (por exemplo, `lz4`):
   ```bash
   echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
   ```

4. Crie e ative o swap:
   ```bash
   sudo mkswap /dev/zram0
   sudo swapon /dev/zram0
   ```

5. Verifique o swap ativo:
   ```bash
   swapon --show
   ```

---

### Dicas e otimizações:
1. **Algoritmo de compressão**:
   - Use `lz4` para velocidade ou `zstd` para uma melhor taxa de compressão.
   - Verifique os algoritmos suportados com:
     ```bash
     cat /sys/block/zram0/comp_algorithm
     ```

2. **Prioridade do swap**:
   - Defina uma prioridade alta (por exemplo, `100`) para que o ZRAM seja usado antes do swap em disco.

3. **Combinação com swap em disco**:
   - Se você já tem um swap em disco, o ZRAM será usado primeiro devido à sua alta prioridade.

4. **Monitoramento**:
   - Para verificar o uso do ZRAM, use:
     ```bash
     cat /sys/block/zram0/mm_stat
     ```

---

### Resumo:
- O ZRAM é uma ótima solução para melhorar o desempenho do sistema, especialmente em máquinas com pouca memória RAM.
- No Arch Linux, use o `zram-generator` para configuração automática.
- No Ubuntu/Debian, use o `zram-tools`.
- Para configuração manual, crie e configure o dispositivo ZRAM diretamente via `/sys/class/zram-control`.
___
