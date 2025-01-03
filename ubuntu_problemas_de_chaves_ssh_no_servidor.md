# Ubuntu, Problemas de Chaves SSH no Servidor

___
### "Erro ao Carregar Chaves SSH do Host"
### "Falha na Geração de Chaves SSH"
___

## Comando para iniciar o serviço SSH

```bash
systemctl start ssh
```
## Comando para verificar o status do serviço SSH

```bash
systemctl status ssh
```

## Saída do comando systemctl status ssh

```bash
ssh.service - OpenBSD Secure Shell server
   Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
   Active: active (running) since Sex 2025-01-03 10:54:15 -03; 44min ago
   Process: 870 ExecStartPre=/usr/sbin/sshd -t (code=exited, status=0/SUCCESS)
   Main PID: 901 (sshd)
      CGroup: /system.slice/ssh.service
              └─901 /usr/sbin/sshd -D

## Mensagens de erro indicando problemas ao carregar as chaves do host e algoritmos de troca de chaves
Jan 03 11:37:54 InstaladorPDV sshd[3635]: error: Could not load host key: /etc/ssh/ssh_host_dsa_key
Jan 03 11:37:54 InstaladorPDV sshd[3635]: error: Could not load host key: /etc/ssh/ssh_host_ecdsa_key
Jan 03 11:38:42 InstaladorPDV systemd[1]: Started OpenBSD Secure Shell server.
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: key_load_public: invalid format
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: Could not load host key: /etc/ssh/ssh_host_rsa_key
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: key_load_public: invalid format
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: Could not load host key: /etc/ssh/ssh_host_dsa_key
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: Could not load host key: /etc/ssh/ssh_host_ecdsa_key
Jan 03 11:38:42 InstaladorPDV sshd[3621]: error: Could not load host key: /etc/ssh/ssh_host_ed25519_key
Jan 03 11:38:42 InstaladorPDV sshd[3621]: fatal: No supported key exchange algorithms [preauth]
```
___

# Solução para Carregar Chaves SSH do Host

Parece que você está enfrentando problemas com o serviço SSH no seu sistema Linux. Aqui estão alguns passos que você pode seguir para resolver os erros:

1. **Verifique a presença das chaves do host:**
   Verifique se as chaves do host estão presentes no diretório `/etc/ssh/`:

   ```sh
   ls /etc/ssh/ssh_host_*
   ```

   Se algumas das chaves (por exemplo, `ssh_host_dsa_key`, `ssh_host_ecdsa_key`, `ssh_host_rsa_key`, `ssh_host_ed25519_key`) estiverem faltando, você precisará gerá-las novamente.

2. **Gerar novas chaves do host:**
   Use o comando `ssh-keygen` para gerar novas chaves do host. Por exemplo:

   ```sh
   sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
   sudo ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
   sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
   sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
   ```

   Siga as instruções para gerar novas chaves do host.

3. **Corrigir permissões dos arquivos de chave:**
   Verifique se as permissões dos arquivos de chave estão corretas. As permissões corretas são:

   ```sh
   sudo chmod 600 /etc/ssh/ssh_host_*
   sudo chown root:root /etc/ssh/ssh_host_*
   ```

4. **Reiniciar o serviço SSH:**
   Depois de corrigir os problemas com as chaves do host, reinicie o serviço SSH:

   ```sh
   sudo systemctl restart ssh
   ```

5. **Verificar o status do serviço SSH:**
   Verifique se o serviço SSH está funcionando corretamente:

   ```sh
   sudo systemctl status ssh
   ```

Esses passos devem ajudar a resolver os erros relacionados às chaves do host e permitir que o serviço SSH funcione corretamente.
