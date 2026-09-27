# Ocultar usuário da tela de login

Isso acontece porque o `ftpuser` tem um shell de login válido e UID normal (≥1000), então o gerenciador de login o lista como "usuário comum". Duas formas de resolver, dependendo do que causou isso:

**Opção 1 — Trocar o shell para nologin (mais simples e recomendado para conta de serviço tipo FTP)**

```bash
sudo usermod -s /usr/sbin/nologin ftpuser
```

GDM, SDDM e LightDM, por padrão, ocultam usuários cujo shell é `/usr/sbin/nologin` ou `/bin/false`. Como `ftpuser` não deveria logar interativamente mesmo, isso é o ideal.

**Opção 2 — Marcar como conta de sistema via AccountsService (funciona em qualquer DM)**

```bash
sudo mkdir -p /var/lib/AccountsService/users
sudo tee /var/lib/AccountsService/users/ftpuser > /dev/null <<EOF
[User]
SystemAccount=true
EOF
```

Depois reinicie o serviço:
```bash
sudo systemctl restart accounts-daemon
```

**Se quiser garantir dos dois lados**, faça as duas coisas — trocar o shell e marcar `SystemAccount=true`. Só tome cuidado: se o FTP daemon precisar que o usuário tenha um shell "válido" para autenticação (alguns servidores FTP checam `/etc/shells`), adicione `/usr/sbin/nologin` à lista com:

```bash
echo "/usr/sbin/nologin" | sudo tee -a /etc/shells
```

---

## Se Fizer a opção 1, o diretório FTP configurado é acessível?

Sim, tranquilo — o shell `nologin` só bloqueia login interativo (SSH, `su`, TTY), mas **não interfere no FTP**, porque servidores FTP (vsftpd, proftpd, pure-ftpd etc.) não usam o shell do usuário para dar acesso: eles autenticam via PAM/senha e depois fazem o *chroot* diretamente no diretório configurado, sem nunca invocar `/bin/bash` ou similar.

**Único cuidado**: alguns servidores FTP (principalmente o **vsftpd**) usam o módulo PAM `pam_shells.so`, que exige que o shell do usuário esteja listado em `/etc/shells` para permitir o login — é por isso que recomendei antes:

```bash
echo "/usr/sbin/nologin" | sudo tee -a /etc/shells
```

Se você pular esse passo e o seu servidor usar essa checagem, o `ftpuser` pode ser rejeitado no login FTP com algo como "login incorrect" mesmo com senha certa.

**Resumindo o fluxo seguro:**
```bash
sudo usermod -s /usr/sbin/nologin ftpuser
echo "/usr/sbin/nologin" | sudo tee -a /etc/shells
```

Depois é só testar o login FTP normalmente — se autenticar e cair no diretório configurado, está tudo certo.  
