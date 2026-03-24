# SystemD: Verificando Serviços Agendados

No mundo do SystemD, se algo está agendado para rodar em um horário específico, ele geralmente é controlado por um **Timer**. Pense neles como o substituto moderno (e mais robusto) do antigo `cron`.

---

### 1. Listar todos os timers ativos
O comando mais direto para ver o que está agendado agora é:

```bash
systemctl list-timers
```

Este comando vai te mostrar uma tabela bem organizada com:
* **NEXT:** Quando será a próxima execução.
* **LEFT:** Quanto tempo falta.
* **LAST:** Quando foi a última vez que rodou.
* **PASSED:** Quanto tempo passou desde a última execução.
* **UNIT:** O nome do arquivo `.timer`.
* **ACTIVATES:** O serviço (`.service`) que ele de fato executa.

### 2. Verificar a configuração do horário
Se você encontrou um timer suspeito e quer saber a regra exata (ex: "toda segunda-feira às 3 da manhã"), você pode inspecionar o arquivo de configuração:

```bash
systemctl cat nome-do-serviço.timer
```

Procure pela linha que começa com `OnCalendar=`. É ali que a "mágica" do horário acontece.

### 3. Olhar o histórico de execuções (Logs)
Se você quer saber se um serviço *específico* rodou em um horário que já passou:

```bash
journalctl -u nome-do-serviço.service --since "today"
```
*Dica: Isso ajuda a confirmar se o serviço realmente completou a tarefa ou se deu erro no meio do caminho.*
---

### Diferença Visual: Cron vs. SystemD Timers
Diferente do Cron, que é apenas uma tabela de texto, o SystemD separa o **agendador** (timer) da **execução** (service).

---

### Como saber se NÃO é um timer?
Alguns serviços não usam timers, mas sim lógica interna (como um banco de dados que faz backup por conta própria). Nesses casos:
1.  Verifique o status do serviço: `systemctl status nome.service`.
2.  Veja se ele está como `active (running)` constantemente. Se estiver, ele pode ter um agendador interno.
___
