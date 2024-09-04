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
Após este comando para ativar o túnel, abre um aplicativo VNC Cliente e acesse o servidor VNC utilizando um endereço local: `127.0.0.1:1`  

### Passo 7: Conectando-se ao Servidor VNC via Túnel SSH

Se optou configurar o valor `0` para o parâmetro `localhost` (Passo 3), não é necessário seguir o **Passo 6**.  
Basta pegar 

---

- Fontes:  
[(1) DICAS PARA APRENDER SCRIPT! (script é mais fácil do que você pensa!).](https://www.youtube.com/watch?v=o1cS5f8SfxA)   
[(2) AULA COMPLETA de SCRIPT! COMO FAZER SCRIPT e SISTEMAS no ROBLOX STUDIO do ZERO!.](https://www.youtube.com/watch?v=NrYKaGjLGjw)   
[(3) COMO CONVERTER SCRIPT ESX PARA VRP/VRPEX 2022/2023.](https://www.youtube.com/watch?v=g6EfDh9BGDQ)   
[(4) Dois métodos simples para converter um arquivo Python em um ... - DataCamp.](https://www.datacamp.com/pt/tutorial/two-simple-methods-to-convert-a-python-file-to-an-exe-file)   
[(5) Conversor on-line gratuito de TXT to SCRIPT | Conholdate Apps.](https://products.conholdate.app/pt/conversion/txt-to-script)   
[(6) Como transformar seu script em vídeo com IA? (Guia) - AI Mojo.](https://aimojo.io/pt/script-video-ai/)   
[(7) Criador de Video com IA - Ferramenta de Texto para Vídeo Online - FlexClip.](https://www.flexclip.com/pt/tools/ai-text-to-video/)   
[(8) Tutorial Powershell - Converter um script PS1 para EXE - TechExpert.Tips.](https://techexpert.tips/pt-br/powershell-pt-br/powershell-converta-um-script-ps1-para-o-aplicativo-exe/)   
