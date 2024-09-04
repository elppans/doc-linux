# Debian, IP Fixo no arquivo interfaces

Para configurar um IP fixo no Debian usando o arquivo `interfaces`, siga os passos abaixo:

1. **Abra o terminal** e edite o arquivo `/etc/network/interfaces` com um editor de texto, como o `nano`:
   ```bash
   sudo nano /etc/network/interfaces
   ```

2. **Adicione as seguintes linhas** ao arquivo, substituindo os valores conforme necessário:
   ```plaintext
   auto eth0
   iface eth0 inet static
       address 192.168.1.100
       netmask 255.255.255.0
       gateway 192.168.1.1
       dns-nameservers 8.8.8.8 8.8.4.4
   ```
   - `eth0` é o nome da interface de rede. Pode ser diferente no seu sistema (use `ip addr show` para verificar).
   - `address` é o IP fixo que você deseja configurar.
   - `netmask` é a máscara de sub-rede.
   - `gateway` é o gateway padrão.
   - `dns-nameservers` são os servidores DNS.

3. **Salve e feche o arquivo** (`Ctrl+O` para salvar e `Ctrl+X` para sair).

4. **Reinicie o serviço de rede** para aplicar as mudanças:
   ```bash
   sudo systemctl restart networking
   ```

5. **Verifique a configuração**:
   ```bash
   ip addr show eth0
   ```

Esses passos devem configurar um IP fixo no seu sistema Debian.  
___
- Fontes:   
[(1) Como configurar um IP fixo no Debian 12 | Blog.resende.biz.](https://blog.resende.biz/como-configurar-um-ip-fixo-no-debian-12)  
[(2) Configuração de IP fixo no Debian 9.](https://www.youtube.com/watch?v=6YGIiP94Xe4)  
[(3) Como Configurar o IP no Linux Debian.](https://www.youtube.com/watch?v=qjtcS7XP5rU)  
[(4) 🐧 Linux File Server - Configurando um IP fixo no Servidor de Arquivos Linux #linuxnetwork #debian.](https://www.youtube.com/watch?v=NW1MxGgNH6A)  
[(5) Configurando interface de rede no Debian 10/11/12 - Remontti.](https://blog.remontti.com.br/5848)  
[(6) Como colocar um IP fixo no Debian? – ConselhosRapidos.](https://bing.com/search?q=Configurar+IP+fixo+usando+o+arquivo+interfaces+no+Debian)  
[(7) Como colocar um IP fixo no Debian? – ConselhosRapidos.](https://conselhosrapidos.com.br/como-colocar-um-ip-fixo-no-debian/)  
[(8) Configurar IP Por DHCP Em Debian/Ubuntu - ServerSP.](https://serversp.com/blog/sem-categoria/configurar-ip-por-dhcp-em-debianubuntu/)  
[(9) 🐧 Linux Server - Fundamentos de rede - Configurando um IP fixo no Servidor - Parte 2/3 #linux.](https://www.youtube.com/watch?v=koawRYbhrL8)  
[(10) Como colocar um IP fixo no Debian? – ConselhosRapidos.](https://bing.com/search?q=Configurar+IP+fixo+no+Debian)  
(11) Como definir um endereço IP estático no Debian 10 Buster. https://www.edivaldobrito.com.br/como-definir-um-endereco-ip-estatico-no-debian-10-buster/.
