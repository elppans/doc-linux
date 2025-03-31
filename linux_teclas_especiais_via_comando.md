# Linux, teclas especiais via comando

- **Instalar pacotes:**

Ubuntu:
```bash
sudo apt-get install numlockx xdotool
```
- **Ativar o Teclado numérico**

```bash
numlockx on
```
- **Blockear/Remover o Caps Lock**
```bash
setxkbmap -option ctrl:nocaps
```
```bash
xmodmap -e "remove lock = Caps_Lock"
```
```bash
xmodmap -e "keycode 66 = NoSymbol"
```
___

- Ativar/Desativar o Caps Lock
```bash
xdotool key Caps_Lock
```
- Ativar o Scroll Lock
```bash
xset led 3
```
