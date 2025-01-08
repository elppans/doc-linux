# Ubuntu 16.04, bloquear a tecla Caps Lock

Para desativar a tecla Caps Lock no Ubuntu 16.04, você pode usar o comando `xmodmap` ou o `setxkbmap`. Aqui estão os passos para ambos os métodos:

### Usando `xmodmap`:
1. Abra um terminal.
2. Digite o seguinte comando para desativar a tecla Caps Lock:
   ```bash
   xmodmap -e "remove lock = Caps_Lock"
   ```
3. Para garantir que a tecla não funcione, você também pode mapear a tecla Caps Lock para uma tecla inofensiva, como Escape:
   ```bash
   xmodmap -e "keycode 66 = Escape"
   ```

Para tornar essas alterações permanentes, adicione os comandos ao seu arquivo de inicialização, como `~/.bashrc` ou `~/.profile`:

```bash
echo 'xmodmap -e "remove lock = Caps_Lock"' >> ~/.bashrc
echo 'xmodmap -e "keycode 66 = Escape"' >> ~/.bashrc
```

Reinicie o computador ou execute o comando `source ~/.bashrc` para aplicar as mudanças.

### Usando `setxkbmap`:
1. Abra um terminal.
2. Digite o seguinte comando:
   ```bash
   setxkbmap -option ctrl:nocaps
   ```
3. Para reverter essa alteração, use:
   ```bash
   setxkbmap -option
   ```

Ambos os métodos devem desativar a tecla Caps Lock no seu sistema Ubuntu 16.04. 
___

# Usar keycode não existente pra mapear o Caps Lock

Você pode mapear a tecla Caps Lock para um keycode não existente, efetivamente desativando-a. Aqui está como fazer isso:

1. Abra um terminal.
2. Digite o seguinte comando para mapear a tecla Caps Lock para um keycode não existente, como `255`:
   ```bash
   xmodmap -e "keycode 66 = NoSymbol"
   ```

Para tornar essa alteração permanente, adicione o comando ao seu arquivo de inicialização, como `~/.bashrc` ou `~/.profile`:

```bash
echo 'xmodmap -e "keycode 66 = NoSymbol"' >> ~/.bashrc
```

Reinicie o computador ou execute o comando `source ~/.bashrc` para aplicar as mudanças.

Isso deve garantir que a tecla Caps Lock esteja completamente desativada e ninguém consiga usá-la.
