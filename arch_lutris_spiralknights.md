# Lutris, Spiral Knights

Já faz um tempo que postei esta [matéria](https://forums.lutris.net/t/spiral-knights-libfreetype-so-6-undefined-symbol-solving-and-installing/15344/2?u=elppansmk) no fórum do Lutris, mas vou deixar registrado aqui também.  
Motivos: Lá eu postei em Inglês e aqui vou deixar em PT mesmo e mais completo. Também, como a matéria é minha, posso replicar onde eu quiser sem ter problemas.  

## Sobre o Spiral Knights  

Aqui no Brasil o jogo é pouco conhecido e eu acabei achando por acaso a algum tempo atras e achei sensacional.  
Infelizmente, não tem tradução para PT, mas dá pra configurar Espanhol, que aí dá pra jogar e entender a história de boas. Se entende Inglês, dá pra deixar nele mesmo, pois é o padrão.  

Para ter uma idéia de como é o jogo, assista este trailer da página oficial do jogo:  

[Spiral Knights Steam Launch Trailer](https://www.youtube.com/watch?v=nMpkxrnMtd0&ab_channel=SpiralKnights)


Existem várias formas de se instalar o jogo no Arch, pode-se usar o pacote [spiral-knights *AUR](https://aur.archlinux.org/packages/spiral-knights), por exemplo.  
Também dá pra baixar o jogo direto do [site oficial](https://www.spiralknights.com/) e executar o Script, porém, a fim de se organizar, pode deixar o Lutris gerenciar o jogo.

## Lutris, Spiral Knights

Por algum motivo, o Script original não cria o atalho do jogo corretamente no campo "Executável" do Lutris, então, na página do [Lutris, Spiral Knights](https://lutris.net/games/spiral-knights/) crie um novo Script baseado nele, como "Versão mais recente".
Neste novo Script, deixe configurado desta forma:

```
files:
- file1: http://gamemedia.spiralknights.com/spiral/client/spiral-install.bin
game:
  exe: $GAMEDIR/spiral
  working_dir: $GAMEDIR
installer:
- chmodx: file1
- execute:
    args: --target $GAMEDIR --noexec
    description: Extracting...
    file: file1
    terminal: true
```

Depois de salvar, clique em "Install" e, após finalizar a instalação, verá que o atalho foi criado corretamente, mas **NÃO INICIE o jogo ainda**.  
Para que o jogo funcione, deve instalar o Java na versão 8. Ele só funciona com esta versão do java.  

## Java 8, Spiral Knights

Para que o jogo funcione corretamente, instale o pacote Java versão 8 a partir da sua Distro e crie um atalho na pasta da sua distro:  

> Ps.: Em meu computador, a pasta de jogos do Lutris não fica em seu local padrão, então no lugar do meu endereço, vou deixar apenas a variável, para entender.  

```
sudo pacman -S jre8-openjdk
ln -sf /usr/lib/jvm/java-8-openjdk/jre $GAMEDIR/java
```
No Arch, se você já usa outra versão do Java e quer usar esta versão 8 somente para o jogo, faça o seguinte procecimento:  

1) Faça o comando status para ver as versões do java em seu sistema. Ex.:  

```
archlinux-java status
```

A resposta deverá ser como no meu exemplo:  

>Available Java environments:  
  java-20-openjdk  
  java-8-openjdk/jre (default)  

Então, faça o comando para padronizar o java que quer usar:  

```
sudo archlinux-java set java-20-openjdk
```
Se fizer o comando status novamente, verá que mudou:  

[![spiral-knights-java8-set.png](https://i.postimg.cc/Y9cJ8hk5/spiral-knights-java8-set.png)](https://postimg.cc/4K5Lx4YP)

Após esse ajuste, o jogo funciona normalmente:

[![Spiral-Knights-Lutris-error-09.png](https://i.postimg.cc/8zvR2FcJ/Spiral-Knights-Lutris-error-09.png)](https://postimg.cc/Wd2qr1MT)

## Erros e soluções  

### Falha com Freetype

No Arch eu não recebi este erro, mas na época em que postei a matéria no fórum, eu estava recebendo um erro ao tentar instalar:

[![Spiral-Knights-Lutris-error-01.png](https://i.postimg.cc/yNvvssDC/Spiral-Knights-Lutris-error-01.png)](https://postimg.cc/DW4qcVQx)

Log:

>Started initial process 11711 from /usr/sbin/xterm -e /home/elppans/.cache/lutris/run_in_term.sh  
Start monitoring process.  
/usr/sbin/xterm: symbol lookup error: /usr/lib/libfreetype.so.6: undefined symbol: hb_ot_tags_from_script_and_language  
Monitored process exited.  
Initial process has exited (return code: 32512)  
All processes have quit  
Exit with return code 32512  

### Solução

Tendo o pacote freetype2 versão 2.12.1-1 ou maior instalado na Distro, deve achar a versão 6.8.0 para usar.  
Provavelmente irá achar no Steam.  


Com o Steam instalado faça o comando para verificar:  

```
ls -l $HOME/.local/share/Steam/ubuntu12_32/steam-runtime/usr/lib/x86_64-linux-gnu/libfreetype.so.6
```

> lrwxrwxrwx 1 elppans elppans 20 mai 17  2021 /home/elppans/.local/share/Steam/ubuntu12_32/steam-runtime/usr/lib/x86_64-linux-gnu/libfreetype.so.6 -> libfreetype.so.6.8.0

Vendo que a biblioteca no Steam é a necessária, deve fazer o Lutris usar a mesma versão da biblioteca:  

```
ln -sf $HOME/.local/share/Steam/ubuntu12_32/steam-runtime/usr/lib/x86_64-linux-gnu/libfreetype.so.6 $HOME/.local/share/lutris/runtime/Ubuntu-18.04-x86_64
```
### Falha ao usar Terminal Gnome por padrão  

Usando o ArchLinux com o Gnome-Shell 43 com o Terminal padrão desta versão, ocorre o seguinte erro ao reinstalar o jojo usando este terminal:  
>lutris-wrapper: /home/arch/.cache/lutris/installer/spiral-knights/file1/spiral-install.bin  
Started initial process 5874 from /usr/bin/kgx -e /home/arch/.cache/lutris/run_in_term.sh  
Start monitoring process.  
/usr/bin/kgx: symbol lookup error: /usr/lib/libgtk-4.so.1: undefined symbol: pango_layout_line_get_length  
Monitored process exited.  
Initial process has exited (return code: 32512)  
All processes have quit  
Exit with return code 32512  

### Solução:

Instale o xterm e, em seguida, o jogo será instalado normalmente

### Jogo não inicia

Aqui no Arch, mesmo com tudo certo e sem erro algum, não estava iniciando o jogo.  

### Solução:  

1) Abra as conigurações do jogo no Lutris e vá até a aba "**Opções do sistema**".  
2) Habilite a opção "**Desabilitar o Lutris Runtime**".  

[![spiral-knights-lutris-runtime.png](https://i.postimg.cc/85TWgmbN/spiral-knights-lutris-runtime.png)](https://postimg.cc/sB01pS8N)

