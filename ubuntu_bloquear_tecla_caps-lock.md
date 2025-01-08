# Ubuntu 16.04, bloquear a tecla Caps Lock

Para desativar a tecla Caps Lock no Ubuntu 16.04, você pode usar o comando `xmodmap` ou o `setxkbmap`. Aqui estão os passos para ambos os métodos:

### Usando `xmodmap`:
1. Abra um terminal.
2. Digite o seguinte comando:
   ```bash
   xmodmap -e "remove lock = Caps_Lock"
   ```
3. Para tornar essa alteração permanente, adicione o comando ao arquivo de inicialização do seu shell, como `~/.bashrc` ou `~/.profile`:
   ```bash
   echo 'xmodmap -e "remove lock = Caps_Lock"' >> ~/.bashrc
   ```
4. Reinicie o computador ou execute o comando `source ~/.bashrc` para aplicar as mudanças.

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

