# Verificar Status do Ubuntu Pro
>Antes de prosseguir, leia ["Por que Ubuntu PRO?"](https://ubuntu.com/pro/why-pro).

Para verificar se o **Ubuntu Pro** está ativo e quais serviços estão habilitados na sua máquina, o método mais direto é utilizar a própria ferramenta de linha de comando do cliente `pro` (anteriormente conhecido como `ua`).

Aqui estão as formas de confirmar o status:

### 1. Via Terminal (Recomendado)
Abra o terminal e execute o seguinte comando:

```bash
pro status
```

* **Se estiver ativo:** Você verá uma mensagem indicando `SERVICE ENTITLEMENT STATUS`, listando serviços como `esm-apps` e `esm-infra` como **enabled** (ativado). No topo, aparecerá o status do suporte como `attached` (vinculado).
* **Se não estiver ativo:** O comando informará que a máquina não está vinculada a uma assinatura (`This machine is not attached to an Ubuntu Pro subscription`).

---

### 2. Verificação Detalhada
Se você deseja ver exatamente quais atualizações de segurança o Ubuntu Pro está cobrindo no momento, use:

```bash
pro status --wait
```
Isso garante que o sistema verifique o status mais recente junto aos servidores da Canonical.

---

### 3. Via Interface Gráfica (Desktop)
Se você estiver usando a versão Desktop do Ubuntu:

1.  Abra o menu de aplicativos e procure por **Programas e Atualizações** (Software & Updates).
2.  Clique na aba **Ubuntu Pro**.
3.  Lá, o sistema mostrará se a assinatura está ativa e quais camadas de segurança (ESM) estão sendo aplicadas.

---

### Dica de Segurança
Caso o comando `pro` não seja reconhecido, você pode estar em uma versão muito antiga do Ubuntu. Certifique-se de que o pacote `ubuntu-advantage-tools` esteja atualizado:

```bash
sudo apt update && sudo apt install ubuntu-advantage-tools
```
___

# Ativar o Ubuntu PRO via Terminal e Desktop

Para ativar o **Ubuntu Pro**, você precisará de um **token**, que pode ser obtido gratuitamente para uso pessoal (até 5 máquinas) no site oficial da [Canonical](https://ubuntu.com/pro).

Aqui está o passo a passo para as duas modalidades:

---

## 1. Ativação via Linha de Comando (Terminal)

Este método é o mais comum para servidores ou para quem prefere rapidez.

1.  **Atualize o cliente de vantagens:**
    Certifique-se de que a ferramenta de gerenciamento está na versão mais recente:
    ```bash
    sudo apt update && sudo apt install ubuntu-advantage-tools
    ```

2.  **Vincule o Token:**
    Substitua `SEU_TOKEN_AQUI` pela sequência de caracteres que você copiou do painel do Ubuntu Pro:
    ```bash
    sudo pro attach SEU_TOKEN_AQUI
    ```

3.  **Verifique o status:**
    Após o comando processar, confirme se os serviços (como `esm-infra`) estão habilitados:
    ```bash
    pro status
    ```

---

## 2. Ativação via Interface Gráfica (Desktop)

Se você estiver usando a versão com interface visual, o processo é intuitivo:

1.  Abra o menu de aplicativos e procure por **Programas e Atualizações** (*Software & Updates*).
2.  Clique na aba **Ubuntu Pro**.
3.  Clique no botão **Enable Ubuntu Pro** (ou Ativar Ubuntu Pro).
4.  O sistema oferecerá duas opções:
    * **Usar código de suporte:** Ele gerará um código curto (ex: `A1B2C3`) para você inserir em [ubuntu.com/pro/attach](https://ubuntu.com/pro/attach).
    * **Inserir Token manualmente:** Onde você cola o token longo diretamente.
5.  Após a validação, você poderá escolher quais serviços deseja manter ativos (como o Suporte de Segurança Estendido).

---

## Benefícios Imediatos
Ao ativar o Ubuntu Pro, seu sistema passa a ter acesso a:
* **ESM-Infra:** Atualizações de segurança para o "core" do sistema por até 10 anos. Link recomendado: [Ciclo de Lançamentos](https://ubuntu.com/about/release-cycle).
* **ESM-Apps:** Correções de segurança para mais de 30.000 pacotes de código aberto (como Python, Node.js, Go).
* **Livepatch:** Permite aplicar atualizações críticas no Kernel sem precisar reiniciar a máquina.
___

# Configurar o Livepatch para que o sistema não precise reiniciar após atualizações do Kernel

O **Livepatch** é um dos recursos mais práticos do Ubuntu Pro, pois ele aplica correções críticas de segurança no Kernel enquanto o sistema está rodando, eliminando a necessidade de reiniciar o servidor ou o desktop imediatamente.

Aqui está como configurar e gerenciar o Livepatch:

---

### 1. Habilitando via Linha de Comando
Se você já vinculou o seu token com o comando `pro attach`, o Livepatch geralmente é ativado por padrão. Para garantir que ele esteja rodando, execute:

```bash
sudo pro enable livepatch
```

### 2. Verificando o Status do Livepatch
Para saber se existem patches aplicados e qual a versão do Kernel atual, use:

```bash
canonical-livepatch status
```
* **State:** `nothing-to-apply` (sistema atualizado) ou `applied` (correção aplicada com sucesso).
* **Check interval:** O tempo padrão em que o sistema busca novas atualizações.

---

### 3. Configuração via Interface Gráfica (Desktop)
1.  Abra **Programas e Atualizações** (*Software & Updates*).
2.  Vá até a aba **Livepatch**.
3.  Verifique se a chave está na posição **On** (Ligado).
4.  Você verá um ícone de "escudo" na sua barra de tarefas que indica quando o sistema foi protegido silenciosamente.

---

### Comandos Úteis de Manutenção
Caso precise forçar uma verificação manual por novas correções:
```bash
sudo canonical-livepatch refresh
```

Se quiser ver um relatório detalhado de quais vulnerabilidades (CVEs) foram corrigidas no seu Kernel atual:
```bash
canonical-livepatch status --verbose
```

---

### Diferença Importante
Vale lembrar que o Livepatch corrige falhas críticas de segurança, mas **não substitui** a atualização regular do Kernel via `apt upgrade`. Eventualmente, você ainda precisará reiniciar para carregar um novo Kernel completo, mas o Livepatch permite que você faça isso no seu tempo, sem pressa por causa de vulnerabilidades abertas.
___
