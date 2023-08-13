# AUR, Resumo de comandos

Será usado um nome de usuário, e-mail e nome de pacote ficticio, para poder enviar os exemplos.  
Basta mudar eles para o seu uso.  

Será indicado aqui apenas um resumo dos comandos que são utilizados para configurar a conta AUR e gerenciar os pacotes.  
Para mais informações, acesse os links do final da matéria.  

> Usuário = auruser  
E-mail = auruser@aur.org  
Pacote = pacoteaur  
Diretório de configuração = $HOME/build/custombuild  

## Comandos GIT úteis  

Uma lista de comandos git utilizado nos testes  

```
git ls-files = Listar arquivos que estão no git
git remote remove pacoteaur = Remover Branch específico
git remote -v = Listar Branch e os links
git branch -r = Listar configuração de Branch
git status = Mostrar o status da árvore de trabalho
git log = Mostrar logs de commit
git show = Ver as mudanças desde o último commit

```

## Configurando conta AUR para receber pacotes  

#### 1. Configurar autenticação e acesso de escrita para o AUR  

```
echo -e 'Host aur.archlinux.org
  IdentityFile ~/.ssh/aur
  User aur' | tee ~/.ssh/config
```

2. Criar um par de chaves para adicionar em sua conta  

```
ssh-keygen -f ~/.ssh/aur
```
3. Verifique o arquivo com a chave e copie e depois adicione em sua conta, no campo `Chave pública SSH`  

```
cat ~/.ssh/aur.pub
```

## Criação e configuração do pacote AUR  

1. Criar diretório de trabalho  

```
mkdir -p $HOME/build/custombuild
cd $HOME/build/custombuild
```


2. Criar e acessar diretório do pacote AUR  

```
git clone ssh://aur@aur.archlinux.org/pacoteaur.git
cd pacoteaur
```

3. Faça configuração global para seu usuário  

```
git config --global user.name  "auruser"
git config --global user.email "auruser@aur.org"
```

4. Crie e configure os arquivos .gitignore e PKGBUILD  

Sempre antes de upar a atualização, recrie um novo .SRCINFO com o comando makepkg  
Então adicione, faça um commit e depois faça o upload das modificações  

```
makepkg --printsrcinfo > .SRCINFO
git add PKGBUILD .SRCINFO .gitignore
git commit -m "Create Package pacoteaur"
git push
```

## Atualização do pacote AUR  

>Eu clonei meu pacote novamente, pois meu HD onde estava o build bateu as botas.  
Então se seu pacote ainda continua no seu HD após a criação, talvez possa pular direto para a edição dos arquivos.  

1. Clonar e entrar no repositório  

```
git clone https://aur.archlinux.org/pacoteaur.git && cd pacoteaur
```

2. Adicionar o repositório remoto como 'pacoteaur'  

```
git remote add -f -t master -m master pacoteaur ssh://aur@aur.archlinux.org/pacoteaur.git
```

3. Configurar a referência remota padrão para push  

```
git push --set-upstream qemu-android-cm-x86 HEAD
```
4. Edite o necessário e faça como a opção 4 do ítem anterior  

Sempre que atualizar o pacote AUR, não pode esquecer de editar o parâmetro `pkgver` e o `pkgrel`  

* Links e Fontes  

[Arch User Repository, PT](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs))  
[AUR submission guidelines, PT](https://wiki.archlinux.org/title/AUR_submission_guidelines_(Portugu%C3%AAs))  
[AUR submission guidelines, PT, Regras de envio](https://wiki.archlinux.org/title/AUR_submission_guidelines_(Portugu%C3%AAs)#Regras_de_envio)  
[Criando pacotes, PT](https://wiki.archlinux.org/title/Creating_packages_(Portugu%C3%AAs))  
[Arch package guidelines, PT](https://wiki.archlinux.org/title/Arch_package_guidelines_(Portugu%C3%AAs))  
[Chaves SSH](https://wiki.archlinux.org/title/SSH_keys)  
[Git, Configuração](https://wiki.archlinux.org/title/Git#Configuration)  
[Git remote](https://git-scm.com/docs/git-remote)  
[Problem with ssh authentication on AUR, Resolvido](https://bbs.archlinux.org/viewtopic.php?id=258198)  
[The PGP key fingerprint is invalid, Resolvido](https://bbs.archlinux.org/viewtopic.php?id=257585)  

* Grupo Telegram recomendável:  [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
