# Debian, TigerVNC Server
---

## Tutorial: Configurando um Ambiente de Trabalho Remoto com XFCE e TigerVNC

### Passo 1: Instalando o Ambiente de Trabalho

Primeiro, vamos atualizar os pacotes e instalar o `tasksel`, uma ferramenta que facilita a instalação de ambientes de trabalho.

```bash
sudo apt update
sudo apt install tasksel
sudo tasksel
```

### Passo 2: Instalando o Servidor TigerVNC

Instale o servidor TigerVNC e suas dependências:

```bash
sudo apt install tightvncserver tigervnc-standalone-server tigervnc-common
vncserver
vncserver -kill :1
```

### Passo 3: Configurando o Servidor VNC e o Ambiente de Desktop

Verifique os ambientes de área de trabalho disponíveis. No exemplo, estamos usando XFCE:

```bash
ls /usr/share/xsessions/
```

Crie uma nova configuração para o servidor VNC em `~/.vnc/config`:

```bash
echo -e 'session=xfce\ngeometry=1200x720\nlocalhost\nalwaysshared\n' | tee "$HOME"/.vnc/config
```

#### Descrição das Opções:
- `session=xfce`: Define a sessão padrão para XFCE.
- `geometry=1200x720`: Define a resolução da tela.
- `localhost`: Executa o servidor VNC apenas no localhost. Para permitir conexões de outros computadores, altere para `0`.
- `alwaysshared`: Permite conexões compartilhadas.

### Passo 4: Adicionando Usuário para o Servidor TigerVNC

Adicione o usuário ao servidor TigerVNC:

```bash
echo -e "\n:1=$USER\n" | sudo tee -a /etc/tigervnc/vncserver.users
```

### Passo 5: Ativando o Serviço

Ative e verifique o status do serviço TigerVNC:

```bash
sudo systemctl enable --now tigervncserver@:1.service
systemctl status tigervncserver@:1.service
```

### Passo 6: Conectando-se ao Servidor VNC via Túnel SSH

Finalmente, conecte-se ao servidor VNC usando um túnel SSH:

```bash
ssh -L 5901:0.0.0.0:5901 -N -f -l pdvtec 192.168.15.100
```
Após este comando para ativar o túnel, abra um aplicativo VNC Cliente e acesse o servidor VNC utilizando um endereço local.  
Exemplo: `127.0.0.1:1`  

### Passo 7: Conectando-se ao Servidor VNC via Túnel SSH

Se optou configurar o valor `0` para o parâmetro `localhost` (Passo 3), não é necessário seguir o **Passo 6**.  
Abra um aplicativo VNC Cliente e acesse o servidor VNC utilizando o endereço do servidor.  
Exemplo: `192.168.15.100:1`  

---

- Fontes:  
[(1) Como instalar o servidor VNC no Debian 12.](https://pt.linux-console.net/?p=30634#:~:text=No%20Debian,%20voc%C3%AA%20pode%20usar%20TigerVNC%20para%20criar)  
[(2) Como instalar e configurar a VNC no Debian 9.](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-debian-9-pt)

