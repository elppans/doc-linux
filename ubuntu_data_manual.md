# Configurar horário MANUAL no Ubuntu.  

> ### **Todos os comandos devem ser feito como Admin/root**
1) Desativar UTC e NTP conf  

```
sudo sed -i 's/UTC=yes/UTC=no/' /etc/default/rcS
echo -e 'UTC=no' | sudo tee -a /etc/default/rcS
sudo sed -i 's/NTPDATE_USE_NTP_CONF=yes/NTPDATE_USE_NTP_CONF=no/' /etc/default/ntpdate
```

2) Timezone São Paulo:  

```
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
echo -e 'America/Sao_Paulo' | tee /etc/timezone >> /dev/null ; dpkg-reconfigure -f noninteractive tzdata ; hwclock -w
```

3) Setar RTC, NTP, LO, TZ  

```
timedatectl set-local-rtc 0
timedatectl set-ntp 0
timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl set-timezone  "America/Sao_Paulo"
```

4) Corrigir horario usando NTPD  

```
ntpdate a.ntp.br
```

5) Configurar horário manualmente +1H  
> date -u = faz o sistema mostrar a data sem o TimeZone aplicado  

```
date -s "$(expr $(date +%H) + 1)":"$(date +%M)":"$(date +%S)" && hwclock -w
```

6) Matar PDV para subir novamente  

```
pkill -9 [Jj]av && pkill -9 lnx
```
# Voltar horário AUTOMÁTICO no Ubuntu.

```
sudo sed -i 's/UTC=no/UTC=yes/' /etc/default/rcS && \
sudo sed -i 's/NTPDATE_USE_NTP_CONF=no/NTPDATE_USE_NTP_CONF=yes/' /etc/default/ntpdate && \
ln -sf /usr/share/zoneinfo/America/Recife /etc/localtime && \
echo -e 'America/Recife' | tee /etc/timezone >> /dev/null ; dpkg-reconfigure -f noninteractive tzdata ; hwclock -w && \
timedatectl set-local-rtc 1 && \
timedatectl set-ntp 1 && \
timedatectl set-timezone  "America/Recife" && \
ntpdate a.ntp.br && \
hwclock -w
```

#### Fontes:  
[Sync Timezone Ubuntu/Windows](https://www.edivaldobrito.com.br/como-corrigir-diferencas-de-tempo-entre-o-ubuntu-e-o-windows-em-sistema-com-dual-boot/)  
[date CMD](https://paulosantanna.com/2017/03/01/configuracoes-de-data-e-hora-via-terminal-no-linux/)  
