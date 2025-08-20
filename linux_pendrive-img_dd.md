# Clonar um Pendrive de Boot para arquivo de imagem

Para fazer uma cópia binária (bit a bit) de um pendrive de boot no Linux — como um instalador de sistema operacional — o comando mais direto e confiável é o `dd`. Ele copia exatamente todos os dados, incluindo a tabela de partições e o setor de boot.

### 🧠 Comando básico com `dd`

```bash
sudo dd if=/dev/sdX of=~/pendrive_backup.img bs=4M status=progress
```

### 🛠️ Explicação dos parâmetros:
- `if=`: **input file** — o dispositivo de origem (ex: `/dev/sdX`, onde `X` é a letra do pendrive)
- `of=`: **output file** — o caminho e nome do arquivo de imagem que será criado
- `bs=4M`: define o tamanho do bloco para leitura/escrita (4 megabytes é um bom valor para velocidade)
- `status=progress`: mostra o progresso da cópia

> ⚠️ **Atenção**: Certifique-se de identificar corretamente o pendrive com `lsblk` ou `fdisk -l` antes de executar o comando. Um erro aqui pode sobrescrever seu disco rígido.

### 🔄 Para restaurar a imagem no futuro:
```bash
sudo dd if=~/pendrive_backup.img of=/dev/sdX bs=4M status=progress
```
