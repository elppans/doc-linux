# Linux, teclas especiais via comando
>A explicação completa está na nota [Ubuntu, bloquear teclas caps-lock](ubuntu_bloquear_tecla_caps-lock.md).

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
>Há um .sh já preparado pra usar. Basta baixar e executar: [nocaps.sh](https://raw.githubusercontent.com/elppans/customshell/refs/heads/master/nocaps.sh).

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
