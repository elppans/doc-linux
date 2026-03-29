# Compartilhamento de Pastas e Performance no KVM/QEMU (Windows & Linux)

Este guia explica como ativar o compartilhamento de arquivos ultra-rápido via **SPICE WebDAV** e como deixar suas VMs Windows com performance de máquina real (Bare Metal) usando as otimizações de **Hyper-V**.

## 🚀 O que você ganha com isso?

  * **Arrastar e Soltar:** Mova arquivos entre o Linux (Host) e a VM (Guest) sem complicação.
  * **Performance Fluida:** O Windows para de "engasgar" e utiliza melhor o processador.
  * **Sem Rede:** Não precisa configurar Samba, SSH ou pastas compartilhadas complexas.

## O que é o SPICE WebDAV?

O SPICE WebDAV permite o compartilhamento de arquivos entre o Host (Linux) e o Guest (Windows/Linux) de forma dinâmica, sem a necessidade de configurar redes complexas ou pastas Samba/NFS. Ele utiliza um canal serial virtio para comunicação.  

-----

## 🛠️ Passo 1: Configurando a Máquina Virtual

Dependendo de como você gerencia suas VMs, escolha o método abaixo:

### A. Via Terminal (`virt-install`)

Adicione estes parâmetros ao seu comando de criação. Eles ativam o canal de dados e as acelerações de hardware:

```bash
--channel spiceport,name=org.spice-space.webdav.0 \
--features hyperv_relaxed=on,hyperv_vapic=on,hyperv_spinlocks=on,hyperv_stimer=on
```
  * `hyperv_relaxed=on`: Estabiliza o relógio da VM, evitando Blue Screens (BSOD) em sistemas multitarefa.
  * `hyperv_vapic=on`: Acelera o controle de interrupções, diminuindo o uso de CPU do Host.
  * `hyperv_spinlocks=on`: Otimiza o gerenciamento de travas entre múltiplos núcleos de CPU.
  * `hyperv_stimer=on`: (Recomendado para Windows 10/11) Melhora o timer do sistema para versões modernas.
  
### B. Via Interface Gráfica (Virt-Manager)

1.  Abra os detalhes da VM (ícone da lâmpada).
2.  **Para o Compartilhamento:** Clique em "Adicionar Hardware" \> **Canal (Channel)**.
      * Nome: `org.spice-space.webdav.0`
      * Tipo de dispositivo: `spiceport`
3.  **Para Performance:** Vá em **Processador** \> **Configuração** \> Marque as opções de "Hyper-V" se disponíveis na sua versão, ou edite o XML para incluir as `features` citadas acima.

-----

## 💻 Passo 2: Configurando o Sistema Convidado (Guest)

Para que a mágica aconteça, a VM precisa saber "falar" com o Linux.

### No Windows (7, 10 e 11)

Basta instalar dois pequenos utilitários oficiais do projeto SPICE:

1.  **[spice-guest-tools](https://www.spice-space.org/download/windows/spice-guest-tools/spice-guest-tools-latest.exe):** Instala os drivers de vídeo, mouse e aceleração básica.
2.  **[spice-webdavd](https://www.spice-space.org/download/windows/spice-webdavd/spice-webdavd-x64-latest.msi):** Ativa o serviço de pastas compartilhadas.

Após instalar no Windows, abra o explorador de arquivos. O compartilhamento aparecerá como uma unidade de rede (ex: Drive `Z:` ou via rede `Spice Client Folder`). Tudo o que você jogar lá aparecerá no seu Linux.  

#### No Windows, se não aparecer automaticamente
Se não aparecer automaticamente, você pode tentar acessar digitando `\\localhost:9843` na barra de endereços do Explorer.  
No Windows 7, após reiniciar, verifique se o serviço Spice webdavd está rodando. Pressione Win + R, digite services.msc, procure por Spice webdav proxy e veja se está "Iniciado".

### No Linux (Guest)

A maioria das distros já vem pronta. Se não funcionar de primeira, instale o pacote de suporte:

```bash
sudo pacman -S spice-webdavd  # No Arch
sudo apt install spice-webdavd # No Ubuntu/Debian
```

#### No Linux, se não aparecer automaticamente ou não der para acessar

O processo é um pouco diferente porque ele não mapeia automaticamente como uma unidade de rede "estática" como o Windows faz com o "localhost:9843".

Se o Nautilus (ou seu gerenciador de arquivos) não detectar o compartilhamento automaticamente, você tem duas formas principais de acessar:

1. Via Gerenciador de Arquivos (Nautilus, Thunar, Dolphin)
Abra o seu gerenciador de arquivos e, na barra de endereços (geralmente Ctrl+L), digite o protocolo WebDAV do SPICE:

```Plaintext
dav://localhost:9843
```
>Nota: Algumas distros ou versões de gerenciadores podem exigir davs:// (se houver criptografia, o que é raro em VMs locais) ou simplesmente admin:// em casos específicos, mas o padrão para o SPICE é o dav://.

2. Montagem Manual via Terminal ("Via Arch Linux")
Se quiser montar a pasta em um diretório específico (ex: /mnt/spice_share), precisará do pacote `davfs2`.

```bash
sudo pacman -S davfs2
```

Montagem:

```bash
sudo mount -t davfs2 http://localhost:9843 /caminho/da/sua/pasta
```
>O SPICE WebDAV geralmente roda em HTTP internamente no canal serial, por isso o **http://** no comando de montagem.

-----

## ⚡ Por que usar as "Hyper-V Features"?

Se você usa Windows no KVM, essas opções são obrigatórias para uma boa experiência:

| Opção | O que ela faz por você? |
| :--- | :--- |
| **Relaxed** | Evita que o Windows trave ou dê tela azul por erros de timing. |
| **VAPIC** | Diminui o uso de CPU do Linux enquanto a VM está aberta. |
| **Spinlocks** | Melhora muito a velocidade se você deu mais de 1 núcleo para a VM. |
| **STimer** | Essencial para o Windows 10/11 rodar de forma estável. |

-----

## 💡 Dica de Ouro: GNOME Boxes

Se você usa o **GNOME Boxes**, o suporte ao SPICE já vem ativado por padrão\! Você só precisa instalar os arquivos do **Passo 2** dentro do Windows para que o ícone de "Pastas Compartilhadas" nas propriedades do Boxes comece a funcionar instantaneamente.

-----

### Resumo Técnico para Referência

  * **Protocolo:** SPICE (Simple Protocol for Independent Computing Environments)
  * **Transporte:** VirtIO Serial
  * **Aceleração:** Hyper-V Enlightenments (KVM Hidden State)

-----

# Interação entre Host e VM, spice-vdagent

### 1. O que o `spice-vdagent` faz?
Ele é responsável pela interação do usuário com a interface. Sem ele, a experiência na VM é bem "travada". As funções principais são:
* **Redimensionamento Automático:** Sabe quando você aumenta a janela da VM e a resolução do Windows/Linux ajusta sozinha para preencher a tela? É o `vdagent`.
* **Copiar e Colar (Clipboard):** Permite copiar um texto no seu Arch Linux e colar dentro da VM (e vice-versa).
* **Livre Movimento do Mouse:** Impede que o mouse fique "preso" dentro da janela da VM, permitindo que ele saia e entre suavemente.
---
### 2. E o `spice-webdavd`? (O que vimos antes)
Ele foca **exclusivamente no sistema de arquivos**. 
* Ele cria o drive de rede/pasta compartilhada.
* Permite que grandes volumes de dados sejam acessados como se fossem um HD externo virtual.
---
### 3. Preciso dos dois?
**Sim!** Para uma experiência completa, o ideal é ter ambos:

* **No Windows:** O pacote `spice-guest-tools` que você já listou no guia **já instala o vdagent automaticamente**. Por isso, o usuário só precisa baixar o `spice-webdavd` separadamente para ganhar o compartilhamento de pastas.
* **No Linux (Guest):** Geralmente instalamos os dois:
```bash
sudo apt install spice-vdagent spice-webdavd    # Debian/Ubuntu
sudo dnf install spice-vdagent spice-webdavd    # RHEL/Rocky/AlmaLinux/Fedora
sudo pacman -S spice-vdagent spice-webdavd      # ArchLinux/Manjaro
sudo zypper install spice-vdagent spice-webdavd # openSUSE
sudo emerge app-emulation/spice-vdagent && sudo emerge net-fs/spice-webdavd # Gentoo
sudo apk add spice-vdagent spice-webdavd        # Alpline Linux
```
---

### Resumo:

* O **vdagent** cuida do Mouse, Copiar/Colar e Redimensionar a tela.
* O **webdavd** cuida apenas do Compartilhamento de Pastas.
* *Instale ambos para ter a melhor experiência.*
___

### Links Úteis

  * Site Oficial SPICE: [spice-space.org](https://www.spice-space.org/)
  * Documentação KVM/Hyper-V: [libvirt.org](https://libvirt.org/formatdomain.html#elementsFeatures)
___
