# dnsmasq não inicia

Se o `dnsmasq` reportar um erro ao tentar vincular (bind) o socket do servidor DHCP com a mensagem **"endereço já está em uso"**, isso geralmente indica que outro processo está utilizando a mesma porta ou recurso de rede. Abaixo estão alguns cenários comuns e suas soluções.

### 1. **Outro serviço de DHCP/DNS pode estar ativo**

Serviços como **NetworkManager**, **systemd-resolved** ou outros servidores DNS (como `bind` ou `unbound`) podem estar em execução e utilizando as mesmas portas que o `dnsmasq`, gerando conflito.

Para verificar se esses serviços estão ativos:

```bash
sudo systemctl list-units | grep -E 'NetworkManager|resolved|dnsmasq'
```

Se algum serviço estiver ativo e você deseja que o `dnsmasq` seja o principal, você pode desativá-lo com:

```bash
sudo systemctl stop <nome_do_serviço>
sudo systemctl disable <nome_do_serviço>
```

### 2. **Desativar o DNS interno do NetworkManager**

Caso o **NetworkManager** esteja gerenciando o DNS, é possível desativar essa funcionalidade para permitir que o `dnsmasq` assuma esse papel. Para isso, edite o arquivo `/etc/NetworkManager/NetworkManager.conf` e adicione ou modifique a seguinte linha:

```ini
[main]
dns=none
```

Depois de realizar essa alteração, reinicie o **NetworkManager**:

```bash
sudo systemctl restart NetworkManager
```

Agora, tente reiniciar o `dnsmasq`.

### 3. **Conflito com o libvirt dnsmasq**

Se você utiliza máquinas virtuais com o **libvirt** (como no Virt Manager ou QEMU), o serviço `dnsmasq` gerenciado pelo **libvirt** pode estar ocupando as mesmas portas. Para verificar se o `dnsmasq` do **libvirt** está em execução:

```bash
ps aux | grep dnsmasq
```

Se o `dnsmasq` do **libvirt** aparecer no resultado, isso pode explicar o erro de "endereço já em uso".

#### Soluções para resolver o conflito:

- **Modificar a configuração do `dnsmasq` do libvirt**:  
  Caso precise do **libvirt** e do `dnsmasq` para máquinas virtuais, edite o arquivo de configuração do `libvirt dnsmasq` (geralmente encontrado em `/var/lib/libvirt/dnsmasq/default.conf`) para usar uma interface de rede ou porta diferente, evitando conflito com o `dnsmasq` principal.

- **Desativar o `dnsmasq` do `libvirt`**:  
  Se não estiver utilizando ativamente máquinas virtuais, você pode desativar o serviço `dnsmasq` associado ao **libvirt**:

  ```bash
  sudo systemctl stop libvirtd
  sudo systemctl disable libvirtd
  ```

- **Executar o `dnsmasq` em outra interface ou porta**:  
  Se você precisa que ambos os serviços coexistam, configure o `dnsmasq` principal para rodar em outra interface de rede ou em uma porta diferente. Edite o arquivo `/etc/dnsmasq.conf` e adicione:

  - Para rodar em uma interface específica (exemplo: `eth0`):

    ```ini
    interface=eth0
    ```

  - Para usar uma porta diferente:

    ```ini
    port=5353
    ```

  Depois, reinicie o `dnsmasq`:

  ```bash
  sudo systemctl restart dnsmasq
  ```

### 4. **Desabilitando o libvirt para usar rede Bridge em VMs**

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

Essas etapas garantem que o `dnsmasq` principal possa ser executado sem conflitos com o **libvirt** ou outros serviços.

---
