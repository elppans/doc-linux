# Corrigindo falha "erro: falha ao obter o arquivo "community.db" de site.server.org : The requested URL returned error: 404"

- Pode tentar os seguintes passos:

1. **Atualize a lista de mirrors:**
   ```bash
   sudo pacman-mirrors -g
   ```

2. **Sincronize novamente a base de dados de pacotes:**
   ```bash
   sudo pacman -Syy
   ```

3. **Tente atualizar novamente:**
   ```bash
   sudo pacman -Syu
   ```

Se o problema persistir, você pode editar o arquivo de configuração dos mirrors (`/etc/pacman.d/mirrorlist`) para remover ou comentar os mirrors que estão retornando erro 404.


- Usado comando `pacman-mirrors` para encontrar e classificar os melhores mirrors

Use um destes comandos. O resultado será gravado em `/etc/pacman.d/mirrorlist`, portanto, faça um backup antes

```bash
sudo pacman-mirrors --fasttrack 20 --api --protocols all --method rank --timeout 10 
```
```bash
sudo pacman-mirrors --fasttrack 5 --api --protocols all --method rank --timeout 10
```
```bash
sudo pacman-mirrors --api --protocols all --method rank --timeout 10 --interval 2 -s
```
```bash
sudo pacman-mirrors --country germany --api --protocols all --method rank --timeout 10 --interval 1 -s
```
```bash
sudo pacman-mirrors --geoip --api --protocols all --method rank --timeout 10 --interval 2 -s
```

Se nenhum destes comandos der certo, acesse o site [Manjaro Repositóry](https://repo.manjaro.org/) e copie qualquer link com o status da linha verde (atualizado) e configure o arquivo `/etc/pacman.d/mirrorlist` manualmente.

Se até aqui nada funcionar, veja se os mirrors com problema é o do arquivo `/etc/pacman.d/mirrorcdn`.
Se for, comente as linhas que começam com "Server" e tente atualizar novamente o sistema

```bash
sudo sed -i '/Server/ s/^/#/' /etc/pacman.d/mirrorcdn
```
```bash
sudo pacman -Syyu
```

Se nenhuma das dicas funciona.... Lascou!
