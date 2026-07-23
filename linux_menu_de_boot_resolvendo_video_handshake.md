# Linux, MENU DE BOOT com HandShake

Está tudo configurado e funcionando, mas com um detalhe:

O menu de grub está funcionando, mas por causa da placa mae que faz o inicio do boot do computador ficar com a tela branca, o grub não aparece.  
Dá pra saber que ele está lá, pelo tempo que configurado da espera (25 segundos).

Isso é um problema clássico de **resolução de vídeo (handshake)** entre a placa-mãe e o monitor durante o estágio inicial do boot (o chamado modo VGA). Como a placa-mãe "trava" ou fica com a tela branca, ela não consegue renderizar o menu do GRUB, embora o sistema esteja lá rodando no fundo.

Para resolver isso, você precisa forçar o GRUB a usar um modo de vídeo mais simples ou uma resolução específica que a sua placa-mãe consiga "desenhar" antes de passar o controle para o kernel do Linux.

Aqui estão os passos para tentar fazer o menu aparecer:

---

### 1. Forçar o Modo de Console (Texto)

A primeira tentativa deve ser desativar a interface gráfica do GRUB e usar o modo de texto puro, que é o mais compatível possível.

No Debian:

1. Abra o arquivo de configuração: `sudo nano /etc/default/grub`
2. Encontre a linha: `#GRUB_TERMINAL=console`
3. **Remova o `#`** para descomentar a linha:
   
   ```bash
   GRUB_TERMINAL=console
   ```
4. Salve (`Ctrl+O`, `Enter`) e saia (`Ctrl+X`).
5. Atualize o GRUB: `sudo update-grub`

---

### 2. Definir uma Resolução Fixa (GFXMODE)

Se o modo console não funcionar, pode ser que a placa-mãe precise que você defina exatamente qual resolução ela deve usar.

1. Edite novamente o arquivo: `sudo nano /etc/default/grub`
2. Procure pela linha `GRUB_GFXMODE` (ou adicione se não houver). Tente uma resolução padrão baixa como 800x600 ou 1024x768:
   
   ```bash
   GRUB_GFXMODE=800x600
   GRUB_GFXPAYLOAD_LINUX=keep
   ```
3. Salve e rode `sudo update-grub`.

---

### 3. GRUB_VIDEO_BACKEND

Em algumas máquinas com BIOS problemáticas, o driver de vídeo do GRUB tenta carregar algo complexo demais para o momento. Tente adicionar esta linha também:

```bash
GRUB_VIDEO_BACKEND="vbe"
```

*(Se estiver em UEFI, pode tentar `efi_gop` no lugar de `vbe`)*.

---

### Dica de Emergência (Interação Cega)

Como você sabe que o GRUB está lá, mas não o vê:

* Se o Windows for a segunda opção na lista, você pode simplesmente apertar a **seta para baixo** uma vez e dar **Enter** (mesmo com a tela branca).
* Se quiser que o GRUB "avise" que carregou, você pode habilitar o **BIP** do sistema (se a placa tiver o buzzer interno) descomentando a linha `GRUB_INIT_TUNE="480 440 1"` no `/etc/default/grub`.

### Teste Final

Após fazer as alterações e dar o `update-grub`, reinicie. Se a tela continuar branca, tente trocar o cabo de vídeo (ex: de HDMI para VGA ou DisplayPort, se disponível), pois algumas BIOS só enviam o sinal de boot para uma saída específica.
