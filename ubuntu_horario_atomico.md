# Configurar o Ubuntu para utilizar links de horário atomico para manter a hora sincronizada

- Links utilizados:
pool.ntp.br a.st1.ntp.br b.st1.ntp.br c.st1.ntp.br d.st1.ntp.br a.ntp.br b.ntp.br c.ntp.br gps.ntp.br

Você pode configurar o Ubuntu para sincronizar a hora com esses servidores NTP modificando o arquivo de configuração do `systemd-timesyncd` ou do `chrony`.

Se estiver usando `systemd-timesyncd`, siga estes passos:

1. Edite o arquivo de configuração:
   ```bash
   sudo nano /etc/systemd/timesyncd.conf
   ```
2. Adicione ou edite a seção `[Time]` com seus servidores NTP:
   ```ini
   [Time]
   NTP=pool.ntp.br a.st1.ntp.br b.st1.ntp.br c.st1.ntp.br d.st1.ntp.br a.ntp.br b.ntp.br c.ntp.br gps.ntp.br
   ```
3. Salve e saia (`Ctrl + X`, `Y`, `Enter`).
4. Reinicie o serviço:
   ```bash
   sudo systemctl restart systemd-timesyncd
   ```
5. Verifique o status:
   ```bash
   timedatectl status
   ```

Se estiver usando `chrony`, siga estes passos:

1. Edite o arquivo de configuração:
   ```bash
   sudo nano /etc/chrony/chrony.conf
   ```
2. Adicione seus servidores NTP:
   ```bash
   server pool.ntp.br iburst
   server a.st1.ntp.br iburst
   server b.st1.ntp.br iburst
   server c.st1.ntp.br iburst
   server d.st1.ntp.br iburst
   server a.ntp.br iburst
   server b.ntp.br iburst
   server c.ntp.br iburst
   server gps.ntp.br iburst
   ```
3. Salve e saia (`Ctrl + X`, `Y`, `Enter`).
4. Reinicie o serviço:
   ```bash
   sudo systemctl restart chronyd
   ```
5. Verifique o status:
   ```bash
   chronyc sources -v
   ```

___

## Outras Opções no `systemd-timesyncd.conf`:

- **FallbackNTP**: Define um servidor NTP de fallback, que será usado caso os servidores principais não estejam acessíveis. No caso do Ubuntu, `ntp.ubuntu.com` é a opção padrão.

- **RootDistanceMaxSec**: Especifica a distância máxima aceitável (em segundos) entre o servidor NTP e o relógio da máquina local. Se o tempo do servidor NTP tiver uma diferença maior do que esse valor, ele será considerado inválido.

- **PollIntervalMinSec**: Define o intervalo mínimo (em segundos) para que o `timesyncd` consulte os servidores NTP. Um valor menor pode ajudar a manter a hora mais precisa, mas pode aumentar o tráfego de rede.

- **PollIntervalMaxSec**: Especifica o intervalo máximo (em segundos) entre as consultas ao servidor NTP. Esse limite garante que a sincronização ocorra regularmente, mesmo em condições de rede instáveis.

Essas configurações ajudam a equilibrar a precisão da sincronização da hora com o uso de recursos da máquina e da rede. Quer ajustar alguma dessas opções ou entender outras configurações?
___

## Configuração recomendada no `systemd-timesyncd.conf`:

A configuração recomendada pode depender do ambiente em que o Ubuntu está rodando. Se você precisa de alta precisão na sincronização da hora, pode ajustar alguns desses parâmetros para melhor desempenho. Aqui está uma configuração equilibrada para a maioria dos casos:

```ini
[Time]
NTP=pool.ntp.br a.st1.ntp.br b.st1.ntp.br c.st1.ntp.br d.st1.ntp.br a.ntp.br b.ntp.br c.ntp.br gps.ntp.br
FallbackNTP=ntp.ubuntu.com
RootDistanceMaxSec=1.5
PollIntervalMinSec=16
PollIntervalMaxSec=1024
```

**Explicação das escolhas:**
- **FallbackNTP** mantém o servidor padrão caso todos os principais falhem.
- **RootDistanceMaxSec=1.5** restringe a distância aceitável para garantir maior precisão.
- **PollIntervalMinSec=16** reduz o tempo mínimo entre verificações, mantendo a atualização da hora mais frequente.
- **PollIntervalMaxSec=1024** evita sincronizações excessivamente espaçadas, garantindo atualizações regulares sem sobrecarregar a rede.

Se seu sistema for crítico para sincronização de tempo (como servidores financeiros ou de telecomunicações), pode ser interessante reduzir ainda mais `RootDistanceMaxSec` e `PollIntervalMinSec`.
