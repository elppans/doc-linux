# Erro AER no Ubuntu: Solução

- Ao ligar o Notebook:
<img width="913" height="583" alt="image" src="https://github.com/user-attachments/assets/c1a4775b-e44a-486d-ab22-e6c95ab207d6" />

Esse erro de **AER (Advanced Error Reporting)** é basicamente o kernel do Linux sendo informando sobre pequenos erros de comunicação em uma porta PCIe.  
Geralmente, isso acontece por causa de alguma incompatibilidade de gerenciamento de energia ou firmware, muito comum em placas de rede Wi-Fi ou SSDs NVMe.

### 1. Acesso Temporário (Para conseguir logar)
Se o sistema estiver travado nessa tela, você precisará forçar um parâmetro no boot:

1.  Reinicie o notebook.
2.  No menu do **GRUB** (aquela tela de seleção de sistema), selecione a opção do Ubuntu e aperte a tecla **`e`** para editar.
3.  Localize a linha que começa com `linux`.
4.  Vá até o final dessa linha e adicione o seguinte parâmetro: **`pci=noaer`**
5.  Pressione **Ctrl + X** ou **F10** para iniciar com essa configuração.

### 2. Solução Permanente
Se o sistema iniciou corretamente com o passo acima, vamos fixar essa configuração para não precisar digitar toda vez:

1.  Abra o terminal e edite o arquivo do GRUB:
    ```bash
    sudo nano /etc/default/grub
    ```
2.  Encontre a linha: `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"`
3.  Adicione o parâmetro dentro das aspas, ficando assim:
    `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer"`
4.  Salve o arquivo (**Ctrl + O**, **Enter**) e saia (**Ctrl + X**).
5.  Atualize o GRUB para aplicar as mudanças:
    ```bash
    sudo update-grub
    ```

### 3. Quem é o culpado? (Opcional)
Se você quiser saber exatamente qual peça de hardware está gerando esses alertas, rode este comando no terminal (de acordo com o ID que aparece na tela):

```bash
lspci -v -s 0000:00:1d.0
```

>Se o erro persistir mesmo com `pci=noaer`, você pode tentar substituir por `pci=nomsi`, que desativa as interrupções sinalizadas por mensagem, outra causa comum de "conflito" em notebooks.
___

<img width="747" height="165" alt="image" src="https://github.com/user-attachments/assets/ad98021e-dc41-4d5d-b853-07f868e81592" />

- O `00:1d.0` é apenas a **ponte** (o "porteiro").  
Ele é um **PCI Express Root Port** da Intel, ou seja, um caminho por onde outros componentes se comunicam com o processador.

O erro aparece nele porque ele é quem reporta a falha de comunicação, mas o culpado geralmente é o dispositivo que está "espetado" nessa porta.

Na imagem, diz: `Bus: secondary=01`. Isso significa que qualquer coisa que esteja no **Barramento 01** é o que está causando o log de erro.

Deve rodar este comando no terminal para ver quem está pendurado nessa ponte:

```bash
lspci | grep "01:00"
```

Ou, para ver a "árvore" genealógica completa do seu hardware e identificar visualmente a conexão:

```bash
lspci -t
```

Pelo modelo desse controlador Intel (`34b4`), os suspeitos de costume no barramento secundário costumam ser:
1.  **Placa de Rede Wi-Fi/Bluetooth** (Muito comum dar erro de AER se o driver tentar economizar energia de forma agressiva).
2.  **SSD NVMe** (Alguns modelos têm incompatibilidade com o estado de energia "L1.2").
3.  **Leitor de Cartão SD**.
___

<img width="711" height="341" alt="image" src="https://github.com/user-attachments/assets/a7848b60-f49b-46a8-b315-add33a34723d" />

- A imagem mostra que o erro vem do **SSD NVMe da ADATA**.

Esses controladores da ADATA (e alguns da Lexar/Crucial) têm uma "treta" conhecida com o **ASPM (Active State Power Management)** no Linux. Basicamente, o SSD tenta entrar em um estado de economia de energia muito profundo, a comunicação oscila por um milissegundo, e o kernel entra em pânico reportando o erro via PCIe AER.

O comando `lspci -t`, mostra que a ponte `1d.0` (o "porteiro") está conectada diretamente ao barramento `[01]`, onde mora o SSD `00.0`.

### Como resolver de vez?

Como o SSD está funcionando, esses erros são tecnicamente "corrigíveis", mas o log spam acaba com a performance e lota o seu disco de arquivos de texto inúteis. Você tem duas rotas:

#### Opção A: O mais comum e simples
Apenas ignora as mensagens de erro do barramento.
* Adicione **`pci=noaer`** aos parâmetros do GRUB.

#### Opção B: Melhor para a saúde do SSD
Evita que o NVMe entre no estado de sono que causa o erro. Isso pode consumir um pouquinho mais de bateria, mas estabiliza a conexão.
* Adicione **`nvme_core.default_ps_max_latency_us=0`** aos parâmetros do GRUB.

### Aplicando a correção:

1.  No terminal, abra o configurador do GRUB:
    ```bash
    sudo nano /etc/default/grub
    ```
2.  Localize a linha `GRUB_CMDLINE_LINUX_DEFAULT`. Deixe-a assim (pode colocar os dois parâmetros para garantir):
    `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash pci=noaer nvme_core.default_ps_max_latency_us=0"`
3.  Salve (**Ctrl+O**, **Enter**) e saia (**Ctrl+X**).
4.  Atualize o sistema de boot:
    ```bash
    sudo update-grub
    ```
5.  Reinicie o note.
___

## Limpando os logs deixado pelo aviso de erro

<img width="358" height="197" alt="image" src="https://github.com/user-attachments/assets/bad94012-a417-45cb-a1d8-8f6b9048fbca" />

Somando os logs da imagem, são **35GB** de logs! O SSD estava praticamente escrevendo uma enciclopédia sobre o mesmo erro a cada segundo. Esses arquivos são apenas registros de texto e não vão afetar o funcionamento do sistema (na verdade, o sistema vai até agradecer o espaço livre).

### 1. Limpando o Journal (Logs do Sistema)
O diretório `/var/log/journal` está ocupando 4GB. Em vez de deletar as pastas manualmente, use o comando próprio do sistema para limpar tudo o que for mais antigo que 1 segundo:

```bash
sudo journalctl --vacuum-time=1s
```

### 2. Deletando os arquivos antigos (Rotacionados)
Os arquivos que terminam em `.1` ou `.gz` (como o `syslog.1` de 13GB!) são versões antigas que o sistema guardou. Pode deletar todos de uma vez:

```bash
sudo rm /var/log/*.1 /var/log/*.gz
```

### 3. Zerando os logs ativos
Os arquivos `syslog` e `kern.log` (os que não têm número no final) estão sendo usados no momento. Se deletar o arquivo com `rm`, o sistema pode continuar "escrevendo no vácuo" e não liberar o espaço. O ideal é **esvaziar** o conteúdo deles:

```bash
sudo truncate -s 0 /var/log/syslog /var/log/kern.log
```
___
