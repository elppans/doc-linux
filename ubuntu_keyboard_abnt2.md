# Configurar teclado ABNT2 no Ubuntu (CLI)

**- Método setxkbmap**

Para configurar o teclado no padrão ABNT2 no Ubuntu, você pode usar o seguinte comando no terminal:

```
setxkbmap -model abnt2 -layout br
```

Isso deve resolver o problema caso você não esteja conseguindo digitar cedilha (ç), palavras acentuadas com acento circunflexo (^), crase (`) e acento agudo (á, é, í, ó, ú). 
Se estiver usando um notebook com teclado padrão inglês americano, configure-o como "Inglês (Mali, EUA, Internacional)". 

**- Método dpkg-reconfigure**

Além do comando que mencionei anteriormente, você também pode configurar o teclado ABNT2 no Ubuntu editando o arquivo de configuração diretamente. 
Siga estas etapas:

1. Abra um terminal.
2. Digite o seguinte comando para editar o arquivo de configuração do teclado:

```bash
sudo nano /etc/default/keyboard
```

3. No arquivo que se abre, localize a linha que começa com `XKBLAYOUT` e altere o valor para `"br"` (sem as aspas).
4. Salve o arquivo e saia do editor.
5. Reinicie o computador ou execute o seguinte comando para aplicar as alterações:

```bash
sudo dpkg-reconfigure keyboard-configuration
```

Isso deve definir o layout do teclado como ABNT2. Se você preferir usar uma interface gráfica, pode ir até as configurações do sistema e procurar a opção de layout de teclado para fazer a alteração.

**- Recarregar a configuração sem reiniciar**

Você pode recarregar a configuração do teclado sem reiniciar o computador. Após editar o arquivo "/etc/default/keyboard", execute o seguinte comando para aplicar as alterações:

```bash
sudo service keyboard-setup restart
```

Isso deve recarregar a configuração do teclado e aplicar o layout ABNT2 sem a necessidade de reiniciar.

**- Automatizar dpkg-reconfigure**

É possível automatizar o processo de `dpkg-reconfigure keyboard-configuration` para que ele não solicite confirmação manual. Você pode usar o seguinte comando:

```bash
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
```

Ao adicionar `DEBIAN_FRONTEND=noninteractive`, o comando será executado automaticamente sem interrupções para confirmação.
Um 2º modo para a execução do comando, é usando a opão `-f noninteractive`, que é o mesmo que usar a variável:

```
sudo dpkg-reconfigure -f noninteractive keyboard-configuration
```

**- Validação da configuração**

Para verificar se o layout do teclado foi configurado corretamente no Ubuntu, você pode usar um dos seguintes métodos:

1. **Verificação via Terminal:**
   
   - Abra um terminal.
   
   - Execute o seguinte comando para exibir o status do layout do teclado:
     
     ```bash
     localectl status
     ```
   
   - Isso mostrará informações sobre o layout atual, como "VC Keymap" e "X11 Layout" .

2. **Verificação nas Configurações do Sistema:**
   
   - Abra as "Configurações do Sistema".
   - Navegue até "Dispositivos de Entrada" na seção "Hardware".
   - Selecione "Teclado".
   - Na guia "Layouts", você verá o layout atualmente configurado.
