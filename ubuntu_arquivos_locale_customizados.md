# Arquivos "locale" customizados

Atualizações do Ubuntu **podem sobrescrever** arquivos como `/etc/locale.alias` e `/etc/locale.gen`, especialmente em upgrades de distribuição ou reconfigurações automáticas do sistema.
___

## Estratégias para evitar perder a configuração:

- **1. Crie um arquivo `.dpkg-divert` para proteger alterações**

Use o `dpkg-divert` para que o sistema não sobrescreva seus arquivos durante atualizações:

```bash
sudo dpkg-divert --add --rename --divert /etc/locale.alias.real /etc/locale.alias
```

Depois edite o arquivo `/etc/locale.alias.real` como o original, e configure `/etc/locale.alias` como um link simbólico para ele, ou mantenha separado. O `dpkg` respeitará sua modificação.

Repita o processo, se necessário, para o `/etc/locale.gen`.

- **2. Use um script pós-boot ou post-install**

Crie um script em `/etc/local.d/` ou use o `systemd` (via `systemd-tmpfiles` ou uma `unit`) para reaplicar suas modificações sempre que o sistema iniciar ou após atualizações de pacotes relevantes.

- **3. Documente e monitore com git**

Você pode iniciar um repositório Git simples em `/etc`:

```bash
cd /etc
sudo git init
sudo git add locale.alias locale.gen
sudo git commit -m "Configuração inicial com ISO-8859-1"
```

Desta forma, sempre que tiver dúvida se algo mudou, use o comando `git diff` para mostrar. Se necessário pode restaurar

---
### Sobre o arquivo `.dpkg-divert`

Boa pergunta, Marcelo — mas na verdade, você **não precisa criar manualmente** um arquivo com o nome `.dpkg-divert`. O comando `dpkg-divert` **não cria um arquivo**, ele registra no sistema de empacotamento (`dpkg`) que determinado arquivo foi “desviado” para outro caminho, para que o sistema respeite sua versão personalizada nas atualizações.

Explicando o que acontece com este comando:

```bash
sudo dpkg-divert --add --rename --divert /etc/locale.alias.real /etc/locale.alias
```

Ele faz três coisas:

1. **Cria uma regra de desvio**: informa ao `dpkg` que qualquer atualização que tente sobrescrever `/etc/locale.alias` deve, na verdade, alterar `/etc/locale.alias.real`.
2. **Renomeia o arquivo original** (`/etc/locale.alias`) para `/etc/locale.alias.real`.
3. **Deixa você livre** para criar seu próprio `/etc/locale.alias` customizado, sem medo de ele ser sobrescrito por atualizações futuras.

Depois disso, você pode editar `/etc/locale.alias` à vontade, que sua versão não será sobrescrita automaticamente. O mesmo raciocínio vale para o `/etc/locale.gen`, se quiser proteger ele também.

Claro, Marcelo! Aqui vai uma sequência prática para aplicar o `dpkg-divert` nos dois arquivos — `/etc/locale.alias` e `/etc/locale.gen` — com backup automático e segurança para futuras atualizações do sistema:

#### Etapas para proteger os arquivos com `dpkg-divert`

- 1. Desviar e renomear o locale.alias
```bash
sudo dpkg-divert --add --rename --divert /etc/locale.alias.real /etc/locale.alias
```

- 2. Crie uma nova versão customizada do arquivo
```bash
sudo cp /etc/locale.alias.real /etc/locale.alias
```
```bash
sudo nano /etc/locale.alias   # Edite aqui conforme sua configuração ISO-8859-1
```

- 3. Repitindo o processo para locale.gen
```bash
sudo dpkg-divert --add --rename --divert /etc/locale.gen.real /etc/locale.gen
```

- 4. Crie a versão customizada do arquivo
```bash
sudo cp /etc/locale.gen.real /etc/locale.gen
```
```bash
sudo nano /etc/locale.gen     # Edite e descomente a linha: pt_BR ISO-8859-1
```

- 5. Regerar os locales (uma vez após ajuste)
```bash
sudo locale-gen
```

- ***Dica opcional para identificar mudanças***

Você pode rodar `ls -l /etc/locale*` depois, e verá:

- `/etc/locale.alias → versão editada por você`
- `/etc/locale.alias.real → o original, guardado`
- E o mesmo para `locale.gen`

#### Se mais tarde quiser reverter

Se um dia quiser voltar atrás e **desfazer o desvio com `dpkg-divert`**, o processo é simples.

**Revertendo `dpkg-divert` para os arquivos `/etc/locale.alias` e `/etc/locale.gen`**


- 1. Remover o desvio do locale.alias
```bash
sudo dpkg-divert --remove --rename --divert /etc/locale.alias.real /etc/locale.alias
```

- 2. Se quiser, restaure o original (opcional)
```bash
sudo mv /etc/locale.alias /etc/locale.alias.custom
```
```bash
sudo mv /etc/locale.alias.real /etc/locale.alias
```

- 3. Agora o arquivo voltou ao controle do sistema

- 4. Repita para locale.gen
```bash
sudo dpkg-divert --remove --rename --divert /etc/locale.gen.real /etc/locale.gen
```
```bash
sudo mv /etc/locale.gen /etc/locale.gen.custom
```
```bash
sudo mv /etc/locale.gen.real /etc/locale.gen
```

> **Dica:** Guarde seus arquivos `.custom` se quiser manter a versão personalizada separada, para comparar ou reaplicar depois.
___

### Sobre o monitoramento com Git

Se usar Git pra versionar arquivos como `/etc/locale.alias` e `/etc/locale.gen`, restaurar qualquer modificação é simples.

- Verificando o que mudou

Pra ver o que foi alterado em relação ao último commit:

```bash
sudo git -C /etc diff
```

- Restaurar um arquivo para a versão anterior

Se quiser desfazer alterações em um arquivo específico (por exemplo, `locale.gen`):

```bash
sudo git -C /etc checkout -- locale.gen
```

> Isso traz o arquivo de volta para o estado do último commit.

- Restaurar todos os arquivos rastreados

Se quiser restaurar tudo que mudou desde o último commit:

```bash
sudo git -C /etc checkout -- .
```

Se quiser também pode criar *checkpoints* periódicos com:

```bash
sudo git -C /etc commit -am "Checkpoint de segurança - antes de atualização"
```

Desta forma, consegue voltar no tempo sempre que precisar.
___

### Escolhendo uma das opções

Os três esquemas são **alternativas complementares**, mas independentes — você pode usar só o que achar mais prático ou alinhado com o seu estilo de administração do sistema.

- Quer algo que **blinde de forma técnica** contra atualizações? Vai de `dpkg-divert`.
- Prefere algo mais **flexível e reaplicável**, como um script pós-boot? Também funciona bem.
- Gosta de ter **rastreamento e histórico claro** das mudanças? Git no `/etc` te dá isso.

Aliás, nada impede que você combine dois métodos, tipo `dpkg-divert` + Git, só por segurança extra. Mas sim, **um só já resolve bem o problema**.
