# Converter antigo /home de sdb2, ext4 para subvolume btrfs em /dev/sda6

Percebi que meu HD de 1 TB (/dev/sdb) está para parar. Ele tem 2 partições, sendo /dev/sdb2 (a maior) configurada para /home usando o tipo da partição ext4.  
Então, aproveitando que o meu $HOME ocupa ligeiramente pouco espaço, pois os meus arquivos principais, documentos, VM e etc estão em outro local,  
Foi decidido rapidamente após uma congelada, converter o /home de /dev/sdb2 (ext4) para um subvolume @home de /dev/sda6 (btrfs, root).  

### 1 - tty2 em Terminal, login usando root

> CTRL+ALT+F2  
login user  
sudo su  

### 2 - Backup do fstab e desmontar device antigo

```
cp -a /etc/fstab /etc/fstab.bkp
umount /home
```

### 3 - Montar device raiz em /mnt e criar o subvolume @home

```
mount /dev/sda6 /mnt/
btrfs su cr /mnt/@home
umount /mnt/
```

### 4 - Montar subvolume raiz em /mnt e depois o subvolume @home

```
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@ /dev/sda6 /mnt/
mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@home /dev/sda6 /mnt/home/
```

### 5 - Jogar montagem do subvolume @home para fstab e editar

```
mount | grep home >> /mnt/etc/fstab
nano /mnt/etc/fstab
```

### 6 - Verificar como ficou o fstab, após edição

```
cat /etc/fstab
```

> \# /dev/sda6 LABEL=ROOT  
UUID=c7833590-6720-4eab-9332-6260ba73ccb2       /home           btrfs           rw,relatime,compress=zstd:3,ssd,discard=async,space_cache=v2,autodefrag,commit=10,subvolid=278,subvol=/@home 0 0

### 7 - Desmontar os subvolumes montados em /mnt, em ordem inversa

```
umount /mnt/home
umount /mnt
```

### 8 - Recarregar as configurações com systemctl e montar o @home

```
systemctl daemon-reload
mount /home
```

### 9 - Montar device antigo em /mnt e copiar seu $HOME para o novo /home

```
mount /dev/sdb2 /mnt/
ls /mnt
cp -av /mnt/arch /home
umount /mnt
```

### 10 - Fazer checagem de Disco do device antigo e reiniciar a Distro

```
fsck -fy /dev/sdb{1,2}
reboot
```

# ALGUMAS DICAS OBTIDAS APÓS FAZER O TRABALHO... xD

### 1 - Mostrar apenas o UUID do device:

```
blkid -s UUID -o value /dev/sda6
```

> c7833590-6720-4eab-9332-6260ba73ccb2  

### 2 - Listando subvolumes e seus IDs:

```
btrfs subvolume list -p /
```

### 3 - Listando informações apenas do subvolume @home:

```
btrfs subvolume list -p / | grep '@home'
```

### 4 - Listando apenas subvolid do subvolume @home:

```
btrfs subvolume list -p / | grep '@home' |awk '{print $2}'
```

### 5 - Teste para Script (vai que um dia precise):

```
DEVICE='/dev/sda6'
UUID="$(blkid -s UUID -o value "$DEVICE")"
SUID="$(btrfs subvolume list -p / | grep '@home' |awk '{print $2}')"
```

```
echo -e "UUID=$UUID\t/home\tbtrfs\trw,relatime,compress=zstd:3,ssd,discard=async,space_cache=v2,autodefrag,commit=10,subvolid=$SUID,subvol=/@home 0 0"
```

* Links de matérias sobre BTRFS:

https://wiki.archlinux.org/title/Btrfs_(Portugu%C3%AAs)  
https://linuxuniverse.com.br/linux/btrfs  
https://plus.diolinux.com.br/t/entendendo-subvolumes-no-btrfs/15174  
