# Actions For Nautilus

O "Actions For Nautilus" é uma extensão para o gerenciador de arquivos Gnome Files, também conhecido como Nautilus. Esta extensão permite adicionar ações personalizadas ao menu de contexto da seleção de arquivos. 

Com o "Actions For Nautilus", você pode estruturar itens de menu de contexto, incluindo submenus aninhados, e filtrar os itens exibidos com base em várias condições, como o número de arquivos na seleção, permissões de acesso do usuário, tipos de arquivos e padrões de caminho. Além disso, você pode executar comandos ou scripts arbitrários quando um item de menu é ativado.

Para instalar a extensão em sistemas baseados em Debian, você pode baixar o pacote mais recente e instalá-lo com seu instalador de pacotes. Depois, basta iniciar o aplicativo "Actions For Nautilus Configurator" para começar a configurar as ações com base no exemplo fornecido.

Se você estiver usando o Ubuntu, pode seguir um tutorial específico para instalar a extensão, adicionando o repositório apropriado e usando comandos de terminal.
___
# Instalação da extenção Actions For Nautilus via SOURCE

## Actions for Nautilus no ArchLinux e derivados, via Git, PKGBUILD

```bash
mkdir -p ~/build
```
```bash
cd ~/build
```
```bash
wget -c https://raw.githubusercontent.com/elppans/actions-for-nautilus/refs/heads/main/pkgbuild/PKGBUILD
```
```bash
yay --noconfirm -S jquery gtkhash xclip
```
```bash
makepkg -Cris
```
___
## Actions for Nautilus no Ubuntu, via Git

```bash
sudo apt -y install python3-nautilus python3-gi procps libjs-jquery git make
```
```bash
sudo apt -y install baobab xclip zenity
```
```bash
sudo snap install gtkhash
```
```bash
git clone https://github.com/elppans/actions-for-nautilus.git
```
```bash
cd actions-for-nautilus
```
```bash
sudo make install_global
```
```bash
mkdir -p $HOME/.local/share/actions-for-nautilus
```
```bash
cp /usr/share/actions-for-nautilus-configurator/sample-config.json $HOME/.local/share/actions-for-nautilus/config.json
```
___
