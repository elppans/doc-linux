# Debian: Remover o Plasma e Instalar uma Nova Interface Gráfica no Debian 12

#### Remover completamente o Plasma do Debian 12

1. **Remover pacotes do KDE:**
   ```bash
   sudo apt remove `dpkg -l kde* | grep ^ii | awk '{print $2}'`
   ```

2. **Remover o gerenciador de login SDDM:**
   ```bash
   sudo apt remove sddm
   ```

3. **Remover pacotes não utilizados:**
   ```bash
   sudo apt autoremove
   ```

4. **Reiniciar o sistema:**
   ```bash
   sudo reboot
   ```

#### Instalar uma nova interface gráfica padrão no Debian 12

1. **Instalar o Tasksel:**
   ```bash
   sudo apt install tasksel
   ```

2. **Executar o Tasksel para instalar um ambiente de desktop:**
   ```bash
   sudo tasksel
   ```

3. **Selecionar o ambiente de área de trabalho preferido:**
   - Navegue até o ambiente de desktop desejado.
   - Vá para **OK** para confirmar.
   - Pressione **ENTER** para iniciar a instalação.
___

- Fontes:  
[(1) Como instalar o KDE Plasma no Debian 12, 11 ou 10.](https://www.linuxcapable.com/pt/como-instalar-kde-plasma-no-debian-linux/)  
[(2) TUTORIAL: how to make a clean KDE Plasma install on Debian 12 ... - Reddit.](https://www.reddit.com/r/debian/comments/1640aaq/tutorial_how_to_make_a_clean_kde_plasma_install/)  
[(3) Debian: pacote de desinstalação [Guide] - Moyens I/O.](https://bing.com/search?q=Remover+completamente+o+Plasma+do+Debian+12)  
[(4) Como desinstalar o Kde plasma - Avançado/Terminal - Diolinux Plus.](https://plus.diolinux.com.br/t/como-desinstalar-o-kde-plasma/27450)  



