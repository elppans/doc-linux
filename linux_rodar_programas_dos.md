# Rodar programas DOS no Linux

Um executável feito para **DOS** não roda nativamente no Linux moderno (como o Ubuntu 22), porque o sistema não tem suporte direto ao ambiente DOS. Mas existem algumas formas de executar esse tipo de programa:

---

## Opções para rodar programas DOS no Linux

### 1. **Usar o DOSBox**
- É um emulador de DOS muito popular e simples.
- Instalação:
  ```bash
  sudo apt update
  sudo apt install dosbox
  ```
- Depois, crie uma pasta para seus programas DOS, por exemplo:
  ```bash
  mkdir ~/dos_programas
  cp seu_programa.exe ~/dos_programas/
  ```
- Rode o DOSBox:
  ```bash
  dosbox
  ```
- Dentro do DOSBox, monte a pasta como um drive:
  ```
  mount c ~/dos_programas
  c:
  seu_programa.exe
  ```

- Essa é a forma mais prática e compatível.

---

### 2. **Usar o DOSEMU**
- Outro emulador de DOS, mais antigo, mas ainda funcional.
- Instalação:
  ```bash
  sudo apt install dosemu
  ```
- Depois basta rodar:
  ```bash
  dosemu seu_programa.exe
  ```

---

### 3. **Máquina Virtual**
- Se o programa exigir um ambiente mais fiel (como drivers específicos), você pode instalar uma VM com FreeDOS.
- Instale o **VirtualBox** ou **QEMU**, crie uma máquina com FreeDOS e rode o executável lá.

---

## Observações
- Se o programa for muito antigo, DOSBox costuma ser a melhor escolha.
- Se for um utilitário simples, DOSEMU pode ser mais rápido.
- Se precisar de máxima compatibilidade, FreeDOS em VM é a solução.

---

## Configurar o DOSBox para que o seu programa DOS abra automaticamente

Configurar o **DOSBox** para que o seu programa DOS abra automaticamente sem precisar digitar comandos toda vez.  

---

## Passo a passo

### 1. Instalar o DOSBox
Se ainda não instalou:
```bash
sudo apt update
sudo apt install dosbox
```

---

### 2. Criar uma pasta para os programas DOS
```bash
mkdir ~/dos_programas
cp ~/Downloads/seu_programa.exe ~/dos_programas/
```

---

### 3. Editar o arquivo de configuração do DOSBox
O DOSBox usa um arquivo chamado `dosbox.conf`. Você pode criar um personalizado:

```bash
dosbox -printconf
```
Esse comando mostra onde está o arquivo de configuração padrão.  
Copie-o para sua pasta pessoal:
```bash
cp $(dosbox -printconf) ~/dosbox.conf
```

---

### 4. Configurar inicialização automática
Abra o arquivo:
```bash
nano ~/dosbox.conf
```

No final do arquivo, procure a seção `[autoexec]` e adicione:
```
mount c ~/dos_programas
c:
seu_programa.exe
exit
```

- `mount c ~/dos_programas` → monta sua pasta como drive C:  
- `c:` → entra no drive  
- `seu_programa.exe` → executa o programa  
- `exit` → fecha o DOSBox quando terminar  

---

### 5. Rodar com sua configuração
Agora basta rodar:
```bash
dosbox -conf ~/dosbox.conf
```

O programa abrirá direto, sem precisar digitar nada.

---

# Programas DOS que precisam receber arquivos como argumentos

No **DOSBox**, você pode passar parâmetros para o executável da mesma forma que faria no DOS original. O detalhe é que o DOSBox só “enxerga” os diretórios que você montou. Então, se o seu `cdmp.exe` está em `~/dos_programas` e o arquivo `.dmp` está em outro lugar, você precisa montar também esse outro diretório.  

---

## Exemplo prático

Suponha:
- `cdmp.exe` está em `~/dos_programas`
- O arquivo `teste.dmp` está em `~/meus_dumps`

### 1. Monte os dois diretórios no DOSBox
Dentro do DOSBox:
```
mount c ~/dos_programas
mount d ~/meus_dumps
```

### 2. Vá para o diretório do programa
```
c:
cdmp.exe d:\teste.dmp
```

Aqui você está dizendo para o `cdmp.exe` usar o arquivo que está no drive `D:` (que corresponde à pasta `~/meus_dumps`).

---

## Dica para automatizar

Se quiser que isso já aconteça automaticamente, edite o `[autoexec]` no seu `dosbox.conf` e coloque:
```
mount c ~/dos_programas
mount d ~/meus_dumps
c:
cdmp.exe d:\teste.dmp
exit
```

Assim, ao abrir o DOSBox, ele já roda o programa com o arquivo `.dmp` indicado.

---

# Passar qualquer arquivo .dmp da linha de comando do Ubuntu (tipo `dosbox -conf ~/dosbox.conf arquivo.dmp`) sem precisar editar o conf toda vez

Rodar o `cdmp.exe` passando qualquer arquivo `.dmp` diretamente da linha de comando do Ubuntu, sem precisar editar o `dosbox.conf` toda vez.  

---

## Como fazer

### 1. Crie um script wrapper
No seu diretório pessoal, crie um arquivo chamado `cdmp.sh`:

```bash
nano ~/cdmp.sh
```

Coloque o seguinte conteúdo:

```bash
#!/bin/bash

# Primeiro argumento é o arquivo .dmp
DMP_FILE="$1"

# Pasta onde está o cdmp.exe
PROG_DIR=~/dos_programas

# Rodar o DOSBox montando o programa e o diretório do arquivo
dosbox -c "mount c $PROG_DIR" -c "mount d $(dirname $DMP_FILE)" -c "c:" -c "cdmp.exe d:\\$(basename $DMP_FILE)" -c "exit"
```

Salve e feche.

---

### 2. Torne o script executável
```bash
chmod +x ~/cdmp.sh
```

---

### 3. Usar o script
Agora você pode rodar assim:
```bash
~/cdmp.sh /caminho/para/arquivo/teste.dmp
```

O script:
- Monta a pasta do programa como `C:`
- Monta a pasta onde está o `.dmp` como `D:`
- Executa `cdmp.exe` passando o arquivo corretamente
- Fecha o DOSBox ao terminar

---

