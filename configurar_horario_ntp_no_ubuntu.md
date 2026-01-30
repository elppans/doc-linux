# Configuração de horário NTP (Network Time Protocol) no Debian/Ubuntu

### Configurar NTP utilizando pacote ntpdate no PDV Ubuntu

Antes de tudo, remova os repositórios DEV do PDV Ubuntu 22 e os que não funcionam atualmente.

```bash
rm -rf /etc/apt/sources.list.d/*
sed -i '/archive.canonical.com/d' /etc/apt/sources.list
apt update
```

Verifique se o pacote ntpdate (legado e nativo) está instalado

Se estiver instalado, siga os comandos a seguir para configurar a sincronização do horário via Internet.

Se não estiver instalado, é recomendado que instale o Chrony

### A seguir, siga as instruções para a configuração

Deve fazer os comandos usando um Super Usuário (root) ou sudo

- 1. Ajustar o fuso horário correto para o sistema, se necessário.

```bash
timedatectl set-timezone "America/Recife"
```

---

- 2. Usando **ntpdate** (sistemas legados), verifique se está instalado

```bash
dpkg -l ntpdate | grep ^ii
```

Instale, se necessário. (Recomendado utilizar o Chrony - Item 3)

```bash
apt install ntpdate -y
```

Para configurar sincronização, deve ajustar para usar configuração NTP:

```bash
sed -i 's/NTPDATE_USE_NTP_CONF=no/NTPDATE_USE_NTP_CONF=yes/' /etc/default/ntpdate
```

Sincronizar com servidores brasileiros manualmente:

```bash
ntpdate a.ntp.br b.ntp.br c.ntp.br
```

- Atualizar o relógio de hardware:

```bash
sudo hwclock -w
```

- Confirmar:

```bash
timedatectl
date
```

---

### Configurar NTP utilizando pacote Chrony no PDV Ubuntu

- 3. Instale o **Chrony** (recomendado)

```bash
sudo apt install chrony -y
```

Configurar relógio para desativar o RTC e ativar o NTP

```bash
sudo timedatectl set-local-rtc 0 --adjust-system-clock
sudo timedatectl set-ntp 1
```

Reinicie o sistema e após iniciar, faça estes comandos para testar e verificar o status

```bash
systemctl status chrony
chronyc tracking
timedatectl
date
```

- Opcional. Se quiser, sincronize manualmente com servidores atômicos

```bash
chronyc sources
```

---

### Qual a diferença?

- **ntpdate** → Aplicativo antigo e não recomendado em sistemas novos, mas ainda pode ser útil em ambientes legados.
- **Chrony** → Aplicativo moderno, eficiente e substitui o `ntpdate` em sistemas atuais. Recomendado para novos ambientes, mais confiável e mantido.
