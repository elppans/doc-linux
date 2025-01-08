# Ubuntu, Ativar teclas especiais via comando

Para ativar o teclado numérico, o Caps Lock e o Scroll Lock no Ubuntu 16.04, você pode usar o comando `xset`. Aqui está como fazer isso:

### Ativar o Teclado Numérico:
1. Abra um terminal.
2. Instale o pacote `numlockx`
```bash
sudo apt-get install numlockx
```
3. Digite o seguinte comando:
   ```bash
   numlockx on
   ```

### Ativar o Caps Lock:
1. Abra um terminal.
2. Instale o pacote `xdotool`
```bash
sudo apt-get install xdotool
```
3. Digite o seguinte comando:
   ```bash
   xdotool key Caps_Lock
   ```

### Ativar o Scroll Lock:
1. Abra um terminal.
2. Digite o seguinte comando:
   ```bash
   xdotool key Scroll_Lock
   ```

Esses comandos ativarão cada uma dessas teclas conforme necessário. 
___
## Ativar e Desativar Scroll Lock com `xset`

Você pode usar o comando `xset` para ativar e desativar o Scroll Lock

1. Abra um terminal.
2. Digite o seguinte comando:
   ```bash
   xset led 3
   ```

Para desativar o Scroll Lock, use:
```bash
xset -led 3
```

Isso deve funcionar para ativar e desativar o Scroll Lock no Ubuntu.
