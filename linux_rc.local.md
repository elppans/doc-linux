# Guia de Configuração: rc.local no Systemd
`Arquivo: linux_rc.local.md`

## 1. O que é o rc.local?
O `/etc/rc.local` é um script tradicional de sistemas Unix/Linux utilizado para executar comandos personalizados durante a inicialização do sistema. Em distribuições modernas (Debian, Ubuntu), ele foi substituído pelo **systemd**, mas ainda é suportado através de uma camada de compatibilidade.

---

## 2. Requisitos de Funcionamento
Para que o `rc.local` funcione no systemd, três condições devem ser atendidas:

1.  **O arquivo deve existir:** `/etc/rc.local`
2.  **Deve conter o Shebang:** A primeira linha deve ser `#!/bin/bash` ou `#!/bin/sh`.
3.  **Deve ser executável:** ```bash
    sudo chmod +x /etc/rc.local
    ```

---

## 3. Estrutura Padrão Recomendada
O script deve sempre terminar com `exit 0` para sinalizar ao sistema que a execução foi concluída com sucesso.

```bash
#!/bin/bash
# /etc/rc.local

# Seus comandos aqui:
echo "Sistema iniciado em $(date)" >> /tmp/boot_log.txt

exit 0
```

---

## 4. Gerenciamento via Systemd
O systemd utiliza o serviço `rc-local.service` para gerenciar este script.

| Comando | Descrição |
| :--- | :--- |
| `systemctl status rc-local` | Verifica se o script rodou ou se houve erro. |
| `systemctl start rc-local` | Executa os comandos do script imediatamente. |
| `systemctl stop rc-local` | Para o serviço (apenas se `RemainAfterExit=yes`). |

### Status do Serviço:
* **Static:** Significa que o serviço é gerado automaticamente pelo systemd ao detectar o arquivo executável.
* **Enabled-runtime:** O serviço está ativo apenas porque o gerador o encontrou, não por um link manual.
* **Masked:** O serviço foi completamente bloqueado e não iniciará mesmo que o arquivo exista.

---

## 5. Solução de Problemas Comuns

### Erro: "The unit files have no installation config"
Ocorre ao tentar dar `systemctl enable` ou `disable` em um serviço estático. 
* **Solução:** Se precisar desativar, use `sudo systemctl mask rc-local`. Se precisar que ele seja um serviço "oficial", crie um arquivo em `/etc/systemd/system/rc-local.service` com a seção `[Install]`.

### Erro: "Status 1/FAILURE" no log
Geralmente causado por:
1.  Falta do `exit 0` no final do script.
2.  Falta do Shebang (`#!/bin/bash`).
3.  Um comando dentro do script que retornou erro.

