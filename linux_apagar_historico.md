# Limpar histórico de comandos no Linux

Para limpar o histórico de comandos no Ubuntu Linux (ou em qualquer sistema baseado em Linux usando o Bash ou Zsh, por exemplo), você pode usar os seguintes métodos, dependendo do que exatamente deseja limpar.

---

### 🧹 **1. Limpar o histórico atual da sessão do Bash**

```bash
history -c
```

> Isso limpa o histórico **apenas da sessão atual** do terminal.

---

### 🧹 **2. Limpar o arquivo `.bash_history` no disco**

Esse arquivo armazena os comandos de sessões anteriores.

```bash
cat /dev/null > ~/.bash_history
```

ou

```bash
> ~/.bash_history
```

> Isso limpa o conteúdo do arquivo `~/.bash_history`.

---

### 🔁 **3. Garantir que o histórico não seja salvo ao sair da sessão**

Depois de limpar o histórico com `history -c`, você pode impedir que ele seja salvo:

```bash
unset HISTFILE
```

---

### 💡 **4. Remover uma linha específica do histórico**

Se quiser remover apenas um comando específico:

```bash
history -d <número da linha>
```

Você pode ver os números com:

```bash
history
```

---

### ⚙️ **5. (Opcional) Tornar isso automático no logout**

Você pode editar seu `.bash_logout` para limpar o histórico automaticamente ao sair do terminal:

```bash
nano ~/.bash_logout
```

Adicione:

```bash
history -c
> ~/.bash_history
```

---

Se estiver usando **Zsh**, substitua `.bash_history` por `.zsh_history` e use `fc -R` ou `fc -p` para gerenciar o histórico.
___

## Limpar o histórico de um usuário específico

Para limpar o histórico de um **usuário específico** no Ubuntu (ou outra distro Linux), você precisa acessar e apagar os arquivos de histórico daquele usuário.  

---

### ✅ **1. Acesse como root ou com sudo**

Você precisa ter permissões administrativas para limpar o histórico de outro usuário:

```bash
sudo -i
```

ou prefixar os comandos com `sudo`.

---

### ✅ **2. Localize o arquivo de histórico do usuário**

O histórico de comandos geralmente está em:

* Para Bash: `/home/USUARIO/.bash_history`
* Para Zsh: `/home/USUARIO/.zsh_history`

Substitua `USUARIO` pelo nome do usuário desejado.

---

### 🧹 **3. Limpe o histórico**

#### Apagar o conteúdo do arquivo:

```bash
> /home/USUARIO/.bash_history
```

ou

```bash
> /home/USUARIO/.zsh_history
```

---

### 🔒 **4. (Opcional) Alterar permissões para impedir que ele seja recriado**

Se você quiser impedir o uso de histórico (não recomendado na maioria dos casos), pode:

```bash
chattr +i /home/USUARIO/.bash_history
```

> Isso torna o arquivo **imutável** — ele não pode ser modificado ou regravado até que a flag seja removida:

```bash
chattr -i /home/USUARIO/.bash_history
```

---

### 🔁 **5. (Opcional) Criar um script para isso**

```bash
#!/bin/bash
USUARIO="nome_do_usuario"
> /home/$USUARIO/.bash_history
chown $USUARIO:$USUARIO /home/$USUARIO/.bash_history
```

Salve como `limpar-historico.sh`, torne executável:

```bash
chmod +x limpar-historico.sh
```

Execute como root:

```bash
sudo ./limpar-historico.sh
```

---
