# Criar um pendrive bootável com **Syslinux**:

### 1. **Identifique e formate o pendrive**
> ⚠ **Atenção**: Isso apagará todos os dados do pendrive!

```bash
sudo umount /dev/sdb1  # Desmonta a partição caso esteja montada
sudo mkfs.vfat -F 32 /dev/sdb1  # Formata como FAT32
```

### 2. **Instale o Syslinux e mtools (se necessário)**
```bash
sudo apt update
sudo apt install syslinux mtools -y  # No Debian/Ubuntu
# sudo dnf install syslinux mtools -y  # No Fedora
# sudo pacman -S syslinux mtools  # No Arch Linux
```

### 3. **Instale o Syslinux no pendrive**
```bash
sudo syslinux --install /dev/sdb1
```

Isso instalará o **bootloader do Syslinux** na partição do pendrive.

### 4. **Copie a ISO para o pendrive**
Monte a ISO e copie os arquivos necessários:

```bash
mkdir iso_mount usb_mount
sudo mount -o loop linux.iso iso_mount
sudo mount /dev/sdb1 usb_mount
sudo cp -r iso_mount/* usb_mount/
sync  # Garante que os dados sejam gravados antes de prosseguir
```

### 5. **Crie um MBR com o Syslinux**
Agora, instale um setor de boot MBR adequado no pendrive:

```bash
sudo dd if=/usr/lib/syslinux/mbr/mbr.bin of=/dev/sdb bs=440 count=1
```
> **Atenção**: Use `/dev/sdb` (o disco inteiro), não `/dev/sdb1` (a partição).

### 6. **Edite o arquivo de configuração do Syslinux**
Crie um arquivo de configuração `syslinux.cfg` dentro do pendrive:

```bash
nano usb_mount/syslinux.cfg
```
Adicione o seguinte conteúdo:

```
DEFAULT linux
LABEL linux
    KERNEL /casper/vmlinuz  # Ajuste o caminho do kernel conforme necessário
    APPEND initrd=/casper/initrd quiet --- 
PROMPT 1
TIMEOUT 50
```

Salve (`Ctrl+X`, `Y`, `Enter`).

### 7. **Desmonte e remova com segurança**
```bash
sudo umount iso_mount usb_mount
rm -rf iso_mount usb_mount
```
___
# Adicionando suporte a EFI

O **passo 5** (instalação do **MBR** com `dd`) **não suporta EFI**. Ele apenas configura o **boot em modo Legacy (BIOS/CSM)**.  

Para adicionar suporte a **EFI**, você precisa de um **bootloader compatível** com EFI, como o **Syslinux UEFI** ou o **GRUB**. O Syslinux tradicional **não oferece suporte completo a EFI**.  

### **Como adicionar suporte a EFI?**
Se a sua ISO já inclui arquivos EFI, você pode copiá-los para o pendrive e criar a estrutura necessária:

#### **1. Crie a estrutura EFI no pendrive**
```bash
mkdir -p usb_mount/EFI/BOOT
```

#### **2. Copie o carregador EFI**
Verifique se sua distribuição já inclui um carregador **EFI** (por exemplo, `bootx64.efi`). Se existir dentro da ISO, copie-o para o pendrive:

```bash
cp iso_mount/EFI/BOOT/* usb_mount/EFI/BOOT/
```

Se a ISO não tiver o `bootx64.efi`, você pode usar o **GRUB** em vez do Syslinux:

```bash
sudo apt install grub-efi-amd64-bin
sudo grub-install --target=x86_64-efi --efi-directory=usb_mount --removable --boot-directory=usb_mount/boot
```

#### **3. Copie o kernel e crie um `grub.cfg`**
Caso tenha instalado o **GRUB**, crie `usb_mount/boot/grub/grub.cfg`:

```
set timeout=5
set default=0

menuentry "Linux Live" {
    linux /casper/vmlinuz boot=live quiet splash
    initrd /casper/initrd
}
```
Ajuste os caminhos conforme a estrutura da sua ISO.

### **Agora seu pendrive suporta EFI e Legacy!**  
O **Syslinux** continuará funcionando no modo Legacy (BIOS), enquanto o **GRUB EFI** permitirá boot em sistemas modernos UEFI. 
___
