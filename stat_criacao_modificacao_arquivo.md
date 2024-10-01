Data de criação e modificação de um arquivo no Linux

Para verificar a data de criação e modificação de um arquivo no Linux, você pode usar o comando **`stat`**.  
Este comando fornece informações detalhadas sobre o arquivo, incluindo as datas de criação, modificação e acesso.

Aqui está um exemplo de como usar o `stat`:

```bash
stat nome_do_arquivo
```

A saída incluirá algo assim:

```plaintext
  File: nome_do_arquivo
  Size: 1234       Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d Inode: 12345678    Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/  user)   Gid: ( 1000/  user)
Access: 2024-10-01 10:00:00.000000000 -0300
Modify: 2024-09-30 15:00:00.000000000 -0300
Change: 2024-09-30 15:00:00.000000000 -0300
 Birth: 2024-09-29 12:00:00.000000000 -0300
```

- **Access**: Última vez que o arquivo foi acessado.
- **Modify**: Última vez que o conteúdo do arquivo foi modificado.
- **Change**: Última vez que os metadados do arquivo foram alterados.
- **Birth**: Data de criação do arquivo (nem todos os sistemas de arquivos suportam essa informação).
