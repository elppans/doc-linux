# Configurar o Wi-Fi no Debian via linha de comando

1. **Usando `iwconfig` para descobrir redes disponíveis:**  
   
   > Pacote: iwconfig  
   
   - Antes de começar, você precisa saber o ESSID (nome da rede) à qual deseja se conectar.  
   
   - Use o comando `iwconfig` para verificar as redes disponíveis:  
     
     ```
     iwconfig
     ```
   
   - Anote o nome da rede que deseja conectar.  
     
     

2. **Usando `nmcli` (NetworkManager CLI):**  
   
   > Pacote: network-manager  
   
   
   
   - O `nmcli` é uma interface de linha de comando para o NetworkManager.  
   
   - Para verificar redes disponíveis, execute:  
     
     ```
     nmcli device wifi list
     ```
   
   - Para conectar-se a uma rede específica, use:  
     
     ```
     nmcli device wifi connect "nome_da_rede" password "sua_senha"
     ```

3. **Usando `nmtui` (NetworkManager Text User Interface):**  
   
   - O `nmtui` é uma interface de texto interativa para o NetworkManager.  
   
   - Execute o comando:  
     
     ```
     nmtui
     ```
   
   - Siga as opções para conectar-se à rede Wi-Fi desejada.  

4. **Usando `wpa_supplicant`:**  
   
   > Pacote: wpasupplicant  
   
   
   
   - O `wpa_supplicant` é uma ferramenta para autenticação WPA/WPA2.  
   
   - Crie um arquivo de configuração (por exemplo, `wpa_supplicant.conf`) com as informações da rede:  
     
     ```
     network={
         ssid="nome_da_rede"
         psk="sua_senha"
     }
     ```
   
   - Em seguida, execute:  
     
     ```
     wpa_supplicant -i interface -c caminho_para_o_arquivo
     dhclient interface
     ```

## Configurar o Wi-Fi no arquivo `/etc/network/interfaces` no Debian  

1. Abra o arquivo `interfaces` em um editor de texto (por exemplo, `nano`):  
   
   ```
   sudo nano /etc/network/interfaces
   ```

2. Dentro do arquivo, adicione as configurações para a interface Wi-Fi. Por exemplo, se sua interface Wi-Fi for `wlan0` e você deseja usar um endereço IP estático:  
   
   ```
   auto wlan0
   iface wlan0 inet static
       address 192.168.1.10
       netmask 255.255.255.0
       gateway 192.168.1.1
       wpa-ssid "nome_da_rede"
       wpa-psk "senha_da_rede"
   ```
   
   - Substitua `wlan0` pelo nome correto da sua interface Wi-Fi.  
   - Defina o endereço IP, máscara de rede, gateway e as credenciais da rede Wi-Fi (`wpa-ssid` e `wpa-psk`).  

3. Salve as alterações e saia do editor.  

4. Reinicie o serviço de rede para aplicar as configurações:  
   
   ```
   sudo systemctl restart networking
   ```

Lembre-se de substituir "nome_da_rede" e "senha_da_rede" pelos valores corretos da sua rede Wi-Fi.  

Para mais detalhes, consulte a [documentação oficial do Debian sobre Wi-Fi](https://wiki.debian.org/pt_BR/WiFi).⁴  



Referências:  

- [Como conectar à Rede WiFi via terminal Linux!](https://sempreupdate.com.br/como-conectar-wifi-via-terminal-linux/)  
- [3 maneiras de conectar-se a WiFi a partir da linha de comando no Debian](https://pt.softoban.com/3-ways-connect-wifi-from-command-line-debian)  
- [Wiki Debian - WiFi](https://wiki.debian.org/pt_BR/WiFi)  
- [Configurando interface de rede no Debian](https://blog.remontti.com.br/5848)  
- [Guia do Linux: Principais arquivos de configuração](https://bing.com/search?q=Configurar+WiFi+no+arquivo+interfaces)  
- [Vídeo tutorial: Configuração do arquivo interfaces](https://www.youtube.com/watch?v=JtKGp8-iU4k)  



Fontes:  
(1) pt_BR/WiFi - Debian Wiki. https://wiki.debian.org/pt_BR/WiFi.  
(2) How to configure network adapter in Debian. https://www.youtube.com/watch?v=cM-9qmF0Db8.  
(3) How to Install Broadcom WiFi Driver in Debian. https://www.youtube.com/watch?v=JW0f3NOjWys.  
(4) How to install Broadcom Wi Fi driver for Debian-based Linux distributions!. https://www.youtube.com/watch?v=XvYt3FEVgPk.  
(5) 3 maneiras de se conectar ao WiFi a partir da linha de comando no Debian. https://pt.linux-console.net/?p=16056.  
(6) 3 maneiras de conectar-se a WiFi a partir da linha de comando no Debian. https://pt.softoban.com/3-ways-connect-wifi-from-command-line-debian.  
(7) Configurando interface de rede no Debian 10/11/12 - Remontti. https://blog.remontti.com.br/5848.  
(8) WIFI VIA TERMINAL (LINUX). https://www.youtube.com/watch?v=dGHo1TeDi88.  
(9) Como conectar à Rede WiFi via terminal Linux! - SempreUpdate. https://sempreupdate.com.br/como-conectar-wifi-via-terminal-linux/.  
(10) Dicas - Como configurar uma rede sem fio (wireless) - Tecmundo. https://www.youtube.com/watch?v=rLb8t1fgGG8.  
(11) Como Instalar e Configurar Qualquer Repetidor Wi-Fi da MANEIRA CERTA!!. https://www.youtube.com/watch?v=9cOVyY6y_wM.  
(12) Como Configurar Qualquer Roteador Wifi. https://www.youtube.com/watch?v=wuIcJriPmPg.  
(13) Guia do Linux/Iniciante+Intermediário/Principais arquivos de .... https://bing.com/search?q=Configurar+WiFi+no+arquivo+interfaces.  
(14) Configuração do arquivo interfaces (/etc/network/interfaces). https://www.youtube.com/watch?v=JtKGp8-iU4k.  
