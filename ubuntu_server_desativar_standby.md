# Ubuntu Server, desativar Standby

Para desativar o modo de suspensão no seu servidor Ubuntu, você pode seguir os seguintes passos:

1. **Abra o terminal** (Ctrl+Alt+T) e execute o comando abaixo para editar o arquivo de configuração do systemd:
   ```bash
   sudo nano /etc/systemd/sleep.conf
   ```

2. **Adicione ou edite as seguintes linhas** no arquivo, removendo o `#` no início das linhas, se necessário:
   ```ini
   [Sleep]
   AllowSuspend=no
   AllowHibernation=no
   AllowSuspendThenHibernate=no
   AllowHybridSleep=no
   ```

3. **Salve as alterações** e saia do editor de texto (Ctrl+O para salvar e Ctrl+X para sair).

4. **Reinicie o serviço systemd-logind** para aplicar as alterações:
   ```bash
   sudo systemctl restart systemd-logind
   ```

Isso deve desativar o modo de suspensão no seu servidor Ubuntu.  
___
Foi criado um Script para facilitar a configuração, se optar no uso, acesse: [linux-standby-off](https://github.com/elppans/linux-standby-off)  
___
- Fontes:

[How to Completely Disable Suspend/Hibernate in Ubuntu 24.04 | 22.04](https://ubuntuhandbook.org/index.php/2024/10/completely-disable-suspend-hibernate/)  
[Como desativar o modo de suspensão e definir as configurações de ...](http://site.joelti.com.br/como-desativar-o-modo-de-suspensao-e-definir-as-configuracoes-de-energia-da-tampa-para-ubuntu-ou-red-hat-linux-7-para-notebooks-dell/)  
