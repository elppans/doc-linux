# Identificação de Teclas no Linux

Para descobrir os nomes das teclas, pode usar os seguintes métodos:

1. **Comando `xev` no Linux:**
   - Abra um terminal.
   - Digite `xev` e pressione Enter.
   - Uma janela em branco aparecerá.
   - Pressione a tecla que você deseja identificar.
   - No terminal, você verá informações detalhadas sobre a tecla, incluindo o nome da tecla (como "Super" para a tecla do Windows).

2. **Comando `xmodmap` no Linux:**
   - Abra um terminal.
   - Digite `xmodmap -pke` e pressione Enter.
   - Isso exibirá uma lista de todas as teclas e seus códigos.
   - Procure o código da tecla que você deseja usar (por exemplo, o código para a tecla "Super").
   - Anote o nome da tecla correspondente.

3. **Pesquisa online:**
   - Você também pode pesquisar online para encontrar os nomes das teclas específicas. Por exemplo, pesquise "Linux key names" ou "Windows key names" para obter informações detalhadas.
___
## Pacotes

Para usar estes comandos, é nencessário instalar os pacotes `xorg-xev` e `xorg-xmodmap` no ArchLinux e seus derivados (Veja em sua Distro).  
___
Os nomes das teclas podem variar dependendo do sistema operacional e do layout do teclado.
