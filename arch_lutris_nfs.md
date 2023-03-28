# [Lutris, Need For Speed World](https://lutris.net/games/soapbox-race-world-need-for-speed-world/)  

Há uma versão antiga do NFS que é muito bom, o NFS World, mas oficialmente os servidores estão fechados, mas dá pra jogar usando a versão [soapbox](https://soapboxrace.world/) (Não há problemas, pois a EA sabe deste soapbox e decidiu não interferir).  

### Instalar o Lutris:  

```
sudo pacman -S gamemode lib32-gamemode lutris wine-staging winetricks
```

### Funcionar o som no jogo:  

> lib32-libwrap foi removido dos repositórios, mas mesmo sem, o som funciona.  

```
sudo pacman -S apparmor lib32-libpulse lib32-libsndfile lib32-libasyncns
```

### Instalar o jogo  

E só logar no Lutris, ir na página do jogo e clicar em instalar.  
O melhor servidor pra logar e jogar é o principal (WorldUnited.gg)  

### Resolver Crash  

1) Com winetricks do jogo instale o pacote vcrun2019, para evitar o erro "Unable to load Modloader.asi":  

* No Lutris, selecione o jogo `Soapbox Race World (Need for Speed World)` e vá até o símbolo do Wine e clique na seta.
Ao clicar na seta vá até "Abrir terminal Bash" e faça o comando:

```
winetricks -q vcrun2019
```

2) Após logar, se der erro informando que está faltando o DirectX e pedindo pra instalar GPU Driver configure:  

* Clique em Jogar (seta) e vá em Configurar, aba "Opções do runner";  
Desabilite a opção "**Habilitar DXVK**"  

3) Outras configurações  

* Clique em Jogar (seta) e vá em Configurar, aba "Opções do sistema";  
Habilite a opção "Restaurar a resolução ao sair do jogo"  

* Clique em Jogar (seta) e vá em Configurar, aba "Opções do sistema";  
Vá até variáveis de ambiente e adicione "**DXVK_HUD=fps**"  

4) Dentro do jogo, pra evitar Crash, faça esta configuração:

```
Entrar em Opções > Social
Deixe ativado "Social Freeroam Filtering"
```

Para mais informações, acesse:  
[Pastebin - Arch, NFS no Lutri, correção de erros](https://pastebin.com/1pVqZjFE)
