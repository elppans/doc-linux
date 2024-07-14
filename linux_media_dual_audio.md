# Configuração de um arquivo de vídeo "dual", dá pra configurar o codec de som diferente para cada lingua

É possível configurar codecs de som diferentes para cada idioma em um arquivo de vídeo "dual". Isso é feito ao criar múltiplas faixas de áudio dentro do mesmo arquivo de vídeo, cada uma codificada com um codec diferente, se necessário. Por exemplo, você pode ter uma faixa de áudio em inglês usando o codec AAC e outra faixa em português usando o codec MP3.

Para fazer isso, você pode usar ferramentas de edição de vídeo como o FFmpeg, que permite especificar codecs diferentes para cada faixa de áudio. Aqui está um exemplo de como você pode fazer isso com o FFmpeg:

```bash
ffmpeg -i input_video.mp4 -i english_audio.aac -i portuguese_audio.mp3 -map 0:v -map 1:a -map 2:a -c:v copy -c:a:0 aac -c:a:1 mp3 output_video.mp4
```

Neste comando:
- `-i input_video.mp4` é o arquivo de vídeo original.
- `-i english_audio.aac` é a faixa de áudio em inglês.
- `-i portuguese_audio.mp3` é a faixa de áudio em português.
- `-map 0:v` mapeia o vídeo do arquivo original.
- `-map 1:a` mapeia a primeira faixa de áudio (inglês).
- `-map 2:a` mapeia a segunda faixa de áudio (português).
- `-c:v copy` copia o vídeo sem recodificar.
- `-c:a:0 aac` define o codec AAC para a primeira faixa de áudio.
- `-c:a:1 mp3` define o codec MP3 para a segunda faixa de áudio.
___

## Comando para saber as informações do vídeo, no Linux

Para obter informações detalhadas sobre um arquivo de vídeo no Linux, você pode usar o comando `mediainfo` ou `ffprobe`. Aqui estão exemplos de como usar cada um:

### Usando `mediainfo`
Primeiro, instale o `mediainfo` se ainda não tiver:
```bash
sudo apt install mediainfo
```
Depois, execute o comando para obter informações sobre o vídeo:
```bash
mediainfo nome_do_video.mp4
```

### Usando `ffprobe`
Primeiro, instale o `ffprobe` (parte do pacote `ffmpeg`) se ainda não tiver:
```bash
sudo apt install ffmpeg
```
Depois, execute o comando para obter informações sobre o vídeo:
```bash
ffprobe -v error -show_format -show_streams nome_do_video.mp4
```

Esses comandos fornecerão detalhes como formato, duração, bitrate, codecs de áudio e vídeo, etc.
___

## Saber somente sobre quais codec de audio o vídeo está usando

Para obter informações específicas sobre os codecs de áudio usados em um vídeo no Linux, você pode usar o `mediainfo` ou o `ffprobe`. Aqui estão os comandos para cada ferramenta:

### Usando `mediainfo`
```bash
mediainfo --Inform="Audio;%CodecID%" nome_do_video.mp4
```

### Usando `ffprobe`
```bash
ffprobe -v error -select_streams a:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 nome_do_video.mp4
```

Esses comandos retornarão apenas o codec de áudio utilizado no vídeo.
___

## Em um arquivo DUAL, tenho que saber qual o codec de cada linguagem

Para identificar os codecs de áudio de cada faixa em um arquivo de vídeo "dual", você pode usar o `ffprobe` para listar todas as faixas de áudio e seus respectivos codecs. Aqui está como fazer isso:

### Usando `ffprobe`
```bash
ffprobe -v error -select_streams a -show_entries stream=index,codec_name -of default=noprint_wrappers=1:nokey=1 nome_do_video.mp4
```

Este comando listará todas as faixas de áudio e os codecs correspondentes. O resultado será algo assim:
```
0: aac
1: mp3
```

Neste exemplo, a faixa de áudio 0 usa o codec AAC e a faixa de áudio 1 usa o codec MP3.
___

## Se eu quiser saber qual lingua tá usando o codec?

Para identificar o idioma associado a cada faixa de áudio e seu respectivo codec em um arquivo de vídeo "dual", você pode usar o `ffprobe` para obter essas informações detalhadas. Aqui está o comando:

### Usando `ffprobe`
```bash
ffprobe -v error -select_streams a -show_entries stream=index,codec_name:stream_tags=language -of default=noprint_wrappers=1 nome_do_video.mp4
```

Este comando listará todas as faixas de áudio, os codecs e os idiomas correspondentes. O resultado será algo assim:
```
0: aac: eng
1: mp3: por
```

Neste exemplo, a faixa de áudio 0 usa o codec AAC e está em inglês (eng), enquanto a faixa de áudio 1 usa o codec MP3 e está em português (por).

### Usando `mediainfo`
O `mediainfo`, pode fornecer informações detalhadas sobre os codecs e idiomas das faixas de áudio:

```bash
mediainfo "2022 Animais Fantasticos Os Segredos de Dumbledore 1080p WEB-DL DUAL 5.1.mkv"
```

Isso deve listar todas as faixas de áudio com seus respectivos codecs e idiomas.
