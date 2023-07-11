# Criar subvolume btrfs para troca de arquivos  

Eu obtive um pequeno SSD para ser meu device secundário, para colocar os Documenos e outros arquivos nele.  
Como quis deixar o SSD fixo, usei o mesmo esquema da matéria anterior, [Converter antigo $HOME para subvolume btrfs](https://elppans.github.io/doc-linux/converter_antigo_home_para_subvolume_btrfs).  
Então já vou partir para os comandos:  

* 1 - Deve editar as partições do novo SSD, excluir tudo e criar um novo device com formato para Linux (8300) e então, reiniciar.  
Após reiniciar, via Terminal, faça a sequência de comandos:  

```
sudo mkfs.btrfs -f -v -L FILES /dev/sdb1
sudo mount /dev/sdb1 /mnt/
sudo btrfs su cr /mnt/@files
sudo umount /mnt
sudo mkdir -p /mnt/files
sudo mount -o relatime,space_cache=v2,discard=async,autodefrag,compress=zstd,commit=10,subvol=@files /dev/sdb1 /mnt/files
mount | grep sdb1
```

* 2 - Faça um export para criar algumas variáveis, é melhor para fazer a configuração necessária depois:  

```
export DIR="/mnt/files" && echo $DIR
export UUID="$(sudo blkid -s UUID -o value /dev/sdb1)" && echo $UUID
export SUID="$(sudo btrfs subvolume list -p $DIR | grep '@files' |awk '{print $2}')" && echo $SUID
```

* 3 - Faça um BACKUP do arquivo /etc/fstab:  

```
sudo cp -a /etc/fstab /etc/fstab.BKP_"$(date +%d%m%y%H%M)"
```

* 4 - Adicione o subvolume criado no fstab:  

```
echo -e "\n#\t$DIR\nUUID=$UUID\t$DIR\tbtrfs\trw,relatime,compress=zstd:3,ssd,discard=async,space_cache=v2,autodefrag,commit=10,subvolid=$SUID,subvol=/@files 0 0" | sudo tee -a /etc/fstab
sudo umount /mnt/files
sudo systemctl daemon-reload
sudo mount -a
mount
```


* Para comentários e sugestões, [clique aqui](https://github.com/elppans/doc-linux/issues)  
