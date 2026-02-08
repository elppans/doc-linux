# Descobrir que o Kernel suporta NTSYNC e ativar, se não estiver ativado

Para verificar se o seu kernel no Arch Linux suporta o **NTSYNC** (o driver de sincronização que melhora a performance de jogos via Wine/Proton), você pode seguir estes passos:

### 1. Verifique a existência do dispositivo

A forma mais direta de saber se o driver está ativo e carregado é checar se o arquivo de dispositivo foi criado:

```bash
ls -l /dev/ntsync

```

* **Se aparecer o arquivo:** O suporte está presente e ativo.
* **Se disser "Arquivo ou diretório inexistente":** O driver não está carregado ou não é suportado pelo kernel atual.

---

### 2. Verifique a Configuração do Kernel (`CONFIG_NTSYNC`)

O Arch Linux geralmente disponibiliza a configuração do kernel atual em `/proc/config.gz`. Você pode pesquisar pela flag específica:

```bash
zgrep CONFIG_NTSYNC /proc/config.gz

```

Os resultados possíveis são:

* `CONFIG_NTSYNC=y`: O suporte está embutido no kernel.
* `CONFIG_NTSYNC=m`: O suporte está disponível como um módulo (precisa ser carregado).
* **Sem resposta:** O kernel atual não possui o patch/código do NTSYNC.

---

### 3. Tente carregar o módulo manualmente

Caso o kernel suporte NTSYNC como módulo (`m`), você pode tentar carregá-lo para ver se ele existe:

```bash
sudo modprobe ntsync

```

Se o comando não retornar erros, o módulo foi carregado. Você pode confirmar com `lsmod | grep ntsync`.

---

### Contexto Importante sobre Versões

* **Kernel Mainline:** O NTSYNC foi oficialmente aceito no **Linux 6.13**. Se você estiver em uma versão anterior do kernel oficial do Arch, ele provavelmente não estará lá.
* **Kernels Customizados:** Se você usa o `linux-zen`, `linux-tkg` ou `linux-cachyos`, o suporte ao NTSYNC costuma ser adicionado muito antes da versão oficial via patches.
* **Requisito de Software:** Para que o NTSYNC realmente funcione nos seus jogos, além do kernel, você precisa de uma versão do **Wine-Staging** ou **Proton** (como o Proton-GE) que também suporte essa funcionalidade.

> **Dica:** Para ver a versão exata do seu kernel agora, use o comando `uname -r`.

