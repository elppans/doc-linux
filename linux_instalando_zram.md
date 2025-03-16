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

## Para um computador com 16 GB de RAM, a configuração ideal do ZRAM

Para um computador com **16 GB de RAM**, a configuração ideal do ZRAM depende do seu uso e das necessidades do sistema. Vou te guiar com algumas recomendações gerais e fatores a considerar para decidir o tamanho do ZRAM.

---

### Recomendação geral:
Para um sistema com 16 GB de RAM, uma boa prática é configurar o ZRAM com um tamanho entre **2 GB e 4 GB**. Isso é suficiente para a maioria dos casos de uso, como desktops ou laptops com multitarefa moderada.

- **2 GB**: Adequado para uso geral, como navegação na web, edição de documentos e multitarefa leve.
- **4 GB**: Recomendado para uso mais intensivo, como edição de vídeo, virtualização ou jogos.

---

### Fatores a considerar:
1. **Uso de memória RAM**:
   - Se você raramente usa toda a RAM disponível (por exemplo, seu uso máximo fica em torno de 10 GB), um ZRAM de 2 GB é suficiente.
   - Se você frequentemente usa quase toda a RAM (por exemplo, 14 GB ou mais), considere um ZRAM de 4 GB.

2. **Swap em disco**:
   - Se você já tem um swap em disco configurado, o ZRAM será usado primeiro devido à sua alta prioridade. Nesse caso, um ZRAM menor (2 GB) pode ser suficiente.

3. **Algoritmo de compressão**:
   - O ZRAM comprime os dados na memória. Dependendo do algoritmo usado (`lz4`, `zstd`, etc.), a taxa de compressão pode variar. Por exemplo:
     - Com `lz4`, você pode esperar uma taxa de compressão de 2:1 (ou seja, 2 GB de ZRAM podem armazenar até 4 GB de dados não comprimidos).
     - Com `zstd`, a taxa de compressão pode ser ainda melhor, mas com um custo maior de CPU.

4. **Desempenho do sistema**:
   - O ZRAM é muito mais rápido que o swap em disco, mas ainda assim usa CPU para compressão/descompressão. Se você tiver uma CPU poderosa, pode configurar um ZRAM maior sem impactar o desempenho.

---

### Como configurar o ZRAM:
No Arch Linux (usando `zram-generator`), edite o arquivo `/etc/systemd/zram-generator.conf`:

```ini
[zram0]
zram-size = 2G  # ou 4G, dependendo da sua necessidade
compression-algorithm = lz4
swap-priority = 100
```

No Ubuntu/Debian (usando `zram-tools`), edite o arquivo `/etc/default/zramswap`:

```bash
PERCENT=25  # 25% de 16 GB = 4 GB
ALGO=lz4
PRIORITY=100
```

Ou, para 2 GB:

```bash
PERCENT=12.5  # 12.5% de 16 GB = 2 GB
ALGO=lz4
PRIORITY=100
```

---

### Verificação e ajustes:
1. Verifique o uso do ZRAM após configurá-lo:
   ```bash
   swapon --show
   ```

2. Monitore o uso do ZRAM e da RAM com ferramentas como `htop` ou `free -h`:
   ```bash
   free -h
   ```

3. Ajuste o tamanho do ZRAM conforme necessário. Se você perceber que o ZRAM está sendo totalmente utilizado e o sistema ainda está usando swap em disco, aumente o tamanho do ZRAM.

---

### Exemplo de configuração para 16 GB de RAM:
- **Uso geral (multitarefa leve)**:
  ```ini
  [zram0]
  zram-size = 2G
  compression-algorithm = lz4
  swap-priority = 100
  ```

- **Uso intensivo (edição de vídeo, jogos, virtualização)**:
  ```ini
  [zram0]
  zram-size = 4G
  compression-algorithm = zstd
  swap-priority = 100
  ```

---

### Resumo:
- Para 16 GB de RAM, configure o ZRAM com **2 GB a 4 GB**.
- Use `lz4` para um bom equilíbrio entre desempenho e taxa de compressão.
- Ajuste o tamanho com base no uso da RAM e no desempenho do sistema.
- Monitore o uso do ZRAM e faça ajustes conforme necessário.
___
