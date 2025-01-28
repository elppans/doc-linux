# Inverter ou girar o monitor com o comando xrandr

O comando `xrandr` pode ser usado para inverter ou girar a orientação do monitor no Linux. Aqui estão as instruções para isso:

1. **Exiba as telas disponíveis:**
   Primeiro, descubra os nomes das telas conectadas ao sistema:
   ```bash
   xrandr
   ```

   Isso retornará uma lista de saídas, como `HDMI-1`, `DP-1`, `eDP-1` (geralmente o monitor embutido de laptops).

2. **Gire a tela:**
   Use a opção `--rotate` com o nome da tela que você deseja girar. Os valores possíveis para rotação são:
   - `normal`: Orientação padrão.
   - `left`: Rotaciona 90° para a esquerda.
   - `right`: Rotaciona 90° para a direita.
   - `inverted`: Rotaciona 180° (de cabeça para baixo).

   Exemplos:
   - Girar a tela `HDMI-1` para a esquerda:
     ```bash
     xrandr --output HDMI-1 --rotate left
     ```
   - Retornar a tela para a orientação normal:
     ```bash
     xrandr --output HDMI-1 --rotate normal
     ```

3. **Inverter a tela:**
   Para inverter a tela, use `--rotate inverted`. Exemplo:
   ```bash
   xrandr --output HDMI-1 --rotate inverted
   ```

4. **Corrigir a resolução:**
   Em algumas situações, a resolução pode não ser ajustada automaticamente após a rotação. Você pode corrigir isso adicionando o argumento `--mode` para definir uma resolução específica:
   ```bash
   xrandr --output HDMI-1 --mode 1920x1080 --rotate left
   ```

### Nota
- Alterações feitas com `xrandr` são temporárias. Elas serão revertidas ao reiniciar o sistema.
- Para tornar as mudanças permanentes, edite o arquivo de configuração do servidor X (`/etc/X11/xorg.conf`) ou crie scripts de inicialização personalizados.
___
## xrandr, orientação por valor

>O que significa o comando, como exemplo, `xrandr -o 3`?

O comando `xrandr -o 3` utiliza a opção `-o` (abreviação de `--orientation`) para definir a orientação geral da tela. O argumento `3` representa uma das orientações possíveis. Os valores permitidos e seus significados são:

- `0`: Orientação normal.
- `1`: Rotação de 90° (esquerda).
- `2`: Rotação de 180° (inversão total).
- `3`: Rotação de 270° (direita).

### O que o comando faz?
No caso de `xrandr -o 3`, ele gira a tela 270° no sentido horário, colocando a tela de lado, com o topo virado para a esquerda.

### Exemplo:
Se você usar o comando:
```bash
xrandr -o 3
```
A tela será rotacionada 270° no sentido horário. Esse comando afeta todas as saídas conectadas, ao contrário de `--output`, que permite especificar uma saída específica.

### Observação:
- Como as alterações feitas com `xrandr` são temporárias, a orientação será revertida após reiniciar o sistema.
- Nem todas as configurações ou drivers de vídeo suportam a rotação. Se o comando não funcionar, pode ser necessário verificar o suporte ao driver de vídeo ou as configurações do Xorg.
___
