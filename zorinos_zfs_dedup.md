### Instalação do ZorinOS com ZFS
Instalando o ZorinOS em uma máquina virtual e configurando o sistema de arquivos ZFS. Durante a instalação, você encontra as partições `bpool` e `rpool`.

#### ZFS (Zettabyte File System)
O ZFS é um sistema de arquivos avançado que combina recursos de gerenciamento de volume e sistema de arquivos. Ele foi projetado para oferecer alta integridade de dados, escalabilidade e facilidade de gerenciamento.

**Benefícios do ZFS:**
- **Integridade de Dados**: Utiliza somas de verificação para garantir que os dados não sejam corrompidos.
- **Snapshots e Clones**: Permite criar snapshots (instantâneos) e clones de sistemas de arquivos de forma eficiente.
- **Redundância**: Suporta várias configurações de RAID, proporcionando proteção contra falhas de disco.
- **Compressão**: Oferece compressão de dados em tempo real, economizando espaço de armazenamento.
- **Escalabilidade**: Pode gerenciar grandes quantidades de dados e muitos discos.

**Contras do ZFS:**
- **Uso de Memória**: Pode ser mais exigente em termos de memória RAM em comparação com outros sistemas de arquivos.
- **Complexidade**: A configuração e o gerenciamento podem ser mais complexos, especialmente para iniciantes.
- **Compatibilidade**: Nem todos os sistemas operacionais suportam ZFS nativamente.

#### bpool e rpool
No contexto do ZFS, `bpool` e `rpool` são termos usados para descrever diferentes pools de armazenamento:

- **bpool (Boot Pool)**: Este pool contém os arquivos necessários para inicializar o sistema. Ele é geralmente menor e contém apenas os arquivos essenciais para o boot.
- **rpool (Root Pool)**: Este é o pool principal que contém o sistema operacional, aplicativos e dados do usuário. Ele é maior e gerencia a maior parte do armazenamento do sistema.

Esses pools ajudam a organizar e gerenciar o armazenamento de forma eficiente, garantindo que os arquivos críticos para o boot estejam separados dos demais dados do sistema.

### Comparação entre ZFS e Btrfs
Discutimos também as diferenças entre ZFS e Btrfs, dois sistemas de arquivos avançados.

#### ZFS
**Vantagens:**
- **Integridade de Dados**: Utiliza somas de verificação de ponta a ponta para detectar e corrigir automaticamente a corrupção de dados.
- **RAID Integrado**: Suporta várias configurações de RAID, incluindo RAID-Z, que oferece proteção contra falhas de disco.
- **Snapshots e Clones**: Permite criar snapshots e clones de forma eficiente, facilitando backups e recuperação de dados.
- **Compressão e Deduplicação**: Oferece compressão de dados em tempo real e deduplicação, economizando espaço de armazenamento.
- **Escalabilidade**: Suporta grandes volumes de dados e muitos discos, sendo ideal para grandes sistemas de armazenamento.

**Desvantagens:**
- **Uso de Memória**: Pode ser mais exigente em termos de memória RAM.
- **Complexidade**: A configuração e o gerenciamento podem ser mais complexos.

#### Btrfs
**Vantagens:**
- **Flexibilidade**: Suporta subvolumes e snapshots, permitindo uma gestão flexível do armazenamento.
- **RAID Integrado**: Oferece suporte a RAID, embora não tão robusto quanto o ZFS.
- **Facilidade de Uso**: Geralmente mais fácil de configurar e gerenciar em comparação com o ZFS.
- **Desfragmentação Online**: Permite desfragmentação online, melhorando o desempenho.

**Desvantagens:**
- **Integridade de Dados**: Embora suporte somas de verificação, não possui as mesmas capacidades de reparo automático do ZFS.
- **Menor Escalabilidade**: Não é tão escalável quanto o ZFS, sendo mais adequado para sistemas menores.

### Deduplicação no ZFS
A deduplicação é uma técnica usada para eliminar dados duplicados, economizando espaço de armazenamento. O ZFS utiliza deduplicação em nível de bloco, o que significa que ele verifica e elimina blocos de dados duplicados.

#### Verificando a Deduplicação
Para verificar se a deduplicação está ativada no ZFS, você pode usar o comando:
```bash
sudo zfs get dedup rpool
```
Este comando mostra o status da deduplicação para o pool `rpool`.

#### Ativando a Deduplicação
Para ativar a deduplicação no ZFS, use o comando:
```bash
sudo zfs set dedup=on rpool
```
Substitua `rpool` pelo nome do seu pool.

### Verificação e Configuração da Deduplicação
1. **Verificação Inicial**: Use `sudo zpool status` para verificar o status do pool.
2. **Ativação da Deduplicação**: Use `sudo zfs set dedup=on rpool`.
3. **Verificação da Ativação**: Use `sudo zfs get dedup rpool` para confirmar que a deduplicação está ativada.

### Considerações Finais
- **Uso de Memória**: A deduplicação pode consumir bastante memória RAM. É recomendável ter pelo menos 1 GB de RAM por TB de armazenamento.
- **Desempenho**: A deduplicação pode impactar o desempenho do sistema, especialmente em sistemas com recursos limitados.
___

ZorinOs não é instalado com a deduplicação ativa, ao instalar usando ZFS:  
![Captura de imagem_20240728_171726](https://github.com/user-attachments/assets/366800a2-2728-46e5-b7a8-c817ad46d008)

Então, se quiser usar esta tecnologia, deve ativar:  
![image](https://github.com/user-attachments/assets/af382f45-c0d0-48dc-8564-dccecd664ac7)

- Não é necessário reiniciar o sistema após ativar a deduplicação no ZFS com o comando `sudo zfs set dedup=on rpool`. A mudança entra em vigor imediatamente. No entanto, a deduplicação só será aplicada aos novos dados gravados no pool após a ativação. Dados existentes não serão deduplicados retroativamente.

- Para deduplicar os dados existentes no ZFS que foram gravados antes da ativação da deduplicação, você precisará reescrever esses dados. Isso pode ser feito de várias maneiras, mas uma abordagem comum é usar o comando `zfs send` e `zfs receive` para recriar os dados.  

### Montando o sistema de arquivos ZFS através de um Live

Para deduplicar os arquivos já existentes do sistema instalado, deve fazer através de um Live e nele, deve montar a partição ZFS configurado no sistema.  
Para montar a partição ZFS específica, por exemplo, em `/dev/sda4` a partir do Live, siga estes passos:  
>Faça o comando `sudo fdisk -l` para saber qual a partição ao qual irá trabalhar.  

1. **Abra o terminal** no ambiente live do ZorinOS.
2. **Importe o pool ZFS** associado à partição. Primeiro, identifique o pool com:
   ```bash
   sudo zpool import
   ```
   Isso listará todos os pools disponíveis. Encontre o pool que corresponde à sua partição `/dev/sda4`.
3. **Importe o pool**. No ZorinOS o nome do pool é `rpool`, importe-o com:
   ```bash
   sudo zpool import -d /dev/sda4 rpool
   ```
4. **Monte o sistema de arquivos ZFS**. Normalmente, o ZFS monta automaticamente os sistemas de arquivos quando o pool é importado. Se precisar montar manualmente, use:
>Faça o comando `df -h`, se o pool estiver montado, irá aparecer na lista.  
   ```bash
   sudo zfs mount rpool
   ```

Se precisar desmontar o pool posteriormente, você pode usar:
```bash
sudo zpool export rpool
```

Esses comandos devem permitir que você acesse os arquivos na partição ZFS a partir do ambiente live.

- O ZorinOS configura vários subdiretórios como volume dentro do rpool
![image](https://github.com/user-attachments/assets/dcd269ae-7db8-4abb-bca4-a003a0eefb25)


### Passo a Passo para Deduplicar Dados Existentes

- Para deduplicar a raiz do sistema de arquivos ZFS, você pode usar o comando `zfs` para definir a propriedade de deduplicação no dataset raiz. 
Como dito acima, o ZorinOS configura vários subdiretórios como volume dentro do rpool, então devemos trabalhar com todos os subdatasets referente ao ROOT.
É possível enviar os snapshots para outro local, como rpool/TEMP/ubuntu_onec52. Isso pode ajudar a organizar melhor os snapshots e evitar problemas. 

### Passo 1: Criar o Dataset de Destino

1. **Abra o terminal**.
2. **Crie o dataset de destino**:
   ```bash
   sudo zfs create rpool/TEMP
   ```

### Passo 2: Ativar a Deduplicação

1. **Ative a deduplicação** no dataset raiz e em todos os subdatasets.  
Supondo que o dataset raiz seja `rpool/ROOT/ubuntu_onec52`, você pode ativar a deduplicação com o seguinte comando:
> para saber qual o nome do seu dataset raiz faça o comando `sudo zfs list -H -o name`

   ```bash
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/srv
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/usr
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/usr/local
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/games
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/lib
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/lib/AccountsService
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/lib/NetworkManager
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/lib/apt
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/lib/dpkg
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/log
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/mail
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/snap
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/spool
   sudo zfs set dedup=on rpool/ROOT/ubuntu_onec52/var/www
   ```
Verifique a configuração para garantir que a deduplicação foi ativada:

   ```bash
   sudo zfs get dedup rpool/ROOT/ubuntu_onec52
   sudo zfs get dedup rpool/ROOT/ubuntu_onec52/{srv,usr,usr/local,var,var/games,var/lib,var/lib/AccountsService,var/lib/NetworkManager,var/lib/apt,var/lib/dpkg,var/log,var/mail,var/snap,var/spool,var/www}
   ```

### Passo 3: Criar Snapshots
A deduplicação será aplicada a novos dados escritos no dataset. Para deduplicar os dados existentes, você precisará copiar os dados para um novo dataset ou snapshot e, em seguida, copiá-los de volta.  
>Use o comando `sudo zfs list` para ver o campo "**ALLOC**" e verificar quanto de espaço está ocupando  

1. **Crie um snapshot** para cada dataset. Por exemplo:
   ```bash
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/srv@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/usr@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/usr/local@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/games@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/lib@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/lib/AccountsService@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/lib/NetworkManager@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/lib/apt@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/lib/dpkg@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/log@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/mail@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/snap@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/spool@dedup
   sudo zfs snapshot rpool/ROOT/ubuntu_onec52/var/www@dedup
   ```

### Passo 4: Enviar Snapshots para o Dataset Temporário

1. **Envie os snapshots** para datasets temporários. Por exemplo:
   ```bash
   sudo zfs send rpool/ROOT/ubuntu_onec52@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52
   sudo zfs send rpool/ROOT/ubuntu_onec52/srv@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/srv
   sudo zfs send rpool/ROOT/ubuntu_onec52/usr@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/usr
   sudo zfs send rpool/ROOT/ubuntu_onec52/usr/local@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/usr/local
   sudo zfs send rpool/ROOT/ubuntu_onec52/var@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/games@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/games
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/lib@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/lib
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/lib/AccountsService@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/lib/AccountsService
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/lib/NetworkManager@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/lib/NetworkManager
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/lib/apt@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/lib/apt
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/lib/dpkg@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/lib/dpkg
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/log@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/log
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/mail@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/mail
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/snap@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/snap
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/spool@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/spool
   sudo zfs send rpool/ROOT/ubuntu_onec52/var/www@dedup | sudo zfs receive rpool/TEMP/ubuntu_onec52/var/www
   ```

### Passo 5: Destruir os Datasets Originais

>Destruir o dataset raiz com `-r` remove todos os subdatasets.

1. **Destrua os datasets originais**. Por exemplo:
   ```bash
   sudo zfs destroy -r rpool/ROOT/ubuntu_onec52
   ```

### Passo 6: Renomear os Datasets Temporários

>Renomear o dataset temporário principal também renomeia todos os subdatasets.

1. **Renomeie os datasets temporários** para os nomes originais. Por exemplo:
   ```bash
   sudo zfs rename rpool/TEMP/ubuntu_onec52 rpool/ROOT/ubuntu_onec52
   ```

### Passo 6: Verifique os subdatasets

Deve verificar se os diretórios são listados corretamente

```bash
sudo zfs list
```
Esses passos devem garantir que a deduplicação seja aplicada corretamente e que os datasets sejam restaurados para seus locais originais.

- Para verificar se a deduplicação foi aplicada corretamente após renomear o dataset, você pode seguir estes passos:

1. **Verifique a propriedade de deduplicação** no dataset renomeado:
   ```bash
   sudo zfs get dedup rpool/ROOT/ubuntu_onec52
   ```
   Isso deve mostrar que a deduplicação está ativada (`on`).

2. **Verifique o uso de espaço** para ver se houve uma redução significativa devido à deduplicação. Você pode usar:
   ```bash
   sudo zfs list -o space rpool/ROOT/ubuntu_onec52
   ```
   Isso mostrará informações sobre o uso de espaço, incluindo a quantidade de espaço economizado pela deduplicação.  
   >Use também apenas `sudo zfs list` para ver o campo "**ALLOC**" e comparar quanto de espaço está ocupando  

3. **Verifique o status do pool** para garantir que tudo está funcionando corretamente:
   ```bash
   sudo zpool status
   ```

Esses comandos devem ajudar a confirmar se a deduplicação foi aplicada com sucesso e se está funcionando como esperado.  

### Comparando o antes e depois

- Antes  
![image](https://github.com/user-attachments/assets/82f72210-29ff-40b2-9246-66f63c75e125)
- Depois  
![image](https://github.com/user-attachments/assets/afbd6147-47fd-446d-a4ff-799812b65dea)

### Considerações
- **Backup**: Certifique-se de ter backups dos seus dados antes de realizar essas operações, pois elas envolvem a destruição de datasets.
- **Espaço em Disco**: Verifique se você tem espaço em disco suficiente para criar o novo dataset.
- **Desempenho**: Este processo pode ser intensivo em termos de recursos e pode levar algum tempo, dependendo do tamanho dos dados.
___
- Usar o comando `df -h` antes e depois de realizar a deduplicação é uma boa maneira de comparar o uso de espaço em disco.

### Passo a Passo para Comparar o Uso de Espaço em Disco

1. **Verifique o Uso de Espaço Antes da Deduplicação**:
   Antes de iniciar o processo de deduplicação, execute o comando `df -h` para verificar o uso atual de espaço em disco.
   ```bash
   df -h
   ```

2. **Anote os Resultados**:
   Anote os resultados, especialmente o uso de espaço no pool onde você está ativando a deduplicação (por exemplo, `rpool`).

3. **Realize o Processo de Deduplicação**:
   Siga os passos para deduplicar os dados existentes, já mencionados anteriormente.


4. **Verifique o Uso de Espaço Depois da Deduplicação**:
   Após completar o processo de deduplicação, execute o comando `df -h` novamente para verificar o uso de espaço em disco.
   ```bash
   df -h
   ```

5. **Compare os Resultados**:
   Compare os resultados do `df -h` antes e depois da deduplicação para ver a diferença no uso de espaço em disco.

### Exemplo de Comparação
Antes da deduplicação:
```plaintext
Filesystem      Size  Used Avail Use% Mounted on
rpool           100G   50G   50G  50% /mnt/files
```

Depois da deduplicação:
```plaintext
Filesystem      Size  Used Avail Use% Mounted on
rpool           100G   45G   55G  45% /mnt/files
```

Neste exemplo, você pode ver que o uso de espaço em disco diminuiu de 50G para 45G após a deduplicação.
