# Funcionamento do LED ARGB no Linux

Este tutorial apresenta métodos para ativar e configurar o LED do teclado no Linux. Exploramos soluções via terminal, opções nativas de interface gráfica e como automatizar a ativação do LED ao iniciar o sistema.

---

## 1. Modificar valores das teclas no arquivo de configuração do teclado

### Passo a passo:
1. Edite o arquivo `/usr/share/X11/xkb/symbols/pc`.
2. Encontre (ou adicione) a linha `modifier_map Mod3`. A linha deve ficar assim:
   ```
   modifier_map Mod3   { Scroll_Lock };
   ```
3. Adicione esta linha dentro da seção `xkb_symbols "pc105" { ... }`.

---

## 2. Ligando o LED do teclado com o Brightnessctl

O **Brightnessctl** é uma ferramenta de linha de comando que permite ajustar o brilho no Linux.

### Instalação:
- **Ubuntu/Debian**:  
  ```bash
  sudo apt update && sudo apt install brightnessctl
  ```
- **Fedora**:  
  ```bash
  sudo dnf install brightnessctl
  ```
- **Arch Linux**:  
  ```bash
  sudo pacman -S brightnessctl
  ```

### Métodos de uso:

**Método 1:**
1. Liste os dispositivos de brilho disponíveis:  
   ```bash
   brightnessctl -l
   ```
2. Identifique o número do input do `Scroll Lock`.
3. Ajuste o brilho com o comando:  
   ```bash
   brightnessctl --device='inputX::scrolllock' set 1
   ```
   Substitua `X` pelo número do input identificado.

**Método 2:**  
Ative o LED diretamente:  
```bash
xset led named "Scroll Lock"
```

**Método 3:**  
1. Liste os dispositivos de brilho:  
   ```bash
   brightnessctl -l
   ```
2. Ajuste o LED com o comando:  
   ```bash
   echo 1 | sudo tee /sys/class/leds/inputX::scrolllock/brightness
   ```

---

## 3. Automatizando a ativação do LED ao iniciar o sistema

### Criando um serviço systemd:
1. **Crie o arquivo de serviço**:  
   ```bash
   sudo nano /etc/systemd/system/scrolllock-led.service
   ```

2. **Adicione o seguinte conteúdo**:
   ```ini
   [Unit]
   Description=Ativar LED do teclado
   After=multi-user.target

   [Service]
   Type=oneshot
   ExecStart=/bin/bash -c "echo 1 | sudo tee /sys/class/leds/$(ls /sys/class/leds | grep scrolllock)/brightness"
   RemainAfterExit=true

   [Install]
   WantedBy=multi-user.target
   ```

3. **Salve o arquivo e ative o serviço**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable scrolllock-led.service
   sudo systemctl start scrolllock-led.service
   ```

Com isso, o LED será ativado automaticamente toda vez que o sistema for inicializado, sem depender de apertar a tecla *Scroll Lock*.

---

## 4. Configuração via GUI no Plasma (KDE)

1. Acesse as **Configurações do Plasma**.
2. Vá até **Teclado**.
3. Clique em **Combinação de teclas**.
4. Ative a opção **Configurar as opções de teclado**.
5. Acesse **Opções de compatibilidade** e habilite:  
   **Mapear Scroll Lock para Mod3**.

---

## Fontes

- [Discussão no fórum Diolinux](https://plus.diolinux.com.br/t/problema-com-iluminacao-do-teclado-tgt-m16l-rainbow-no-fedora-scroll-lock-controla-led/71719/5)  
- [Pergunta no Ask Ubuntu](https://askubuntu.com/questions/127167/how-do-i-enable-scroll-lock/1413248#1413248)  
- [Artigo no Medium](https://wendellast2a.medium.com/como-ligar-o-led-do-teclado-no-linux-0d3acd66d053)  

---


