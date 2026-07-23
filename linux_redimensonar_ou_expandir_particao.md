# Linux, redimensonar ou expandir particao

Você pode automatizar ou facilitar bastante o processo de expandir a partição via linha de comando sem precisar abrir a interface gráfica do GParted.

Para fazer isso via terminal, você precisa de três etapas básicas: corrigir o cabeçalho do disco (se for GPT e o disco destino for maior), redimensionar a partição (com o `parted`) e, por fim, expandir o sistema de arquivos para ocupar o novo espaço.
___
### 1. Corrigir a tabela GPT (Se aplicável)

Quando você clona um disco menor para um maior usando o `dd`, a tabela GPT secundária (backup) fica gravada no lugar errado (onde o disco antigo terminava, e não no final do disco novo). O `parted` pode reclamar disso de forma interativa. Para resolver silenciosamente via terminal, o `sgdisk` é a ferramenta ideal:

```bash
# Move o backup da tabela GPT para o final do disco novo
sgdisk -e /dev/nvme1n1

```

### 2. Expandir a partição com o `parted`

Você pode rodar o `parted` no modo script/silencioso (`-s`) mandando ele redimensionar a partição para preencher `100%` do espaço disponível.

*(Atenção: Substitua o `1` no comando abaixo pelo número correto da sua partição root. Se houver uma partição swap logo após a root, ela precisará ser deletada ou movida antes).*

```bash
# Sintaxe: parted -s <disco> resizepart <número_da_partição> <tamanho_final>
parted -s /dev/nvme1n1 resizepart 1 100%

```

### 3. Expandir o Sistema de Arquivos

O `parted` aumenta a "gaveta" (a partição física), mas você ainda precisa avisar o sistema de arquivos que ele pode usar esse novo espaço.

**Se você estiver usando ext4 (padrão do Debian/Ubuntu):**

```bash
resize2fs /dev/nvme1n1p1

```

**Se estiver usando XFS:**

```bash
# No XFS, o comando exige que a partição esteja montada e aponta para o diretório
xfs_growfs /

```

---

### Dica para seus Scripts de Automação

Uma alternativa ainda mais robusta para automação do que o `parted` é o **`growpart`** (que geralmente vem no pacote `cloud-guest-utils`).

Ele lida muito bem com redimensionamentos via script sem se enrolar com setores:

```bash
# Instala caso não tenha
apt-get install cloud-guest-utils -y

# Expande a partição 1 do nvme1n1
growpart /dev/nvme1n1 1

# Expande o sistema de arquivos ext4
resize2fs /dev/nvme1n1p1

```

Ambas as abordagens vão te poupar de abrir a interface gráfica e tornam o processo de deploy muito mais rápido!
