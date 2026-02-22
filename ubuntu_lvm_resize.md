# Redimensionamento de Partição LVM no Ubuntu (Hot-Resize)

Este guia descreve o procedimento passo a passo para expandir o espaço em disco de uma máquina virtual Ubuntu instalada com LVM (Logical Volume Management), sem a necessidade de reiniciar o sistema ou utilizar mídias externas (Live CD).
>Este procedimento é necessário, após aumentar o tamanho do disco na Váquina Virtual

## Cenário
* **SO:** Ubuntu 22.04+
* **Disco:** `/dev/vda`
* **Volume Alvo:** `vgubuntu-root`
* **Objetivo:** Incorporar espaço extra adicionado ao disco virtual diretamente na raiz (`/`) do sistema.

---

## 1. Preparação do Disco Físico

### Corrigir a tabela de partições (GPT)
Ao aumentar o disco em uma VM, a tabela GPT precisa ser movida para o novo final do disco para que o espaço extra seja reconhecido.
```bash
sudo sgdisk -e /dev/vda

```

### Expandir a partição física

Utilizamos o `growpart` para esticar a partição que contém o LVM. (Certifique-se de ter o pacote `cloud-guest-utils` instalado).

```bash
sudo apt update && sudo apt install cloud-guest-utils -y
```
```bash
sudo growpart /dev/vda 2

```

*Nota: O espaço entre o dispositivo (`/dev/vda`) e o número da partição (`2`) é obrigatório.*

---

## 2. Gerenciamento do LVM

### Atualizar o Physical Volume (PV)

Informa ao LVM que o dispositivo físico agora possui um novo tamanho.

```bash
sudo pvresize /dev/vda2

```

### Expandir o Volume Lógico e o Sistema de Arquivos

Este comando expande o volume lógico utilizando 100% do espaço livre disponível e já redimensiona o sistema de arquivos (`ext4`) em tempo real.

```bash
sudo lvextend -l +100%FREE /dev/mapper/vgubuntu-root -r

```

---

## 3. Comandos de Verificação

Utilize os comandos abaixo para validar se as alterações foram aplicadas corretamente em cada camada:

| Objetivo | Comando |
| --- | --- |
| **Espaço na Raiz** | `df -h /` |
| **Hierarquia e FS** | `sudo lsblk -f` |
| **Detalhes do LV** | `sudo lvdisplay /dev/mapper/vgubuntu-root` |
| **Status do PV** | `sudo pvs` |
| **Espaço no Grupo** | `sudo vgs` |
| **Mapa de Alocação** | `sudo pvdisplay -m` |

---

> **Aviso de Segurança:** Embora este procedimento seja seguro para expansão (online), sempre certifique-se de possuir um backup ou snapshot da VM antes de manipular partições.

---

### Tópicos:
1.  **Tabela de Verificação:** Organiza os comandos de conferência de forma muito mais legível que uma lista simples.
2.  **Explicações Curtas:** Cada seção explica o *porquê* do comando, o que ajuda quem está lendo o seu repositório a aprender o conceito.
3.  **Aviso de Snapshot:** Dá um toque de senioridade ao seu documento, mostrando preocupação com a segurança dos dados.
___

## 4. Alternativa Gráfica (Desktop) - Blivet-GUI

Para quem possui ambiente gráfico instalado e prefere uma abordagem visual, o **Blivet-GUI** é a ferramenta mais recomendada para manipular LVM. Ele permite realizar todas as etapas acima (redimensionar partição e esticar volume) através de uma interface intuitiva.

### Instalação no Ubuntu 22.04
Você pode instalar a versão oficial dos repositórios do Ubuntu:
```bash
sudo apt update && sudo apt install blivet-gui -y

```

*Nota: Versão mais recente via repositório do desenvolvedor (OpenSUSE Build Service):*

```bash
echo 'deb [http://download.opensuse.org/repositories/home:/vtrefny/xUbuntu_22.04/](http://download.opensuse.org/repositories/home:/vtrefny/xUbuntu_22.04/) /' | sudo tee /etc/apt/sources.list.d/home:vtrefny.list
curl -fsSL [https://download.opensuse.org/repositories/home:vtrefny/xUbuntu_22.04/Release.key](https://download.opensuse.org/repositories/home:vtrefny/xUbuntu_22.04/Release.key) | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_vtrefny.gpg > /dev/null
sudo apt update && sudo apt install blivet-gui

```

### Procedimento Visual

1. **Redimensionar Partição Física:** Selecione o disco (`/dev/vda`), clique na partição LVM, escolha **Resize** e arraste até o final do espaço cinza.
2. **Expandir Volume Lógico:** Vá até a aba LVM ou selecione o Volume Group, escolha o volume `root`, clique em **Resize** e arraste para o máximo.
3. **Aplicar:** Clique no ícone de "check" (✔) no topo para executar a fila de tarefas.

### Por que usar o Blivet-GUI em vez do GParted?
Enquanto o GParted é excelente para partições simples, o **Blivet-GUI** foi desenhado especificamente para entender a hierarquia do LVM (Volumes Físicos > Grupos de Volumes > Volumes Lógicos). Ele "enxerga" que ao aumentar a partição, ele deve automaticamente disponibilizar esse espaço para o Volume Group, algo que ferramentas mais simples às vezes ignoram.



