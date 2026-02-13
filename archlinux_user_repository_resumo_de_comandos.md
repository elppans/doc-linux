# Arch User Repository (AUR) – Resumo de Comandos

Será usado um nome de usuário, e-mail e nome de pacote fictício para os exemplos.
Basta substituir pelos seus dados reais.

> Usuário = auruser
> E-mail = [auruser@aur.org](mailto:auruser@aur.org)
> Pacote = pacoteaur
> Diretório de build = $HOME/build/custombuild

Este é um resumo dos comandos utilizados para configurar a conta AUR e gerenciar pacotes.
Para mais detalhes, consulte os links no final do documento.

---

# Comandos Git úteis

Lista de comandos Git utilizados com frequência:

```bash
git ls-files              # Listar arquivos rastreados pelo git
git remote -v             # Listar remotes configurados
git branch -r             # Listar branches remotas
git status                # Mostrar status da árvore de trabalho
git log                   # Mostrar histórico de commits
git show                  # Ver alterações do último commit
git branch -vv            # Ver branch atual e upstream
```

---

# Configurando conta AUR

## 1. Testar autenticação SSH

Verifique se sua chave já está configurada no AUR:

```bash
ssh -T aur@aur.archlinux.org
```

Se estiver correto, aparecerá algo como:
>Se OK, pule para `Criação de novo pacote AUR`  

```php-template
Welcome to AUR, auruser! Interactive shell is disabled.
```

Se aparecer:

```php-template
Permission denied (publickey)
```

Significa que sua chave SSH ainda não está cadastrada, siga para o item 2.  

---

## 2. Criar chave SSH específica para o AUR (opcional, mas recomendado)

Criar entrada no `~/.ssh/config`:

```bash
echo -e 'Host aur.archlinux.org
  IdentityFile ~/.ssh/aur
  User aur' >> ~/.ssh/config
```

Gerar a chave:

```bash
ssh-keygen -f ~/.ssh/aur
```

Copiar chave pública:

```bash
cat ~/.ssh/aur.pub
```

Depois adicionar no site do AUR em:

My Account → SSH Public Keys

---

# Criação de novo pacote AUR

## 1. Criar diretório de trabalho

```bash
mkdir -p $HOME/build/custombuild
cd $HOME/build/custombuild
```

## 2. Clonar repositório do pacote

```bash
git clone ssh://aur@aur.archlinux.org/pacoteaur.git
cd pacoteaur
```
> **Importante:**
> O comando `git clone` criará automaticamente um diretório com o nome do pacote contendo toda a estrutura e configurações necessárias do repositório Git (incluindo o remote `origin` já configurado para o AUR).
>
> Se o pacote **ainda não existir no AUR**, o repositório remoto será efetivamente criado no momento do primeiro `git push`.
>
> Se o pacote **já existir e você for o maintainer**, o repositório será apenas clonado normalmente.
>
> Caso o pacote já exista e você **não seja o maintainer**, você não terá permissão para enviar alterações.

## 3. Configurar identidade Git (se ainda não configurado)

```bash
git config --global user.name  "auruser"
git config --global user.email "auruser@aur.org"
```

Verifique se está configurado a branch master corretamente

```bash
git remote -v
```
```bash
git branch -vv
```
```bash
git ls-remote --symref origin HEAD
```

Se não, renomeie a branch main para master e crie a branch master no AUR

```bash
git branch -m master
```
```bash
git push -u origin master
```

---

## 4. Criar arquivos necessários

Crie e configure:

* `PKGBUILD`
* `.gitignore` (opcional)

Sempre antes de enviar qualquer alteração, gere/atualize o `.SRCINFO`:

```bash
makepkg --printsrcinfo > .SRCINFO
```

Adicionar arquivos:

```bash
git add PKGBUILD .SRCINFO .gitignore
```

Criar commit:

```bash
git commit -m "Initial commit"
```

Enviar para o AUR:

```bash
git push
```

---

# Atualização do pacote AUR

Se você ainda possui o diretório local, apenas edite os arquivos.

Se perdeu o diretório, clone novamente:

```bash
git clone ssh://aur@aur.archlinux.org/pacoteaur.git
cd pacoteaur
```

---

## 1. Editar versão

Sempre atualizar:

* `pkgver`
* `pkgrel` (incrementar quando não for nova versão upstream)

Se usar fontes externas com checksum:

```bash
updpkgsums
```

---

## 2. Gerar novamente o .SRCINFO

```bash
makepkg --printsrcinfo > .SRCINFO
```

---

## 3. Commit padrão recomendado

```bash
git commit -am "upgpkg: 1.2.3-1"
```

---

## 4. Enviar atualização

```bash
git push
```

---

# Testando o pacote antes de subir (recomendado)

Build simples:

```bash
makepkg -si --cleanbuild
```

Build em ambiente limpo (melhor prática):

```bash
extra-x86_64-build
```

---

# Verificação de qualidade

Validar PKGBUILD:

```bash
namcap PKGBUILD
```

Validar pacote gerado:

```bash
namcap pacoteaur-1.0-1-x86_64.pkg.tar.zst
```

---

# Links e Fontes

* [Arch User Repository, PT](https://wiki.archlinux.org/title/Arch_User_Repository_(Portugu%C3%AAs))  
* [AUR submission guidelines, PT](https://wiki.archlinux.org/title/AUR_submission_guidelines_(Portugu%C3%AAs))  
* [AUR submission guidelines, PT, Regras de envio](https://wiki.archlinux.org/title/AUR_submission_guidelines_(Portugu%C3%AAs)#Regras_de_envio)  
* [Criando pacotes, PT](https://wiki.archlinux.org/title/Creating_packages_(Portugu%C3%AAs))  
* [Arch package guidelines, PT](https://wiki.archlinux.org/title/Arch_package_guidelines_(Portugu%C3%AAs))  
* [Chaves SSH](https://wiki.archlinux.org/title/SSH_keys)  
* [Git, Configuração](https://wiki.archlinux.org/title/Git#Configuration)  
* [Git remote](https://git-scm.com/docs/git-remote)  
* [Problem with ssh authentication on AUR, Resolvido](https://bbs.archlinux.org/viewtopic.php?id=258198)  
* [The PGP key fingerprint is invalid, Resolvido](https://bbs.archlinux.org/viewtopic.php?id=257585)  

* Grupo Telegram recomendável:  [Telegram Arch Linux Brasil](https://t.me/archlinuxbr)  
* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
