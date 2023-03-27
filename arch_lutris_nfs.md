# [Lutris, Need For Speed World](https://lutris.net/games/soapbox-race-world-need-for-speed-world/)

Há uma versão antiga do NFS que é muito bom, o NFS World, mas oficialmente os servidores estão fechados, mas dá pra jogar usando a versão [soapbox](https://soapboxrace.world/) (Não há problemas, pois a EA sabe deste soapbox e decidiu não interferir).

### Instalar o Lutris:

```
sudo pacman -S gamemode lib32-gamemode lutris wine-staging winetricks
```

### Funcionar o som no jogo:

```
sudo pacman -S apparmor lib32-libpulse lib32-libwrap lib32-libsndfile lib32-libasyncns
```

### Instalar o jogo

E só logar no Lutris, ir na página do jogo e clicar em instalar.  
O melhor servidor pra logar e jogar é o principal (WorldUnited.gg)

### Resolver Crash

1) Dentro do jogo, pra evitar Crash, faça esta configuração:

```
Entrar em Opções > Social
Deixe ativado "Social Freeroam Filtering"
```

2) Com winetricks, instale o pacote vcrun2019, para evitar o erro "Unable to load Modloader.asi"

Mais informações:  
[Pastebin - Arch, NFS no Lutri, correção de erros](https://pastebin.com/1pVqZjFE)
