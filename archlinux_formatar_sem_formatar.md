# Archlinux, formatar "sem" formatar

Eu estava querendo instalar uma outra Interface Gráfica (GUI) mas de forma LIMPA como se fosse uma Distro nova, porém não queria fazer o processo de formatar tudo de novo, então decidi fazer este esquema de "RESETAR" a Distro para ficar no estado de como se estivesse acabado de instalar.  
Aqui vai um resumo e direto, do procedimento de "Formatar, sem formatar" o Arch Linux.  
Ao ler, notará que é bem fácil fazer o procedimento, mas claro, preste atenção no que tá fazendo. Eu não me responsabilizo se ocorrer algo.  

### Diretório de usuário LIMPO

Antes de iniciar o procedimento, para que tenha uma configuração limpa com o novo GUI, pode fazer o procedimento para [renomear o usuário (e seus sistemas de diretórios)](https://wiki.archlinux.org/title/Users_and_groups_(Portugu%C3%AAs)#Alterar_um_nome_de_login_ou_diret%C3%B3rio_home_do_usu%C3%A1rio), pra depois criar um novo usuário, com os grupos adicionados.  

MAS, se assim como eu, **não quer criar um novo usuário** mas quer a pasta de usuário limpa, faça o seguinte, em um tty:  

```bash
sudo mv /home/usuário /home/usuário_BKP
```
```bash
sudo mkdir -p /home/usuário
```
```bash
cp -av /etc/skel/.bash* /home/usuário
```
```bash
sudo chown -R $USER:$USER /home/usuário
```

Com isso, não precisa criar um novo usuário e vai ter um novo diretório limpo para o mesmo e ainda vai ter um backup, para caso precise copiar algo de importância para o diretório de usuário novo.  

> Observação: Por garantia, **faça um BACKUP dos seus arquivos**.  

### Shell padrão do usuário

Antes de começar o processo da "formatação" do Archlinux, é importante redefinir o Shell padrão do seu usuário, principalmente se o seu Shell é customizado.  
Aconteceu que, eu estava usando zsh e como removí ao fazer o processo de "reset", tive um problema de "login ou senha inválido" mesmo adicionando a senha correta e, a fim de corrigir fiz uma pesquisa e vi sobre [gerenciamento de usuários](https://wiki.archlinux.org/title/Users_and_groups_(Portugu%C3%AAs)#Gerenciamento_de_usu%C3%A1rio) que se o Shell não está listado no arquivo `/etc/shells`, o usuário fica impossibilitado de logar.  

Para corrigir, deve [alterar o Shell padrão](https://wiki.archlinux.org/title/Command-line_shell_(Portugu%C3%AAs)#Alterando_seu_shell_padr%C3%A3o) para o "ORIGINAL".  
Então, deve fazer o comando para configurar o Shell padrão:

```bash
sudo chsh -s /bin/bash $USER
```

### [Removendo tudo exceto os pacotes essenciais](https://wiki.archlinux.org/title/Pacman_(Portugu%C3%AAs)/Tips_and_tricks_(Portugu%C3%AAs)#Removendo_tudo_exceto_os_pacotes_essenciais)  

* 1º - Altere o motivo de instalação de **TODOS** os pacotes instalados "`como Explicitamente`" para "`como dependência`"  

```bash
sudo pacman -D --asdeps $(pacman -Qqe)
```
>Mesmo após todo o processo, um monte de pacote lixo continua instalado porque são classificados e sendo listado como "nativos" (pacman -Qn).  
>A documentação não recomenda, mas se quiser o sistema realmente limpo, faça o comando desta forma:  
>>`sudo pacman -D --asdeps $(pacman -Qqn)`

* 2º - Altere o motivo da instalação para "`como explicitamente`" apenas os **PACOTES ESSENCIAIS**. Aqueles que você **NÃO** deseja remover:  

> Eu escolhi exatamente os pacotes que usei ao [Instalar o Arch Linux (BASE)](https://elppans.github.io/doc-linux/archLinux_instalacao_base_btrfs), para ficar como se eu tivesse acabado de instalar.  
Faça o mesmo com seus pacotes utilizados na instalação.  

```bash
sudo pacman -D --asexplicit base base-devel linux linux-headers linux-firmware intel-ucode btrfs-progs git fakeroot reflector nano ntp man-db man-pages texinfo grub-efi-x86_64 efibootmgr dosfstools os-prober mtools networkmanager wpa_supplicant wireless_tools dialog sudo
```

Mais especificamente, como **não queria recompilar o yay**, meu comando completo ficou assim:  
>Lembrando que você pode **`adicionar OU remover os pacotes que quiser`**, assim como fiz

```bash
sudo pacman -D --asexplicit base base-devel linux linux-headers linux-firmware intel-ucode btrfs-progs git fakeroot reflector nano ntp man-db man-pages texinfo grub-efi-x86_64 efibootmgr dosfstools os-prober mtools networkmanager wpa_supplicant wireless_tools dialog sudo yay pkgconf wget
```

* 3° - [Remover os pacotes](https://wiki.archlinux.org/title/Pacman_(Portugu%C3%AAs)/Tips_and_tricks_(Portugu%C3%AAs)#Removendo_pacotes_n%C3%A3o_usados_(%C3%B3rf%C3%A3os)), menos os configurados como "Instalados Explicitamente"  

No Wiki informa o uso da remoção com o pacman, usando apenas as opções `-Rns`, porém, para uma instalação MAIS limpa, pode-se usar as opções `-Rsunc`.  

> -R --remove  
-s, --recursive. Remove as dependências desnecessárias  
-u, --unneeded. Remove pacotes desnecessários  
-n, --nosave. Remove os arquivos de configuração  
-c, --cascade. Remove pacotes e todos os que dependem deles  

```bash
sudo pacman -Rsunc $(pacman -Qtdq)
```
>Em um teste, teve um resultado de que, ainda assim, ficou alguns pacotes indesejáveis instalados.  
>Se quiser, uma forma de contornar é usar as opções "`-Qttdq`":  
>>`-t, --unrequired lista de pacotes não exigidos (opcionalmente) por qualquer pacote (-tt para ignorar optdepends) [filtro]`  
>O comando vai ficar assim:  
>>`sudo pacman -Rsunc $(pacman -Qttdq)`  

Depois disto, pode reiniciar a Distro e verá que cairá somente no prompt tty, como se estivesse acabado de instalar o Arch Linux.  
Agora é só configurar o que quiser com a nova Interface Gráfica (GUI) que quiser e se quiser.  

#### Fontes:  

[Removendo tudo exceto os pacotes essenciais](https://wiki.archlinux.org/title/Pacman_(Portugu%C3%AAs)/Tips_and_tricks_(Portugu%C3%AAs)#Removendo_tudo_exceto_os_pacotes_essenciais)  
[Removendo pacotes não usados (órfãos)](https://wiki.archlinux.org/title/Pacman_(Portugu%C3%AAs)/Tips_and_tricks_(Portugu%C3%AAs)#Removendo_pacotes_n%C3%A3o_usados_(%C3%B3rf%C3%A3os))  
["Formatar" o Arch Linux sem formatar: remover tudo e só deixar os pacotes ultra-essenciais](https://www.desfragmente.com/2021/02/formatar-o-arch-linux-sem-formatar.html?m=1)  

* ### Grupo Telegram recomendável: [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
* ### Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
