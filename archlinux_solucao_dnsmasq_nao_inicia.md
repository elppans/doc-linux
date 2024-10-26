# Dnsmasq não inicia

Se o `dnsmasq` apresentar um erro ao tentar vincular o socket do servidor DHCP, informando **"endereço já está em uso"**, isso normalmente indica que outro processo está utilizando a mesma porta ou recurso de rede. Abaixo, são apresentados cenários comuns e suas respectivas soluções.

### 1. Outro serviço de DHCP/DNS pode estar ativo

Serviços como **NetworkManager**, **systemd-resolved** ou outros servidores DNS (como `bind` ou `unbound`) podem estar em execução e utilizando as mesmas portas que o `dnsmasq`, causando conflitos.

Para verificar se esses serviços estão ativos, execute:

```bash
sudo systemctl list-units | grep -E 'NetworkManager|resolved|dnsmasq'
```

Se algum serviço estiver ativo e você quiser que o `dnsmasq` seja o principal, desative-o com:

```bash
sudo systemctl stop <nome_do_serviço>
sudo systemctl disable <nome_do_serviço>
```

### 2. Desativar o DNS interno do NetworkManager

Caso o **NetworkManager** esteja gerenciando o DNS, você pode desativar essa funcionalidade para permitir que o `dnsmasq` assuma essa tarefa. Para isso, edite o arquivo `/etc/NetworkManager/NetworkManager.conf` e adicione ou modifique a seguinte linha:

```ini
[main]
dns=none
```

Após realizar essa alteração, reinicie o **NetworkManager**:

```bash
sudo systemctl restart NetworkManager
```

Em seguida, tente reiniciar o `dnsmasq`.
___
# Conflito com o `dnsmasq` do libvirt

Se você utiliza máquinas virtuais com **libvirt** (como no Virt Manager ou QEMU), o serviço `dnsmasq` gerenciado pelo **libvirt** pode estar ocupando as mesmas portas. Para verificar se o `dnsmasq` do **libvirt** está em execução, utilize:

```bash
ps aux | grep dnsmasq
```

Se o `dnsmasq` do **libvirt** aparecer nos resultados, isso pode explicar o erro "endereço já em uso".

#### Soluções para resolver o conflito:

- **Modificar a configuração do `dnsmasq` do libvirt**:  
  Se você precisa usar tanto o **libvirt** quanto o `dnsmasq` para máquinas virtuais, edite o arquivo de configuração do `libvirt dnsmasq`, que geralmente está localizado em `/var/lib/libvirt/dnsmasq/default.conf`, para que utilize uma interface de rede ou porta diferente, evitando conflitos com o `dnsmasq` principal.

### Alterar a porta do DNS do `dnsmasq` no `libvirt`

1. **Abra o editor para a rede padrão**:

   Execute o comando:

   ```bash
   sudo virsh net-edit default
   ```

2. **Adicione a configuração de porta**:

   O comando abrirá um editor de texto com a configuração XML da rede. Adicione uma configuração para a porta desejada, incluindo a seção `<dnsmasq>` se ela não existir:

   ```xml
   <dnsmasq>
       <port>5353</port> <!-- Mude para a porta que você deseja usar -->
   </dnsmasq>
   ```

   Um exemplo de como a configuração pode ficar no contexto do XML:

   ```xml
   <network>
       <name>default</name>
       <uuid>xxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx</uuid>
       <forward mode='nat'/>
       <bridge name='virbr0' stp='on' delay='0'/>
       <dnsmasq>
           <port>5353</port>
       </dnsmasq>
       <ip address='192.168.10.1' netmask='255.255.255.0'>
           <dhcp>
               <range start='192.168.10.2' end='192.168.10.254'/>
               <host mac='52:54:00:xx:xx:xx' name='example' ip='192.168.10.10'/>
           </dhcp>
       </ip>
   </network>
   ```

3. **Salve e saia do editor**.

4. **Reinicie a rede do `libvirt`**:

   Para aplicar as alterações, reinicie a rede:

   ```bash
   sudo virsh net-destroy default
   sudo virsh net-start default
   ```

5. **Verifique se o `dnsmasq` está rodando na nova porta**:

   Utilize o seguinte comando:

   ```bash
   sudo lsof -i :5353
   ```

- **Desativar o `dnsmasq` do `libvirt`**:  
  Se você não estiver utilizando ativamente máquinas virtuais, pode desativar o serviço `dnsmasq` associado ao **libvirt**:

  ```bash
  sudo systemctl stop libvirtd
  sudo systemctl disable libvirtd
  ```

- **Executar o `dnsmasq` em outra interface ou porta**:  
  Se precisar que ambos os serviços coexistam, configure o `dnsmasq` principal para rodar em outra interface de rede ou em uma porta diferente. Edite o arquivo `/etc/dnsmasq.conf` e adicione:

  - Para rodar em uma interface específica (por exemplo, `eth0`):

    ```ini
    interface=eth0
    ```

  - Para usar uma porta diferente:

    ```ini
    port=5353
    ```

  Após as alterações, reinicie o `dnsmasq`:

  ```bash
  sudo systemctl restart dnsmasq
  ```

### 4. Desabilitando o libvirt para usar rede Bridge em outras VMs

Se você está utilizando uma rede Bridge (`br0`) em máquinas virtuais e não precisa do serviço do **libvirt**, pode desativá-lo completamente e usar o `dnsmasq` diretamente:

```bash
sudo systemctl stop libvirtd.socket libvirtd-ro.socket libvirtd-admin.socket
sudo systemctl stop libvirtd.service

sudo systemctl disable libvirtd.socket libvirtd-ro.socket libvirtd-admin.socket
sudo systemctl disable libvirtd.service

sudo killall dnsmasq
ps aux | grep dnsmasq

sudo systemctl start dnsmasq
sudo systemctl status dnsmasq
```
--- 
Para documentar a desativação da rede `default` do **libvirt** no README, você pode seguir uma explicação como a seguinte:

---

### Desativando a Rede `default` do Libvirt e o Serviço dnsmasq

>**Esta configuração é o mais fácil e recomendável**

O **libvirt** utiliza a rede `default` para fornecer funcionalidades de rede virtual, como DNS e DHCP, por meio do serviço **dnsmasq**. No entanto, se o `dnsmasq` não for necessário, ele pode ser desativado ao desativar a rede `default`. Abaixo estão os passos para desativar a rede e evitar que o **dnsmasq** seja iniciado automaticamente:

#### Passos para Desativar a Rede `default`

1. **Desativar a Rede Imediatamente**  
   Para interromper a rede `default` imediatamente, utilize o seguinte comando:
   ```bash
   sudo virsh net-destroy default
   ```
   Isso interrompe a rede `default` e, como consequência, o **dnsmasq** para de rodar.

2. **Desabilitar o Auto-início da Rede `default`**  
   Para garantir que a rede `default` não seja reiniciada automaticamente após uma reinicialização do sistema, desative o **auto-início**:
   ```bash
   sudo virsh net-autostart default --disable
   ```

3. **Verificar o Status da Rede**  
   Para confirmar que a rede `default` está desativada e que o **auto-início** foi desabilitado, execute:
   ```bash
   sudo virsh net-list --all
   ```
   A saída deve mostrar que a rede `default` está **inativa** e o campo **Auto-iniciar** deve estar marcado como `não`.

4. **Confirmar que o dnsmasq Está Desativado**  
   Com a rede `default` desativada, o **dnsmasq** não deve mais estar em execução. Verifique com:
   ```bash
   ps aux | grep dnsmasq
   ```
   Se **dnsmasq** não aparecer na lista, ele foi desativado com sucesso.

#### Nota
Para reativar a rede `default` e o **dnsmasq** no futuro, basta executar:

```bash
sudo virsh net-start default
sudo virsh net-autostart default --enable
```

---
