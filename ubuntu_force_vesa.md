# Forçar modo VESA no Ubuntu (22+)

Nos sistemas modernos como o **Ubuntu 22.04**, não existe mais a opção clássica de `vga=xxx` para forçar diretamente o **vesa framebuffer**. Isso era usado no GRUB Legacy com o driver `vesafb`. Hoje o kernel usa **KMS (Kernel Mode Setting)** e drivers específicos da GPU, então o "forçar vesa" mudou de forma.

### Como ainda é possível forçar VESA no boot
Você pode tentar algumas abordagens:

- **Usar `nomodeset`**  
  Isso desativa o KMS e faz o kernel cair em um modo genérico de vídeo, muitas vezes baseado em VESA.  
  Exemplo na linha `linux` do GRUB:
  ```
  linux ... ro quiet splash nomodeset
  ```

- **Carregar o framebuffer `uvesafb`**  
  O `uvesafb` é um substituto moderno para o antigo `vesafb`. Para usá-lo:
  1. Instale o pacote:
     ```bash
     sudo apt install v86d
     ```
  2. Adicione ao kernel:
     ```
     video=vesafb:mtrr:3,ywrap,1024x768-24@60
     ```
     ou
     ```
     video=uvesafb:mode_option=800x600-16@60,mtrr=3,scroll=ywrap
     ```
  3. Atualize o GRUB:
     ```bash
     sudo update-grub
     ```

- **Editar temporariamente no GRUB**  
  Durante o boot, pressione `E`, vá até a linha `linux` e adicione:
  ```
  nomodeset video=uvesafb:mode_option=800x600-16@60
  ```

### Observações
- Isso só afeta o **console/framebuffer** (antes do login gráfico). O ambiente gráfico (GNOME, KDE, etc.) usa seus próprios drivers e não respeita o VESA.
- Em placas modernas (NVIDIA/AMD/Intel), o suporte VESA pode ser limitado. O ideal é usar o driver correto depois que o sistema inicializa.
- `uvesafb` funciona melhor que `vesafb` em kernels recentes.
___
# Listar os modos suportados pelo `uvesafb`

Para descobrir quais modos de vídeo o **uvesafb** suporta no seu hardware, você pode usar alguns comandos diretamente no GRUB ou no Linux já iniciado. 

---

### 1. Durante o boot (no GRUB)
- Na tela do GRUB, pressione **`c`** para abrir o console.
- Digite:
  ```
  videoinfo
  ```
  ou, em versões mais antigas:
  ```
  vbeinfo
  ```
- Isso lista todos os modos VESA disponíveis para o framebuffer.  
  Exemplo de saída:
  ```
  0x117  1024x768x16
  0x118  1024x768x24
  0x115   800x600x24
  ...
  ```

---

### 2. No Linux já iniciado
Se você já está dentro do sistema e tem o pacote `v86d` instalado (necessário para `uvesafb`), pode usar:

```bash
sudo hwinfo --framebuffer
```

Esse comando mostra todos os modos suportados pelo framebuffer da sua placa de vídeo.

---

### 3. Consultar diretamente o kernel log
Após carregar o `uvesafb`, verifique o `dmesg`:
```bash
dmesg | grep -i uvesafb
```
Ele pode listar os modos aceitos ou mensagens sobre suporte.

---

### Observações
- O `uvesafb` depende do BIOS da placa de vídeo, então os modos listados são os que o firmware expõe (nem sempre todos os que o monitor suporta).
- Em hardware moderno, muitas vezes o suporte VESA é limitado a resoluções básicas (800x600, 1024x768).
- Para usar um modo específico, você passa algo como:
  ```
  video=uvesafb:mode_option=1024x768-24,mtrr=3,scroll=ywrap
  ```

---
