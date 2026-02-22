# Guia Rápido: Crontab no Linux

O Cron é um utilitário do sistema que permite agendar tarefas (scripts ou comandos) para serem executados automaticamente em intervalos específicos.

1. Onde as configurações ficam guardadas?
Existem dois locais principais, e é comum confundir os dois:

• Crontab de Usuário: Quando você usa o comando `crontab -e` (ou via [Webmin](https://webmin.com/) para um usuário), o arquivo fica em `/var/spool/cron/crontabs/<usuario>`.

  • Nota: Para ver o do root, use `sudo crontab -l`.

• Crontab do Sistema: É o arquivo físico `/etc/crontab`. Ele é usado para tarefas globais do sistema e possui uma coluna extra para especificar o usuário que executará o comando.

2. Anatomia do Tempo (Os 5 Asteriscos)
A sintaxe segue esta ordem: `minuto hora dia_do_mes mes dia_da_semana comando`

Exemplos de intervalos:

• `* * * * *` : Executa todo minuto.

• `1 * * * *` : Executa no minuto 1 de cada hora (ex: 10:01, 11:01).

• `*/5 * * * *` : Executa a cada 5 minutos.

• `0 22 * * *` : Executa todos os dias às 22h.

3. Comandos Úteis
• `crontab -l`: Lista as tarefas do usuário logado.

• `sudo crontab -l`: Lista as tarefas do root.

• `crontab -e`: Edita as tarefas.

• `tail -f /var/log/syslog | grep -i cron`: Monitora a execução do cron em tempo real.

4. Dica de Teste
Para testar se o cron está funcionando, use o redirecionamento para um arquivo de log: `* * * * * date >> /tmp/teste_cron.log`
