# Atualização de chaves, Archlinux

Normalmente o primeiro erro de chave eu mando um `pacman -S archlinux-keyring`. 
O segundo eu mando um `pacman-key --init && pacman-key --populate`. 
Seja na ISO, seja no contêiner docker do Arch.

Comandos do Wiki:
```
pacman-key --init
```
```
pacman-key --populate archlinux
```
```
pacman -Sy archlinux-keyring
```

# Atualização de chaves, BIGLinux

Há 3 modos para fazer a atualização/correção de chaves

1. Fazer este comando, que é a mesma coisa que clicar lá nas configurações do BIG Store:

```
sudo force-upgrade --fix-keys
```

2. Atualização das chaves manualmente:

```
sudo pacman -S archlinux-keyring manjaro-keyring
```
```
sudo pacman -S biglinux-keyring
```

3. Atualizando todas as chaves de uma vez

```
sudo pacman -S $(pacman -Qqs keyring)
```
```
sudo pacman-key --init && sudo pacman-key --populate
```

Opcionalmente, pode dar um refresh nas chaves:
```
sudo pacman-key --refresh-keys
```
- Finalmente, atualiza todos os pacotes do sistema:
```
sudo pacman -Syyu
```

#Chave #Chaves #Key #Keys #keyring #BIG #Linux #BIGLinux #manjaro #archlinux #gpg
