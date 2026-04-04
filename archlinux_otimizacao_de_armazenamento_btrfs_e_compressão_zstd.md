# Otimização de Armazenamento com BTRFS e Compressão ZSTD: Caso Prático em SSD de 1 TB

## Visão Geral
Este artigo documenta o processo de manutenção, desfragmentação e compressão transparente de dados em um SSD secundário de 1 TB utilizando o sistema de arquivos **BTRFS** e o algoritmo **ZSTD**. A operação foi realizada em um ambiente Arch Linux, visando recuperar espaço em disco e melhorar a organização dos blocos físicos sem sacrificar a performance do sistema.

---

## 🛠️ Cenário e Hardware

* **Processador:** AMD Ryzen 5 4500 (12 threads)
* **Disco Alvo:** PNY 1TB SATA SSD (`/dev/sdc1` montado em `/mnt/files`)
* **Uso Inicial:** ~648 GiB usados (~80% de ocupação)
* **Sistema de Arquivos:** BTRFS
* **Algoritmo de Compressão:** ZSTD (Nível 3)

---

## 🚀 A Operação

Para garantir que o processo não impactasse o uso geral do computador (como navegação ou jogos leves) e para monitorar o desgaste e a temperatura, a execução foi planejada com ferramentas de controle de prioridade e monitoramento em tempo real.

### 1. Configuração do Ponto de Montagem (`/etc/fstab`)
Para que os arquivos novos já fossem gravados com compressão e o SSD recebesse os comandos de descarte de forma eficiente, a linha de montagem no `fstab` foi configurada da seguinte forma:
```text
rw,noatime,ssd,discard=async,compress=zstd:3,space_cache=v2
```

### 2. O Comando de Compressão e Defragmentação
O comando principal foi executado utilizando o `time` para mensuração do tempo total:
```bash
time sudo btrfs filesystem defragment -r -czstd /mnt/files
```

### 3. Monitoramento em Tempo Real
Durante as mais de 8 horas de execução, foram utilizados os seguintes comandos em abas paralelas para acompanhar o progresso:

* **Onde o comando está trabalhando no momento:**
  ```bash
  sudo lsof /mnt/files | grep btrfs
  ```
* **Status de I/O do SSD (Leitura e Escrita):**
  ```bash
  watch -n 1 iostat -dy /dev/sdc 1 1
  ```
* **Alocação de espaço e saúde do pool:**
  ```bash
  watch -n 5 sudo btrfs filesystem usage /mnt/files
  ```

---

## 📊 Resultados e Métricas Finais

O comando levou exatamente **8 horas e 32 segundos** para processar a árvore de diretórios completa (cerca de 725 GB de dados lógicos).

### O Placar Geral de Compressão
Abaixo está o relatório gerado pela ferramenta `compsize` após a conclusão do processo:

| Diretório | Tamanho Real (Dados) | Espaço Físico em Disco | Taxa de Compressão | Espaço Salvo |
| :--- | :--- | :--- | :--- | :--- |
| `/mnt/files/VM` | 71 GB | 42 GB | **60%** | **~29 GB** |
| `/mnt/files/Games` | 477 GB | 417 GB | **87%** | **~60 GB** |
| `/mnt/files/build` | 7.9 GB | 5.9 GB | **74%** | **~2.0 GB** |
| `/mnt/files/projetos` | 956 MB | 914 MB | **95%** | ~42 MB |
| `/mnt/files/public` | 126 GB | 124 GB | 98% | ~2.0 GB |
| `/mnt/files/downloads`| 20 GB | 19 GB | 99% | ~1.0 GB |
| **TOTAL GERAL** | **725 GB** | **632 GB** | **87%** | **~93 GB** |

### 🔑 Principais Conclusões Técnicas

1. **A Vitória das Máquinas Virtuais:** A pasta `VM` foi a grande campeã de eficiência. Arquivos `.qcow2` contêm muitos espaços vazios e estruturas repetitivas, fazendo o ZSTD reduzir o espaço em disco para impressionantes **42% do tamanho original**.
2. **A Surpresa dos Jogos:** Games modernos (como *Warframe*) costumam vir com assets pouco comprimidos. O BTRFS conseguiu extrair **60 GB de espaço livre** apenas dentro da pasta `Games`.
3. **Inteligência Contra Dados Já Comprimidos:** Nas pastas `public` e `downloads` (repletas de ISOs e mídias em formatos como `.gz` e `.mkv`), o BTRFS detectou rapidamente que não haveria ganho e salvou os arquivos como `none` (sem compressão), evitando desperdício de ciclos de CPU.
4. **Espaço Não Alocado (Unallocated):** O volume de espaço livre não alocado saltou de míseros **5 GiB** para **69 GiB**. Essa folga dá ao BTRFS o "respiro" necessário para gravar novos dados de forma sequencial, reduzindo a fragmentação futura.

---

## 💡 Dicas de Manutenção Pós-Operação

Após uma compressão massiva como esta, os blocos de dados e metadados podem ficar espalhados pelo disco. Recomenda-se rodar um balanceamento rápido focado em metadados para consolidar o espaço livre:

```bash
sudo btrfs balance start -musage=50 /mnt/files
```

Para auditar e visualizar o ganho de espaço real por pasta futuramente, a melhor sintaxe descoberta para o comando `compsize` foi:
```bash
sudo compsize -x /mnt/files/*
```
___
# Sobre o BTRFS e o `/etc/fstab` otimizado

Meu `fstab` estava com uma configuração bem moderna e segura para um SSD no Arch Linux, mas como gosto de otimização e lido com ferramentas de virtualização e scripts, tinha algo faltando: a **compressão**.

Análise das minhas flags atuais:

### O que está bom:
* **`ssd`**: O BTRFS detectou seu hardware corretamente e otimiza a alocação de blocos.
* **`discard=async`**: Esta é a melhor forma de usar o TRIM hoje. Ela libera os blocos deletados em background sem "congelar" o sistema, o que é ótimo para a vida útil do seu SSD de 120 GB.
* **`space_cache=v2`**: O padrão mais rápido e seguro para gerenciar o espaço livre.

### O que pode melhorar (A Recomendação):
Eu adicionaria a flag **`compress=zstd:3`**. 

**Por que fazer isso?**
1.  **Economia de Espaço:** Em um SSD de 120 GB, cada GB conta. O `zstd` consegue comprimir arquivos de sistema e logs de forma muito eficiente.
2.  **Aumento de Performance:** Como o processador (CPU) é ordens de magnitude mais rápido que o barramento SATA do seu SSD, é mais rápido para o sistema comprimir um dado na RAM e gravar um arquivo menor no disco do que gravar o arquivo cheio. 
3.  **Redução de Desgaste:** Menos dados escritos fisicamente = menos desgaste das células NAND do SSD.

---

### Como ficaria o meu `/etc/fstab` otimizado:

```text
rw,relatime,ssd,discard=async,compress=zstd:3,space_cache=v2,subvolid=256,subvol=/@
```
Após a configuração do /etc/fstab, deve reiniciar o daemon para atualizar as informações do sistema:

```bash
sudo systemctl daemon-reload ; sudo mount -o remount /
```

Pode (e deve) fazer a mesma configuração para todas as montagens que usam BTRFS.

### O "Pulo do Gato" no BTRFS:
Diferente de outros sistemas, o BTRFS não comprime arquivos antigos automaticamente quando muda o `fstab`. Para comprimir o que já está lá (na instalação atual do Arch), precisa rodar este comando após reiniciar com a nova flag:

```bash
sudo btrfs filesystem defragment -r -czstd /
```

---

### Um ponto de atenção: `relatime` vs `noatime`
Eu estava usando `relatime`, que atualiza a data de acesso aos arquivos apenas se eles forem modificados ou após 24h. 
* Queria **performance máxima** sem se importar em saber "quando foi a última vez que abri este ou aquele arquivo", então mudei para **`noatime`**. Isso elimina centenas de pequenas operações de escrita que o Linux faz toda vez que apenas lê um arquivo.

## O nodiratime

O **`nodiratime`** é como o "irmão mais novo" do `noatime`, mas focado exclusivamente em **diretórios**.

Quando se entra em uma pasta (como `cd ~/Downloads` ou abrindo o Nautilus/Thunar), o Linux, por padrão, registra a data e hora em que "visitou" aquela pasta. O `nodiratime` diz ao sistema: "Não precisa anotar toda vez que eu entrar em uma pasta".

O que precisa saber sobre ele:

### 1. A Regra de Ouro: O `noatime` já inclui o `nodiratime`
Se configurar o `fstab` com **`noatime`**, **não precisa** adicionar o `nodiratime`. O `noatime` é um "superconjunto" que já desabilita as atualizações de tempo de acesso tanto para arquivos quanto para diretórios.

### 2. Por que usar (ou não)?
* **Vantagem:** Em um sistema como o meu, com muitos scripts e possivelmente milhares de pequenos arquivos de configuração (dotfiles), evitar que o SSD escreva metadados toda vez que um script percorre uma árvore de diretórios economiza ciclos de escrita e melhora a latência.
* **Desvantagem:** Praticamente nenhuma para um usuário doméstico ou desenvolvedor. Pouquíssimos programas dependem de saber a última vez que um diretório foi *lido* (diferente de saber quando ele foi *modificado*, que é o `mtime`).

---

### Como ficaria o `fstab`:
Se quer a performance máxima e o menor desgaste possível para seu SSD, a linha ideal seria esta:

```text
rw,noatime,ssd,discard=async,compress=zstd:3,space_cache=v2,subvol=/@
```

> **Nota:** Removi o `relatime` e coloquei o `noatime`. Note que não adicionei o `nodiratime` porque, como mencionei, o `noatime` já faz o trabalho completo sozinho.

### Resumo:
| Opção | O que faz? | Recomendação |
| :--- | :--- | :--- |
| **atime** | Atualiza acesso sempre (Lento). | ❌ Evite. |
| **relatime** | Atualiza acesso de vez em quando. | 🟡 Padrão seguro. |
| **nodiratime** | Não atualiza acesso a pastas. | 🟢 Bom, mas redundante com noatime. |
| **noatime** | **Não atualiza acesso a nada.** | 🚀 **Melhor para SSDs.** |

---
## O númereo do zstd

Esse valor representa o **Nível de Compressão** do algoritmo **Zstandard (ZSTD)**.

No BTRFS, ele aceita valores que vão de **1 até 15**.

### O que esse número faz?
Pense nisso como um equilíbrio entre o esforço do seu processador e a economia de espaço no SSD:

* **Números Baixos (1-3):** Priorizam a **velocidade**. O processador trabalha pouco, a compressão é feita quase instantaneamente, mas o arquivo não diminui tanto de tamanho.
* **Números Altos (10-15):** Priorizam o **espaço**. O processador vai "suar" mais para espremer cada bit, o que pode causar lentidão (latência) na hora de gravar arquivos grandes, mas você economiza muito mais GBs no seu SSD de 120 GB.

---

### Por que o `3` é o padrão ouro?
O Facebook (criador do ZSTD) e os desenvolvedores do BTRFS escolheram o **3** porque ele é o "ponto ideal":
* Ele oferece uma compressão muito superior ao antigo algoritmo `lzo`.
* A carga na CPU é tão baixa que, em muitos casos, o sistema fica **mais rápido** com ele do que sem compressão nenhuma (pois é mais rápido comprimir na CPU do que esperar o barramento SATA do SSD escrever o dado bruto).

### Comparativo de Níveis

| Nível | Velocidade de Escrita | Ganho de Espaço | Uso de CPU |
| :--- | :--- | :--- | :--- |
| **zstd:1** | 🚀 Ultra Rápido | 🟢 Bom | ❄️ Mínimo |
| **zstd:3** | 🟢 Rápido (Equilibrado) | 🟢 Muito Bom | ☁️ Baixo |
| **zstd:9** | 🟡 Moderado | 🔵 Ótimo | 🌡️ Médio |
| **zstd:15** | 🔴 Lento | ⚡ Máximo | 🔥 Alto |



---

### Minha recomendação para o seu Linux (Host):
Como usa um **SATA SSD** e provavelmente tem um processador moderno (mesmo que seja de entrada), sugiro:

1.  **Fique no `3`:** É o melhor para uso geral, jogos e desenvolvimento.
2.  **Suba para `zstd:1`:** Se você sentir que sua CPU é muito antiga e o sistema está "engasgando" ao salvar arquivos grandes.
3.  **Não passe de `zstd:5`:** Para uso diário como Desktop, acima disso você começa a sentir o sistema mais "pesado" na hora de instalar pacotes grandes via `pacman` ou compilar coisas do AUR, sem um ganho de espaço que justifique o esforço.

**Uma curiosidade:** O BTRFS também suporta a flag `compress-force=zstd:3`. Se usar apenas `compress`, o BTRFS testa o arquivo primeiro; se ele achar que o arquivo não comprime bem (tipo um vídeo ou JPEG), ele desiste. Com o `compress-force`, ele tenta espremer tudo de qualquer jeito.

---

## Porque com a opção compress-force fica mais lento

Quando você usa o `compress-force`, o BTRFS ignora o teste inicial de "comprimibilidade". No modo padrão (`compress`), o BTRFS olha para os primeiros KB de um arquivo; se ele perceber que o arquivo já é comprimido (como um `.zip`, `.jpg`, `.mp4` ou um pacote `.pkg.tar.zst` do Pacman), ele desiste e grava o restante do arquivo sem compressão para poupar CPU.

O que acontece se forçar:

### 1. O impacto na CPU (Onde fica lento)
Se você estiver baixando um vídeo de 2GB ou instalando um jogo pesado, o seu processador vai tentar comprimir algo que **fisicamente não pode ser mais comprimido**. 
* **Resultado:** O uso de CPU sobe desnecessariamente e a velocidade de escrita pode cair porque a CPU se torna o gargalo, não o SSD.

### 2. O impacto no SSD (Onde pode ficar rápido)
Parece contraditório, mas em arquivos que **podem** ser comprimidos (como arquivos de texto, códigos-fonte dos scripts, bancos de dados de jogos), o `compress-force` pode até deixar o sistema **mais responsivo**.
* Como o seu SSD é SATA (limitado a uns 300-500 MB/s), se a CPU comprimir um arquivo de 100MB para 30MB, o SSD termina de gravar muito mais rápido.

---

### Qual usar no SSD?

| Opção | Comportamento | Recomendação |
| :--- | :--- | :--- |
| **`compress=zstd:3`** | **Inteligente.** Tenta comprimir, mas desiste se o arquivo parecer "difícil". | 🚀 **Melhor para o seu Host.** Evita desperdício de CPU com vídeos e pacotes do Arch. |
| **`compress-force=zstd:3`** | **Teimoso.** Tenta comprimir tudo, inclusive o que já está comprimido. | 🟡 Use apenas se você tiver muitos arquivos de texto/logs que o BTRFS "acha" que não valem a pena. |

**Sugestão:** Use apenas `compress=zstd:3`. É o equilíbrio perfeito entre inteligência e economia para o hardware.
