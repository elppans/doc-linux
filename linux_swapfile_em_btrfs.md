# Linux, Swapfile em BTRFS

No Btrfs, a configuração de swap é um pouco diferente porque **swapfiles não são suportados diretamente** (pelo menos sem algumas configurações adicionais). O Btrfs usa COW (Copy-On-Write), o que causa problemas para swapfiles normais.  

Aqui estão as opções para ativar o swap corretamente no seu sistema usando Btrfs:

---

## **Opção 1: Criar um Swapfile Compatível no Btrfs (Método Suportado)**
Se quiser um arquivo de swap no Btrfs, é necessário criar um arquivo sem Copy-On-Write (COW):

### **Passo 1: Criar um arquivo de swap sem COW**
```bash
sudo btrfs filesystem mkswapfile --size 2G /swapfile
```
Isso cria um swapfile diretamente no Btrfs, garantindo que ele funcione corretamente.

### **Passo 2: Ativar o swap**
```bash
sudo swapon /swapfile
```

### **Passo 3: Tornar a configuração permanente**
Adicione esta linha no `/etc/fstab`:
```bash
/swapfile none swap sw 0 0
```

Pronto! Esse método é o recomendado oficialmente para swapfiles no Btrfs.

---

## **Opção 2: Criar uma Partição de Swap Separada**
Se não quiser usar um swapfile, pode criar uma partição dedicada para swap:

### **Passo 1: Criar a partição**
Se tiver espaço livre, use o `fdisk` ou `gparted` para criar uma partição (`/dev/sdX`, substitua pelo dispositivo correto).

### **Passo 2: Formatar a partição para swap**
```bash
sudo mkswap /dev/sdX
```

### **Passo 3: Ativar o swap**
```bash
sudo swapon /dev/sdX
```

### **Passo 4: Tornar a configuração permanente**
Adicione no `/etc/fstab`:
```bash
/dev/sdX none swap sw 0 0
```

---

## **Opção 3: Usar ZRAM (Melhor para VMs e Desempenho)**
Se estiver rodando no QEMU/KVM, talvez o melhor seja usar **ZRAM** em vez de swap tradicional. O ZRAM comprime a memória RAM antes de trocá-la, o que melhora o desempenho:

```bash
sudo pacman -S zram-generator
```

Edite o arquivo de configuração:
```bash
sudo nano /etc/systemd/zram-generator.conf
```
Adicione algo como:
```
[zram0]
zram-size = ram / 2
compression-algorithm = zstd
swap-priority = 100
```

Ative e inicie:
```bash
sudo systemctl enable --now systemd-zram-setup@zram0.service
```

---

## **Qual Opção Escolher?**
- **Se quiser um swapfile no Btrfs**, use a **Opção 1** (swapfile com `btrfs filesystem mkswapfile`).
- **Se puder criar uma partição separada**, use a **Opção 2**.
- **Se estiver em VM e quiser mais eficiência**, use **ZRAM (Opção 3)**.
___
## Exemplo de configuração do `ZRAM` e como modificar

```bash
[arch@archlinux ~]$ systemctl status systemd-zram-setup@zram0.service
● systemd-zram-setup@zram0.service - Create swap on /dev/zram0
     Loaded: loaded (/usr/lib/systemd/system/systemd-zram-setup@.service; static)
    Drop-In: /run/systemd/generator/systemd-zram-setup@zram0.service.d
             └─bindings.conf
     Active: active (exited) since Sat 2025-03-15 20:58:40 -03; 3min 50s ago
 Invocation: 45bc51878bec4d7a9c86522f1abf1d31
       Docs: man:zram-generator(8)
             man:zram-generator.conf(5)
    Process: 331 ExecStart=/usr/lib/systemd/system-generators/zram-generator --setup-device zram0 (code=exited, status=0/SUCCESS)
   Main PID: 331 (code=exited, status=0/SUCCESS)
   Mem peak: 3.9M
        CPU: 18ms

mar 15 20:58:39 archlinux systemd[1]: Starting Create swap on /dev/zram0...
mar 15 20:58:40 archlinux systemd-makefs[332]: /dev/zram0 successfully formatted as swap (label "zram0", uuid dc3fdc71-ba67-45f5-976c-8890459a40d7)
mar 15 20:58:40 archlinux systemd[1]: Finished Create swap on /dev/zram0.
[arch@archlinux ~]$ cat /etc/systemd/zram-generator.conf
[zram0]
[arch@archlinux ~]$ 
```
Neste exemplo tenho o ZRAM configurado, mas a configuração ainda não foi personalizada no arquivo `/etc/systemd/zram-generator.conf`. Isso significa que o sistema está criando um dispositivo de swap ZRAM automaticamente, mas sem configurações específicas como tamanho ou algoritmo de compressão.

### Passos para configurar o ZRAM adequadamente:

1. **Editar o arquivo de configuração do ZRAM**

   Você pode configurar o tamanho do ZRAM, o algoritmo de compressão e outras opções ajustando o arquivo `/etc/systemd/zram-generator.conf`.

   Vamos editar esse arquivo para adicionar as configurações recomendadas:

   ```bash
   sudo nano /etc/systemd/zram-generator.conf
   ```

2. **Configurar o arquivo de maneira adequada**

   Aqui está um exemplo básico de configuração para o ZRAM:

   ```ini
   [zram0]
   zram-size = 2G  # Defina o tamanho da memória comprimida (ajuste conforme a sua necessidade)
   compression-algorithm = zstd  # Algoritmo de compressão. "zstd" é eficiente.
   swap-priority = 100  # Defina a prioridade de swap. Quanto maior o número, maior a prioridade.
   ```

   **Explicação das opções:**
   - **`zram-size`**: Tamanho do dispositivo ZRAM. Aqui estamos configurando para usar 2 GB, mas você pode ajustar de acordo com a quantidade de memória RAM no seu sistema.
   - **`compression-algorithm`**: O algoritmo de compressão usado no ZRAM. `zstd` é recomendado por ser mais rápido e eficiente, mas `lz4` também é uma boa opção se precisar de velocidade.
   - **`swap-priority`**: A prioridade do swap. Defina um valor entre 0-32767, onde valores mais altos indicam maior prioridade.

3. **Reiniciar o serviço do ZRAM**

   Após editar o arquivo de configuração, reinicie o serviço para aplicar as alterações:

   ```bash
   sudo systemctl restart systemd-zram-setup@zram0.service
   ```

4. **Verificar o status do ZRAM**

   Verifique se o ZRAM está funcionando conforme esperado:

   ```bash
   sudo systemctl status systemd-zram-setup@zram0.service
   ```

   E também verifique o dispositivo de swap ZRAM ativo:

   ```bash
   swapon --summary
   ```

Se tudo estiver configurado corretamente, o ZRAM agora deve estar funcionando com o tamanho e a compressão ajustados. 
___

## Partição Swap + ZRAM

**Você pode usar a partição swap e o ZRAM juntos** sem problemas! O sistema vai gerenciar ambos como áreas de swap, e ele escolherá automaticamente qual usar com base na prioridade de swap e no uso de memória.

### Como funciona o gerenciamento de swap:

- **ZRAM**: É uma área de swap comprimida na memória RAM. Geralmente, ele é mais rápido que a swap tradicional (baseada em disco) porque usa a RAM, mas, por ser uma área comprimida, tem um desempenho um pouco inferior ao da memória RAM direta.
  
- **Swap no disco**: Uma partição swap ou um arquivo de swap é mais lento, pois envolve leitura e escrita no disco (ou SSD), mas pode fornecer uma maior capacidade de "troca" de dados quando o ZRAM estiver cheio.

### Como o sistema escolhe entre eles:
- O sistema **prioriza o swap de acordo com a prioridade definida no arquivo de configuração**. Se você tiver uma partição swap e ZRAM, o ZRAM normalmente será preferido se tiver a mesma ou maior prioridade.
- O kernel vai primeiro tentar usar o swap com maior prioridade (o que você configurou com `swap-priority`), então, se o ZRAM estiver configurado com alta prioridade, ele será preferido.
  
### Como configurar para usar ambos:
Se você já tem uma partição swap configurada, e deseja usar ZRAM junto com ela, apenas configure ambos no arquivo `/etc/fstab` (para que o swap seja ativado automaticamente) e o arquivo de configuração do ZRAM (para otimizar o uso de ZRAM).

#### 1. **Verifique a configuração do swap**
- Se a partição swap já está configurada no `/etc/fstab`, não é necessário fazer mais nada para ativá-la automaticamente.

Exemplo de entrada no `/etc/fstab` para uma partição swap:

```bash
/dev/sdX none swap sw 0 0
```

#### 2. **Verifique a configuração do ZRAM**
- No arquivo de configuração do ZRAM (`/etc/systemd/zram-generator.conf`), você pode configurar a prioridade do swap e o algoritmo de compressão. 

Aqui está um exemplo de configuração para usar ZRAM e uma partição swap:

```ini
[zram0]
zram-size = 2G        # Tamanho do ZRAM
compression-algorithm = zstd  # Algoritmo de compressão
swap-priority = 100    # Prioridade do ZRAM (quanto maior, maior a prioridade)
```

A partição swap no `/etc/fstab` pode ter a prioridade padrão (que é `0`), e o ZRAM pode ser configurado para usar uma prioridade mais alta (por exemplo, `100`) para que seja priorizado enquanto houver espaço suficiente.

#### 3. **Reinicie o sistema**
Após configurar o arquivo `/etc/systemd/zram-generator.conf` e garantir que a partição swap está configurada no `/etc/fstab`, reinicie o sistema:

```bash
sudo systemctl restart systemd-zram-setup@zram0.service
```

Ou, se preferir, pode reiniciar o computador:

```bash
sudo reboot
```

#### 4. **Verificar as configurações de swap ativas**
Depois de reiniciar, você pode verificar se tanto o ZRAM quanto a partição swap estão ativos com o comando:

```bash
swapon --summary
```

Isso deve mostrar os dois swaps (ZRAM e a partição swap) com suas respectivas prioridades e tamanhos.

### Resumo:
- **Você pode usar ZRAM e a partição swap juntas.**
- O sistema irá usar ambos de maneira eficiente, dependendo da prioridade configurada.
- Você pode configurar a prioridade no arquivo `/etc/systemd/zram-generator.conf` e a partição swap no `/etc/fstab`.
___

## Swapfile + ZRAM

O conceito é **praticamente o mesmo** para um **swapfile**. Você pode usar um **swapfile** junto com o **ZRAM** sem problemas, e o sistema vai gerenciar ambos como áreas de swap, escolhendo automaticamente qual utilizar com base na prioridade de swap e no uso de memória.

### Como funciona quando você tem um **swapfile** e **ZRAM** juntos:
- **ZRAM**: Como mencionei, o ZRAM usa a memória RAM para criar uma área de swap comprimida. Ele geralmente será mais rápido que um swap no disco.
  
- **Swapfile**: Um swapfile é um arquivo no disco (ou SSD) que é usado como área de swap. Ele é mais lento do que o ZRAM, pois envolve operações de leitura e escrita no disco, mas pode fornecer mais espaço para swap.

O sistema vai gerenciar o uso desses dois de acordo com a prioridade configurada. **ZRAM** é normalmente preferido, mas se o sistema começar a precisar de mais swap do que o ZRAM pode fornecer, ele começará a usar o **swapfile**.

### Como configurar ambos para usarem juntos:

1. **Configuração do Swapfile**
   Primeiro, você precisa garantir que o swapfile está criado e ativado corretamente. Aqui está um exemplo de como criar e configurar um swapfile:

   ```bash
   sudo fallocate -l 2G /swapfile  # Cria um arquivo de swap de 2GB
   sudo chmod 600 /swapfile        # Altera as permissões
   sudo mkswap /swapfile           # Formata o arquivo como swap
   sudo swapon /swapfile           # Ativa o swapfile
   ```

   Para tornar o swapfile permanente (para que ele seja ativado automaticamente na inicialização), adicione a seguinte linha ao arquivo `/etc/fstab`:

   ```bash
   /swapfile none swap sw 0 0
   ```

2. **Configuração do ZRAM**
   No caso do ZRAM, você pode configurar o arquivo `/etc/systemd/zram-generator.conf` para especificar o tamanho do ZRAM e o algoritmo de compressão (como `zstd`), além de definir a prioridade do swap.

   Exemplo de configuração no arquivo `/etc/systemd/zram-generator.conf`:

   ```ini
   [zram0]
   zram-size = 2G            # Defina o tamanho do ZRAM (ajuste conforme necessário)
   compression-algorithm = zstd  # Usando o algoritmo de compressão zstd
   swap-priority = 100        # Define a prioridade do ZRAM (quanto maior, maior a prioridade)
   ```

   A prioridade do swapfile no `/etc/fstab` é normalmente `0`, mas você pode ajustar a prioridade no arquivo de configuração do ZRAM (como mostrado acima). O ZRAM seria utilizado preferencialmente por causa da prioridade mais alta.

3. **Reiniciar o serviço do ZRAM**
   Após configurar o arquivo do ZRAM e garantir que o swapfile está configurado corretamente no `/etc/fstab`, reinicie o serviço do ZRAM para que as configurações sejam aplicadas:

   ```bash
   sudo systemctl restart systemd-zram-setup@zram0.service
   ```

4. **Verificar o status dos swaps**
   Após a reinicialização ou após reiniciar o serviço do ZRAM, verifique se tanto o ZRAM quanto o swapfile estão ativos:

   ```bash
   swapon --summary
   ```

   Isso deve listar ambos (o ZRAM e o swapfile), mostrando os dispositivos e o uso de cada um.

### Resumo:
- **Você pode usar o swapfile e o ZRAM juntos**.
- O **ZRAM** será preferido caso tenha uma prioridade maior, mas o **swapfile** será utilizado quando necessário.
- As configurações de **prioridade de swap** podem ser ajustadas no arquivo de configuração do ZRAM (`/etc/systemd/zram-generator.conf`) e no `/etc/fstab` para o swapfile.


