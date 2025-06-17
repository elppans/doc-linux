Para desativar o IPv6 no Debian e garantir que o sistema utilize IPv4 por padrão, você pode seguir estes passos:

1. **Desativar IPv6 via sysctl**  
   Edite o arquivo `/etc/sysctl.conf` e adicione as seguintes linhas:  
   ```
   net.ipv6.conf.all.disable_ipv6 = 1
   net.ipv6.conf.default.disable_ipv6 = 1
   net.ipv6.conf.lo.disable_ipv6 = 1
   ```
   Depois, aplique as alterações com:  
   ```
   sudo sysctl -p
   ```

2. **Desativar IPv6 via GRUB** (opcional)  
   Edite o arquivo `/etc/default/grub` e adicione `ipv6.disable=1` no parâmetro `GRUB_CMDLINE_LINUX`:  
   ```
   GRUB_CMDLINE_LINUX="ipv6.disable=1"
   ```
   Depois, atualize o GRUB com:  
   ```
   sudo update-grub
   ```

3. **Desativar IPv6 no NetworkManager** (caso esteja em uso)  
   Edite o arquivo de configuração do NetworkManager e defina IPv6 como "ignore".

4. **Reiniciar o sistema**  
   Após as alterações, reinicie o sistema para garantir que elas sejam aplicadas corretamente.

___
## Desativar IPv6 no NetworkManager

No Debian sem interface gráfica, você pode configurar o NetworkManager para ignorar o IPv6 editando os arquivos de configuração manualmente. Aqui está como fazer:

1. **Edite o arquivo de configuração do NetworkManager:**  
   ```
   sudo nano /etc/NetworkManager/conf.d/disable-ipv6.conf
   ```
   
2. **Adicione as seguintes linhas ao arquivo:**  
   ```
   [connection]
   ipv6.method=ignore
   ```
   
3. **Salve e saia do editor (`Ctrl+X`, `Y`, `Enter`).**  

4. **Reinicie o NetworkManager para aplicar as mudanças:**  
   ```
   sudo systemctl restart NetworkManager
   ```

Isso garantirá que o IPv6 seja ignorado nas conexões gerenciadas pelo NetworkManager. Se precisar configurar uma interface específica, você pode editar os arquivos dentro de `/etc/NetworkManager/system-connections/`.
