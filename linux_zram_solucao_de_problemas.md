# Erro no ZRAM: solução de problemas

- O seguinte erro ocorre:
```bash
[arch@archlinux ~]$ sudo systemctl restart systemd-zram-setup@zram0.service
Job for systemd-zram-setup@zram0.service failed because the control process exited with error code.
See "systemctl status systemd-zram-setup@zram0.service" and "journalctl -xeu systemd-zram-setup@zram0.service" for details.
[arch@archlinux ~]$ systemctl status systemd-zram-setup@zram0.service
\C3\97 systemd-zram-setup@zram0.service - Create swap on /dev/zram0
     Loaded: loaded (/usr/lib/systemd/system/systemd-zram-setup@.service; static)
     Active: failed (Result: exit-code) since Sat 2025-03-15 22:03:49 -03; 4s ago
 Invocation: 646d5881cac8410d877c33d0065f3c02
       Docs: man:zram-generator(8)
             man:zram-generator.conf(5)
    Process: 2062 ExecStart=/usr/lib/systemd/system-generators/zram-generator --setup-device zram0 (code=exited, status=1/FAILURE)
   Main PID: 2062 (code=exited, status=1/FAILURE)
   Mem peak: 1.4M
        CPU: 5ms

mar 15 22:03:49 archlinux systemd[1]: Starting Create swap on /dev/zram0...
mar 15 22:03:49 archlinux zram-generator[2062]: Error: Failed to configure compression algorithm into /sys/block/zram0/comp_algorithm
mar 15 22:03:49 archlinux zram-generator[2062]: Caused by:
mar 15 22:03:49 archlinux zram-generator[2062]:     No such file or directory (os error 2)
mar 15 22:03:49 archlinux systemd[1]: systemd-zram-setup@zram0.service: Main process exited, code=exited, status=1/FAILURE
mar 15 22:03:49 archlinux systemd[1]: systemd-zram-setup@zram0.service: Failed with result 'exit-code'.
mar 15 22:03:49 archlinux systemd[1]: Failed to start Create swap on /dev/zram0.
[arch@archlinux ~]$ cat /etc/systemd/zram-generator.conf
[zram0]
zram-size = 2G  
compression-algorithm = zstd  
swap-priority = 100
```
O erro ao tentar iniciar o serviço `systemd-zram-setup@zram0.service` está relacionado à configuração do algoritmo de compressão no dispositivo ZRAM. O erro específico indica que o sistema não consegue encontrar o arquivo `/sys/block/zram0/comp_algorithm`, o que pode ser causado por vários motivos.

Aqui estão algumas etapas para solucionar o problema:

### 1. Verifique se o módulo ZRAM está carregado
O ZRAM é um módulo do kernel, e ele precisa estar carregado para que o dispositivo ZRAM funcione corretamente. Verifique se o módulo está carregado com o seguinte comando:

```bash
lsmod | grep zram
```

Se não houver saída, o módulo não está carregado. Você pode carregá-lo manualmente com:

```bash
sudo modprobe zram
```

### 2. Verifique se o dispositivo ZRAM está disponível
Após carregar o módulo, verifique se o dispositivo ZRAM está disponível:

```bash
ls /dev/zram*
```

Se não houver nenhum dispositivo ZRAM listado, pode haver um problema com o módulo ou com o kernel.

### 3. Verifique o algoritmo de compressão suportado
O erro menciona que o sistema não consegue configurar o algoritmo de compressão. Verifique quais algoritmos de compressão são suportados pelo seu kernel:

```bash
cat /sys/block/zram0/comp_algorithm
```

Se o arquivo não existir, o dispositivo ZRAM pode não ter sido criado corretamente. Se o arquivo existir, verifique se `zstd` está listado como um algoritmo suportado. Se não estiver, você precisará escolher outro algoritmo de compressão suportado, como `lzo`, `lz4`, etc.

### 4. Atualize a configuração do ZRAM
Se o algoritmo `zstd` não for suportado, você pode alterar o algoritmo de compressão no arquivo de configuração `/etc/systemd/zram-generator.conf` para um que seja suportado. Por exemplo:

```ini
[zram0]
zram-size = 2G
compression-algorithm = lzo
swap-priority = 100
```

### 5. Reinicie o serviço ZRAM
Após fazer as alterações necessárias, reinicie o serviço ZRAM:

```bash
sudo systemctl restart systemd-zram-setup@zram0.service
```

### 6. Verifique os logs
Se o problema persistir, verifique os logs para obter mais detalhes:

```bash
journalctl -xeu systemd-zram-setup@zram0.service
```

Isso deve fornecer mais informações sobre o que está causando a falha.

### 7. Verifique a versão do kernel e do `zram-generator`
Certifique-se de que você está usando uma versão do kernel e do `zram-generator` que suporta o algoritmo `zstd`. Se necessário, atualize o kernel e o `zram-generator`.

### 8. Verifique se o sistema de arquivos `/sys` está montado corretamente
O diretório `/sys` é um sistema de arquivos virtual que o kernel usa para expor informações sobre dispositivos e configurações. Certifique-se de que ele está montado corretamente:

```bash
mount | grep sysfs
```

Se não estiver montado, você pode montá-lo manualmente com:

```bash
sudo mount -t sysfs sysfs /sys
```

### Resumo
- Verifique se o módulo `zram` está carregado.
- Verifique se o dispositivo ZRAM está disponível.
- Verifique os algoritmos de compressão suportados.
- Atualize a configuração do ZRAM se necessário.
- Reinicie o serviço ZRAM.
- Verifique os logs para mais detalhes.

Se seguir esses passos, você deverá conseguir identificar e resolver o problema com o ZRAM.
___
## [Módulo ZRAM](linux_zram_solucao_de_problemas.md#sobre-os-m%C3%B3dulos-listados-anteriormente)
```bash
[arch@archlinux ~]$ lsmod | grep zram
[arch@archlinux ~]$ sudo modprobe zram
[arch@archlinux ~]$ lsmod | grep zram
zram                   61440  0
842_decompress         20480  1 zram
842_compress           24576  1 zram
lz4hc_compress         20480  1 zram
lz4_compress           24576  1 zram
```
O módulo `zram` foi carregado com sucesso após executar o comando `sudo modprobe zram`. Agora que o módulo está ativo, podemos prosseguir com a solução do problema.

### Próximos passos:

#### 1. Verifique se o dispositivo ZRAM foi criado
Agora que o módulo está carregado, o kernel deve criar automaticamente dispositivos ZRAM. Verifique se o dispositivo `/dev/zram0` está disponível:

```bash
ls /dev/zram*
```

Se o dispositivo `/dev/zram0` aparecer, prossiga para o próximo passo. Caso contrário, pode haver um problema com a criação automática do dispositivo.

#### 2. Verifique os algoritmos de compressão suportados
O erro que você encontrou anteriormente indicava que o sistema não conseguiu configurar o algoritmo de compressão `zstd`. Verifique quais algoritmos de compressão estão disponíveis para o dispositivo ZRAM:

```bash
cat /sys/block/zram0/comp_algorithm
```

Isso deve retornar uma lista de algoritmos suportados, como `lzo`, `lz4`, `zstd`, etc. Se `zstd` não estiver listado, você precisará escolher outro algoritmo suportado.

#### 3. Atualize a configuração do ZRAM
Se o algoritmo `zstd` não for suportado, edite o arquivo de configuração `/etc/systemd/zram-generator.conf` para usar um algoritmo compatível. Por exemplo, altere para `lzo` ou `lz4`:

```ini
[zram0]
zram-size = 2G
compression-algorithm = lzo  # ou lz4, se preferir
swap-priority = 100
```

#### 4. Reinicie o serviço ZRAM
Após atualizar a configuração, reinicie o serviço ZRAM:

```bash
sudo systemctl restart systemd-zram-setup@zram0.service
```

#### 5. Verifique o status do serviço
Verifique se o serviço foi iniciado corretamente:

```bash
systemctl status systemd-zram-setup@zram0.service
```

Se tudo estiver funcionando, você verá algo como:

```
● systemd-zram-setup@zram0.service - Create swap on /dev/zram0
     Loaded: loaded (/usr/lib/systemd/system/systemd-zram-setup@.service; static)
     Active: active (exited) since ...
```

#### 6. Verifique o swap ZRAM
Confirme se o swap ZRAM está ativo:

```bash
swapon --show
```

Você deve ver uma entrada para `/dev/zram0` com o tamanho e prioridade configurados.

#### 7. Verifique os logs (se necessário)
Se o serviço ainda falhar, verifique os logs para obter mais detalhes:

```bash
journalctl -xeu systemd-zram-setup@zram0.service
```

Isso pode fornecer informações adicionais sobre o que está causando o problema.

### Resumo
- O módulo `zram` foi carregado com sucesso.
- Verifique se o dispositivo `/dev/zram0` foi criado.
- Confira os algoritmos de compressão suportados e ajuste a configuração, se necessário.
- Reinicie o serviço e verifique se o swap ZRAM está ativo.

Se seguir esses passos, o ZRAM deve funcionar corretamente. Se ainda houver problemas, pode ser necessário investigar mais a fundo, como verificar a versão do kernel ou do `zram-generator`.  
___
## Algorítmo
```bash
at /sys/block/zram0/comp_algorithm
lzo-rle lzo lz4 lz4hc [zstd] deflate 842
```
O arquivo `/sys/block/zram0/comp_algorithm` mostra que o algoritmo `zstd` está disponível e suportado pelo seu kernel, pois ele está entre colchetes (`[zstd]`), indicando que é o algoritmo atualmente selecionado. Isso significa que o problema não está relacionado à falta de suporte ao `zstd`.

Vamos revisar o problema e tentar identificar a causa raiz:

---

### Possíveis causas do erro:
1. **Problema de permissões**: O serviço `systemd-zram-setup@zram0.service` pode não ter permissão para acessar ou modificar o arquivo `/sys/block/zram0/comp_algorithm`.
2. **Dispositivo ZRAM não inicializado corretamente**: O dispositivo `/dev/zram0` pode não ter sido configurado corretamente antes de tentar definir o algoritmo de compressão.
3. **Problema no `zram-generator`**: Pode haver um bug ou problema de configuração no `zram-generator` que está impedindo a configuração correta do ZRAM.

---

### Solução passo a passo:

#### 1. Verifique as permissões do `/sys/block/zram0/comp_algorithm`
Verifique as permissões do arquivo `/sys/block/zram0/comp_algorithm`:

```bash
ls -l /sys/block/zram0/comp_algorithm
```

A saída deve ser algo como:

```
-rw-r--r-- 1 root root 4096 Mar 15 22:03 /sys/block/zram0/comp_algorithm
```

Se as permissões estiverem incorretas, você pode ajustá-las temporariamente com:

```bash
sudo chmod 644 /sys/block/zram0/comp_algorithm
```

#### 2. Configure o ZRAM manualmente
Para descartar problemas com o `zram-generator`, tente configurar o ZRAM manualmente:

1. Defina o tamanho do dispositivo ZRAM:

   ```bash
   echo 2G | sudo tee /sys/block/zram0/disksize
   ```

2. Defina o algoritmo de compressão:

   ```bash
   echo zstd | sudo tee /sys/block/zram0/comp_algorithm
   ```

3. Crie o dispositivo de swap:

   ```bash
   sudo mkswap /dev/zram0
   ```

4. Ative o swap:

   ```bash
   sudo swapon /dev/zram0
   ```

5. Verifique se o swap está ativo:

   ```bash
   swapon --show
   ```

Se isso funcionar, o problema está relacionado ao `zram-generator`.

#### 3. Verifique a configuração do `zram-generator`
Confira o arquivo de configuração `/etc/systemd/zram-generator.conf`:

```ini
[zram0]
zram-size = 2G
compression-algorithm = zstd
swap-priority = 100
```

Certifique-se de que o arquivo está formatado corretamente e não contém erros de sintaxe.

#### 4. Reinicie o serviço ZRAM
Após verificar a configuração, reinicie o serviço:

```bash
sudo systemctl restart systemd-zram-setup@zram0.service
```

#### 5. Verifique os logs
Se o serviço ainda falhar, verifique os logs para obter mais detalhes:

```bash
journalctl -xeu systemd-zram-setup@zram0.service
```

Procure por mensagens de erro específicas que possam indicar a causa do problema.

---

### Solução alternativa: Usar `zramctl`
Se o `zram-generator` continuar apresentando problemas, você pode usar a ferramenta `zramctl` para configurar o ZRAM manualmente:

1. Instale o `zramctl` (se ainda não estiver instalado):

   ```bash
   sudo pacman -S util-linux
   ```

2. Configure o ZRAM com `zramctl`:

   ```bash
   sudo zramctl --find --size 2G --algorithm zstd
   ```

   Isso criará um dispositivo ZRAM e retornará seu nome (por exemplo, `/dev/zram0`).

3. Crie e ative o swap:

   ```bash
   sudo mkswap /dev/zram0
   sudo swapon /dev/zram0
   ```

4. Verifique o swap:

   ```bash
   swapon --show
   ```

---

### Resumo
- O algoritmo `zstd` é suportado, então o problema não está relacionado à falta de suporte.
- Verifique permissões e configure o ZRAM manualmente para descartar problemas com o `zram-generator`.
- Se o problema persistir, use `zramctl` como alternativa.

Se seguir esses passos, você deve conseguir resolver o problema com o ZRAM. 
___

## Sobre os [módulos listados anteriormente](linux_zram_solucao_de_problemas.md#m%C3%B3dulo-zram)

Os módulos listados (`842_decompress`, `842_compress`, `lz4hc_compress`, `lz4_compress`) são os algoritmos de compressão que estão atualmente carregados e disponíveis para uso com o ZRAM no seu sistema. Esses módulos correspondem aos algoritmos de compressão que você pode usar no ZRAM.

No seu caso, os algoritmos disponíveis são:

1. **842**: Um algoritmo de compressão usado em alguns dispositivos específicos, como processadores IBM Power.
2. **lz4**: Um algoritmo de compressão rápido e eficiente, amplamente utilizado por seu bom equilíbrio entre velocidade e taxa de compressão.
3. **lz4hc**: Uma variante do `lz4` que prioriza uma taxa de compressão melhor, mas pode ser um pouco mais lenta.

Além desses, o ZRAM também suporta outros algoritmos, como `lzo`, `lzo-rle`, `zstd` e `deflate`, que podem estar disponíveis dependendo da configuração do kernel. No seu caso, você já verificou que `zstd` também está disponível (conforme a saída de `/sys/block/zram0/comp_algorithm`).

---

### Como escolher o algoritmo de compressão?
A escolha do algoritmo de compressão depende do seu uso:

- **Velocidade**: Se você prioriza velocidade de compressão/descompressão, use `lz4` ou `lzo`.
- **Taxa de compressão**: Se você deseja uma melhor taxa de compressão (ou seja, usar menos memória para armazenar os dados comprimidos), use `zstd` ou `lz4hc`.
- **Equilíbrio**: O `zstd` é uma boa escolha para um equilíbrio entre velocidade e taxa de compressão.

---

### Como definir o algoritmo de compressão?
Você pode definir o algoritmo de compressão no arquivo de configuração do ZRAM (`/etc/systemd/zram-generator.conf`). Por exemplo:

```ini
[zram0]
zram-size = 2G
compression-algorithm = lz4  # ou lzo, zstd, lz4hc, etc.
swap-priority = 100
```

Ou, se estiver configurando manualmente, use:

```bash
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
```

---

### Verifique os algoritmos suportados
Você pode verificar todos os algoritmos suportados pelo ZRAM no seu sistema com:

```bash
cat /sys/block/zram0/comp_algorithm
```

No seu caso, a saída foi:

```
lzo-rle lzo lz4 lz4hc [zstd] deflate 842
```

Isso significa que você pode usar qualquer um desses algoritmos.

---

### Resumo
- Os módulos carregados (`842`, `lz4`, `lz4hc`) correspondem aos algoritmos de compressão disponíveis.
- Escolha o algoritmo com base na sua necessidade (velocidade, taxa de compressão ou equilíbrio).
- Defina o algoritmo no arquivo de configuração ou manualmente via `/sys/block/zram0/comp_algorithm`.

