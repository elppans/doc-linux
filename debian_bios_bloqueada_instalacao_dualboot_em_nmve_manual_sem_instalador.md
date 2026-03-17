# Debian. BIOS Bloqueada, Instalacao DUALBOOT em NMVE manualmente SEM instalador

- **Introdução:**

> Cliente mandou uma máquina com 2 NMVE de 1TB (931,51 GiB). Um está com Windows 2012 R2 instalado e o outro está vazio.
>
> Esta máquina não entra no Setup e nem os atalhos funcionam para fazer boot em instalador USB, independente do sistema. Então para contornar isso, faço o comando via Windows CMD, `shutdown /r /o /f /t 00`.
>
> Por algum motivo, o instalador de Windows funciona, desde que faça a cópia para o Pendrive com o Rufus, mas instalador de Linux não funciona, independente de qual método usado para criar o boot no Pendrive.
>
> Então eu instalei o Debian em um SSD de outra máquina e depois adicionei na placa mãe e fiz o esquema pelo Windows para bootar no SSD e deu certo.
>
> Fui procurar alguma outra máquina aqui, para instalar o Debian no NMVE, mas não tem.
>
> Solução encontrada: **Instalar o Debian no NMVE através do Debian instalado no SSD** E **configurar o boot através dos sistemas**.

---

Como já tenho um Debian rodando em um SSD na mesma máquina, posso usar o NVMe vazio como destino para uma instalação direta, sem precisar de pendrive ou de acessar a BIOS.

A maneira mais eficiente e "limpa" de fazer isso através de um sistema Linux já ativo é utilizando o **debootstrap**. Ele permite que seja instalado um sistema Debian base em um diretório (que será o NVMe montado) e depois o tornar inicializável.
___

### 1. Preparar o NVMe de Destino

Deve identificar o NVMe vazio (provavelmente `/dev/nvme1n1` ou similar) e crie as partições.

* **Identificar o disco:** `lsblk`
* **Particionar:** Use o `gdisk` ou `fdisk` para criar:
1. Uma partição **EFI** (512MB, tipo **EF00**).
2. Uma partição **Raiz** (o restante do disco, tipo **8300**).

Exemplo de formatação (deve ajustar o nome do dispositivo conforme lsblk)

```bash
mkfs.vfat -F 32 /dev/nvme1n1p1   # Partição EFI
```
```bash
mkfs.ext4 /dev/nvme1n1p2        # Partição Sistema
```

### 2. Montar e Instalar o Sistema Base

Agora, montamos o NVMe e usamos o `debootstrap` para "despejar" o Debian nele.

```bash
sudo mount /dev/nvme1n1p2 /mnt
```
```bash
sudo mkdir -p /mnt/boot/efi
```
```bash
sudo mount /dev/nvme1n1p1 /mnt/boot/efi
```
Instalar o sistema base (deve substituir 'trixie' pela versão desejada).
```bash
sudo apt update && sudo apt install debootstrap -y
```
```bash
sudo debootstrap trixie /mnt http://deb.debian.org/debian/
```

### 3. Configurar o Novo Sistema (Chroot)

É preciso "entrar" no NVMe para configurar a senha, o usuário e o GRUB.

Montar sistemas de arquivos necessários para o chroot.
```bash
for i in /dev /dev/pts /proc /sys /run; do sudo mount -B $i /mnt$i; done
```
Entrar no novo sistema
```bash
sudo chroot /mnt /bin/bash
```

**Dentro do chroot, execute:**

1. **Definir senha do root:** `passwd`
2. **Configurar o FSTAB:** Precisará mapear as partições (deve usar o comando `blkid` em outro terminal para pegar os UUIDs).
3. **Instalar Kernel e GRUB:**

```bash
apt update
```
```bash
apt install linux-image-amd64 grub-efi-amd64 locales -y
```
```bash
grub-install /dev/nvme1n1
```
```bash
update-grub
```

4. O "Pulo do Gato" para o Boot

Como há dificuldade em acessar o menu de boot da BIOS,  pode usar o comando `efibootmgr` dentro do Debian atual para definir o novo NVMe como a primeira opção de prioridade na NVRAM da placa-mãe.

Listar entradas atuais.
```bash
efibootmgr
```
O comando `update-grub` costuma adicionar a entrada, mas você pode 
forçar a prioridade se necessário usando o parâmetro `-o`.
___

### Configurar FSTAB

O Debian não possui o comando genfstab nativo, pois ele é um script específico do conjunto de ferramentas do Arch Linux (arch-install-scripts). Mas dá pra confgurar de uma forma bem simples.

- **O Método Manual (Padrão Debian)**

No Debian, o costume é identificar os UUIDs manualmente e colá-los no arquivo.

1) Liste os UUIDs das partições do NVMe:
```bash
blkid /dev/nvme1n1p1
```
```bash
blkid /dev/nvme1n1p2
```
2) Edite o arquivo: `nano /mnt/etc/fstab`
3) Adicione as linhas seguindo este modelo:
```bash
# <file system>                            <mount point>   <type>  <options>       <dump>  <pass>
UUID=XXXX-XXXX                             /boot/efi       vfat    defaults        0       2
UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  /               ext4    errors=remount-ro 0       1
```
___
### Alternativa: Clonagem (dd)

Se não quer configurar tudo do zero, pode simplesmente clonar o seu SSD atual para o NVMe (Mas a instalação limpa é muito mais divertida xD):

1. Dê o boot pelo SSD.
2. Use o comando: 
```bash
dd if=/dev/sdX of=/dev/nvme1n1 bs=64K conv=noerror,sync status=progress
```
>(onde `sdX` é o seu SSD com Debian).
3. Após a cópia, é melhor usar o `gparted` para expandir a partição no NVMe (já que o SSD deve ser menor ou igual a 1TB) e reinstalar o GRUB para garantir que os UUIDs de boot apontem para o local correto.
___
## Com BIOS/CMOS bloqueado, configurar boot no Windows/Linux

Para configurar o Boot quando não se tem acesso ao Setup da placa mãe, deve usar os aplicativos EasyBCD, bcdedit e/ou efibootmgr.

### Método 1: Usando o EasyBCD (Mais Visual e Simples)

O EasyBCD facilita muito o trabalho de editar o BCD sem errar a sintaxe do terminal.

1. Baixe e instale o **EasyBCD** (a versão gratuita "Non-commercial" resolve).
2. Vá em **Add New Entry** (Adicionar Nova Entrada).
3. Selecione a aba **Linux/BSD**.
4. No campo **Type**, selecione **GRUB (Legacy)** ou **GRUB 2** (tente GRUB 2 primeiro, que é o padrão do Debian).
5. No campo **Name**, escreva "Debian Linux".
6. No campo **Drive**, você pode deixar em "Automatically locate and load".
7. Clique em **Add Entry**.
8. Vá em **Edit Boot Menu** e veja se o Debian aparece lá. Marque a opção "Use Metro boot loader" para ter aquela interface azul moderna do Windows 8/2012.
___

### Método 2: Via CMD (bcdedit)
>Atenção: Via PowerShell dá erro então é melhor usar CMD mesmo.
>Se mesmo assim quer usar PowerShell, tente usar aspas duplas para os códigos

1. Abra o CMD como Administrador.
2. Crie a entrada no menu:
```cmd
bcdedit /create /d "Debian Linux" /application bootsector
```

3. O comando vai retornar um ID (um código longo entre chaves `{}`). **Deve copiar esse ID.**
4. Configure o caminho para a partição onde o GRUB está (substitua `{ID}` pelo código que foi copioado):

```cmd
bcdedit /set {ID} device partition=C:
```
```cmd
bcdedit /set {ID}  path \EFI\debian\grubx64.efi
```
```cmd
bcdedit /displayorder {ID} /addlast
```
>Ps.1: Tem que usar o código (ID) com o Colchetes e tudo: `{COD}`  

>Ps.2: *`\EFI\debian\grubx64.efi` é o caminho padrão se você instalou o Debian em modo UEFI. Se o seu Windows estiver em modo Legacy, o caminho será diferente.*
___

### Método 3: `efibootmgr` (Pelo Debian)

Já que dá entrar no Debian pelo SSD ou pelo próprio NVMe agora, dá forçar a placa-mãe a priorizar o Debian **sem tocar no Windows**.

No terminal do Debian:

1. Instale a ferramenta: `sudo apt install efibootmgr`
2. Veja a lista de boot: `sudo efibootmgr`
3. Você verá algo como:
* *Boot0001* Windows Boot Manager
* *Boot0002* debian
4. Mude a ordem para o Debian vir primeiro:
```bash
sudo efibootmgr -o 0002,0001
```

>*(Ajuste os números conforme a lista que aparecer).*

Isso faz com que, ao ligar o PC, ele caia direto no **GRUB**. O GRUB é muito melhor para detectar o Windows (via `os-prober`) do que o Windows é para detectar o Linux.

- **Observação:**

O Windows Server 2012 tem uma mania agressiva de "se colocar de volta" no topo da lista de boot após atualizações ou reboots forçados. Se o Debian "sumir" do boot, precisará rodar o comando do `efibootmgr` novamente ou usar o comando `bcdedit /set {bootmgr} path \EFI\debian\grubx64.efi` dentro do Windows para forçar o gerenciador de boot do Windows a carregar o GRUB em vez do kernel do Windows.
___

### Se nenhum dos 3 esquemas estiver dando certo

- **Configurar o Windows para carregar o Debian (Forçar)**

Use o comando abaixo no CMD do Windows (como Administrador). Isso diz ao Gerenciador de Boot do Windows que o caminho padrão agora é o Debian:

```dos
bcdedit /set {bootmgr} path \EFI\debian\shimx64.efi
```
Se o Windows disser que não encontrou o caminho, deve tentar apontar para o arquivo direto, sem o shim:

```dos
bcdedit /set {bootmgr} path \EFI\debian\grubx64.efi
```
O comando bcdedit altera a variável dentro da NVRAM que o Windows protege. Em vez de tentarmos lutar contra a placa-mãe via Linux (que ela descarta no reboot), usamos o próprio **"mecanismo de defesa"** do Windows para apontar para o Debian.

- **Dica de Segurança (O Plano de Retorno)**

Se por acaso quiser desfazer isso e voltar ao boot padrão do Windows depois:

```DOS
bcdedit /set {bootmgr} path \EFI\Microsoft\Boot\bootmgfw.efi
```

- **Após bcdedit, o EasyBCD**

Se o esquema de "Forçar" o Windows a carregar o Debian der certo, use o [EasyBCD](https://easybcd.softonic.com.br/download) par facilitar o próximo passo.

1) Abra o EasyBCD (Com Administrador).
2) Em "Visualizar Configurações" verá que o Debian já está na lista, então deve ir até "Editar menu de Boot".  
Nesta tela, estara uma lista onde a coluna "Entrada" representa a lista de Sistema e a coluna "Padrão" serve pra ver quem é o padrão do boot (Sim) ou não.
3) Clique pra selecionar e mudar o padrão, para o Debian.
Depois clique em "Salvar Configurações".
___

### Desabilitar Inicialização Rápida (Fast Startup)

No Windows, o recurso Inicialização Rápida (Fast Startup) hiberna o kernel e "tranca" as partições NTFS para evitar corrupção de dados. Por isso, aparecerem como somente leitura no Linux, desta forma geralmente não é um problema de permissão, mas sim um "bloqueio".  
Para resolver e liberar no Debian, abra o CMD (Como Admin):

```dos
powercfg /h off
```
___

## EFIBOOTMGR (Linux) x BCDEDIT (Windows)

No Windows o comando equivalente ao `efibootmgr` é o **`bcdedit`**, mas ele funciona de uma forma um pouco diferente. Enquanto o `efibootmgr` manipula diretamente as variáveis da NVRAM da placa-mãe, o `bcdedit` gerencia o banco de dados do Windows (BCD), que por sua vez interage com o firmware UEFI.

Para gerenciar a ordem de boot e as entradas de forma similar ao que você faz no Linux, use os comandos abaixo no **CMD (como Administrador)**:

---

### 1. Ver a Ordem de Boot Atual

Para listar as entradas de boot e a ordem em que elas aparecem (equivalente ao `efibootmgr` sem parâmetros):

```cmd
bcdedit /enum firmware

```

*Procure pela seção **"Gerenciador de Inicialização de Firmware"**. Lá você verá os IDs (UUIDs) e a lista `displayorder`.*

---

### 2. Alterar a Ordem de Boot

Se você quer colocar uma entrada (como o Debian) no topo da lista, você usa o comando `/displayorder`.

**Exemplo para colocar o Debian em primeiro:**

1. Primeiro, pegue o ID do Debian no comando anterior (algo como `{xxxxxxxx-xxxx...}`).
2. Execute:

```cmd
bcdedit /displayorder {ID-DO-DEBIAN} /addfirst

```

---

### 3. Definir o "Boot de uma vez só"

O `efibootmgr` tem o `-n` (bootnext) para bootar em um sistema apenas na próxima reinicialização. No Windows, você faz isso com:

```cmd
bcdedit /bootsequence {ID-DO-SISTEMA} /addfirst

```

*Isso fará com que o computador inicie no sistema escolhido apenas uma vez e, no reboot seguinte, volte à ordem normal.*

---

### 4. Criar ou Deletar Entradas

* **Deletar uma entrada órfã:**
`bcdedit /delete {ID-DA-ENTRADA}`
* **Copiar uma entrada existente para criar uma nova:**
`bcdedit /copy {bootmgr} /d "Novo Nome de Boot"`

---

### Resumo de Equivalência

| Ação (Linux `efibootmgr`) | Comando Windows (`bcdedit`) |
| --- | --- |
| `efibootmgr` (listar) | `bcdedit /enum firmware` |
| `efibootmgr -o 0001,0002` | `bcdedit /displayorder {ID1} {ID2}` |
| `efibootmgr -n 0001` | `bcdedit /bootsequence {ID1} /addfirst` |
| `efibootmgr -B -b 0001` | `bcdedit /delete {ID1}` |

### O caso da "BIOS Travada"

Com a placa-mãe impedindo de usar o SETUP e resetando as alterações, o comando (`bcdedit /set {bootmgr} path \EFI\debian\shimx64.efi`) é o mais "agressivo", pois ele não tenta apenas mudar a ordem, ele **sequestra** a entrada principal que a BIOS sempre procura.
___

# RESUMO DO BOOT

Foi testado várias maneiras e a única que deu certo foi esta:

No Windows, removi toda a configuração que fiz do boot, copiei esta sequência de comandos para o Bloco de notas e os executei, 1 por 1, copiando do bloco de notas e colando no CMD. 

Então deu certo, mesmo que já tivesse feito exatamente os mesmos comandos antes:

```dos
bcdedit /enum firmware
```
```dos
bcdedit /create /d "Debian Linux" /application bootsector
```
```dos
bcdedit /set {ID} device partition=C:
```
```dos
bcdedit /set {ID}  path \EFI\debian\grubx64.efi
```
```dos
bcdedit /displayorder {ID} /addlast
```
```dos
bcdedit /displayorder {ID-DO-DEBIAN} /addfirst
```

Notei que reinciar pelo botão do Windows atrapalha, o melhor é desligar por completo e depois ligar novamente:

```DOS
shutdown /s /f /t 0
```
___

# Hostname e Username no Debian

### 1. Alterar o Hostname (Nome da Máquina)

1. **Edite o arquivo `/etc/hostname`:**
Substitua `debian` pelo nome que desejar (ex: `pdv-server`).
```bash
echo "novo-nome-da-maquina" | sudo tee /etc/hostname

```
```bash
sudo hostname -b "novo-nome-da-maquina"

```
2. **Edite o arquivo `/etc/hosts`:**
Procure a linha que aponta para `127.0.1.1` e mude o nome antigo para o novo.
```bash
nano /etc/hosts

```
Deve ficar algo como:
```ini
127.0.1.1   novo-nome-da-maquina`
```
---

### 2. Alterar o Nome de Usuário

Mudar um usuário existente (de `debian` para `novo-nome-do-usuário`, por exemplo) envolve renomear o login, a pasta home e o grupo.

**Dica de Ouro:** Se você estiver dentro do **chroot**, o comando `usermod` funciona perfeitamente.

1. **Renomear o usuário e mover a home:**
```bash
usermod -l novo-nome-do-usuário -d /home/novo-nome-do-usuário -m nome_antigo
```
* `-l`: Altera o nome de login.
* `-d`: Define o novo caminho da pasta pessoal.
* `-m`: Move o conteúdo da pasta antiga para a nova automaticamente.

2. **Renomear o grupo principal:**
Geralmente, no Debian, o grupo tem o mesmo nome do usuário.
```bash
groupmod -n novo-nome-do-usuário nome_antigo
```
3. **Verificar se o UID/GID está correto:**
Apenas para garantir que os arquivos ainda pertencem ao usuário:
```bash
ls -la /home/novo-nome-do-usuário
```
4. **Modificar a senha**
```bash
passwd novo-nome-do-usuário
```


5. Ajuste Final (Sudoers)

Se foi adicionnado o usuário ao grupo `sudo` anteriormente, o comando `usermod` acima já manteve os privilégios, pois ele altera o nome associado ao ID do usuário. Mas, se foi criado um arquivo manual em `/etc/sudoers.d/`, melhor verificar se o nome lá dentro precisa ser atualizado

---

### Erro usermod: `user debian is currently used by process 1375`

Mesmo sendo root, o sistema operacional protege a integridade do usuário. Se o debian está rodando o processo que sustenta a sua janela de terminal atual, renomear a pasta /home/usuário para /home/novo_usuário quebraria o caminho do shell que está usando naquele exato segundo. Por isso o bloqueio.

- **CONTORNANDO:**
Se o sistema tem o usuário `root` ativo, logue com ele e faça o processo do usuário.  
Se o sistema NÃO tem o `root` ativo e não quer (ou não pode) ativar, a melhor forma de resolver isso sem se trancar para fora do sistema é **criar um usuário temporário**, fazer a alteração por ele e depois apagá-lo.
___

1. Criar um usuário temporário com poderes de root

```bash
useradd -m -G sudo temp
```
Definir uma senha (algo simples, como '123')
```bash
passwd temp
```
```
2. Sair totalmente do usuário atual

Agora vem a parte importante: você precisa deslogar do usuário `atual`.

* Se estiver usando SSH, saia e entre novamente como `temp`.
* Se estiver no terminal local, faça logout e entre como `temp`.

**Para garantir que não sobrou nenhum processo do usuário,** após logar como `temp`, vire root (`sudo su`) e mate qualquer processo remanescente.

```bash
sudo killall -u usuário
```

3. Agora sim, execute o usermod

Com o usuário `atual` totalmente livre, os comandos da etapa 1 agora vai funcionar.

4. Teste e Limpeza

Usuário configurado, saia do usuário `temp` e tente logar com o `novo-nome-do-usuário`. Se funcionar:

- Remova o usuário temporário e a pasta dele
```bash
sudo userdel -r temp
```
---
