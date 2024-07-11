# No Linux via terminal, usar imagens jpg para criar um gif

Você pode criar um GIF animado a partir de três imagens JPG no Linux usando o utilitário **ImageMagick**. 
Aqui estão as etapas:

1. **Instale o ImageMagick** (caso ainda não esteja instalado):
   Execute o seguinte comando no terminal (No Archlinux, ouras Distros, veja a documentação):
   
   ```
   sudo pacman -Syu imagemagick
   ```

2. **Redimensione as imagens** (opcional, mas recomendado para manter o tamanho consistente):
   Se você deseja redimensionar as imagens para o mesmo tamanho (por exemplo, 800x600), use o seguinte comando:
   ```
   mogrify -resize 8000x600 *.jpg
   ```

3. **Crie o GIF**:
   Agora, para criar o GIF a partir das imagens, use o seguinte comando:
   ```
   convert -delay 1000 -loop 0 *.jpg myimage.gif
   ```
   - O parâmetro `-delay 1000` define o tempo de atraso entre os quadros (em centésimos de segundo).
   - O parâmetro `-loop 0` faz com que o GIF seja reproduzido indefinidamente.

Isso criará um arquivo chamado `myimage.gif` com as três imagens.

