# Find com exclusão de arquivos

- Cenário:
No Ubuntu, usar um find em "`/media/suporte4/EXF/`" para encontrar arquivos de 1 GB pra mais e excluir, ignorando o diretório "`/media/suporte4/EXF/iso/`"

```bash
find /media/suporte4/EXF/ -path /media/suporte4/EXF/iso -prune -o -type f -size +1G -exec rm -v {} \;
```

### Explicação detalhada:

- `-path /media/suporte4/EXF/iso -prune`: ignora o diretório `iso` completamente.
- `-o`: operador "ou", necessário para combinar a exclusão do diretório com a busca dos arquivos.
- `-type f`: garante que apenas arquivos sejam considerados (não diretórios).
- `-size +1G`: seleciona arquivos maiores que 1 gigabyte.
- `-exec rm -v {} \;`: exclui os arquivos encontrados, mostrando cada um com `-v` (verbose).

### Cuidado:

Esse comando **exclui permanentemente** os arquivos. Se quiser testar antes, substitua `rm -v` por `echo` para apenas listar os arquivos que seriam apagados:

```bash
find /media/suporte4/EXF/ -path /media/suporte4/EXF/iso -prune -o -type f -size +1G -exec echo {} \;
```
___

## Ignorar multiplos diretórios

Se você quiser ignorar múltiplos diretórios com `find`, precisa sim especificar cada um usando `-path $dir -prune`, combinando com `-o` (operador lógico "ou"). Mas dá pra deixar isso mais elegante e legível. Aqui vai um exemplo ignorando três diretórios:

```bash
find /media/suporte4/EXF/ \( \
  -path /media/suporte4/EXF/iso -o \
  -path /media/suporte4/EXF/temp -o \
  -path /media/suporte4/EXF/backup \
\) -prune -o -type f -size +1G -exec rm -v {} \;
```

### Explicando a lógica:
- Os diretórios ignorados são agrupados com `\( ... \)` e conectados com `-o`.
- `-prune` impede que o `find` entre nesses diretórios.
- O `-o` depois do `-prune` permite que o restante da expressão seja avaliado (ou seja, buscar os arquivos grandes fora desses diretórios).
- O restante da expressão (`-type f -size +1G -exec ...`) só é executado nos caminhos que não foram ignorados.


