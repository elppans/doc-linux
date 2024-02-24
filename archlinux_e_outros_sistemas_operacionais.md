# ArchLinux e outros S.O.

>Retirado de [Wiki ArchLinux, Detectando outros sistemas operacionais (ING)](https://wiki.archlinux.org/title/GRUB#Detecting_other_operating_systems)

Para que o grub-mkconfig procure outros sistemas instalados e os adicione automaticamente ao menu, [instale](https://wiki.archlinux.org/title/Help:Reading_(Portugu%C3%AAs)#Instala%C3%A7%C3%A3o_de_pacotes) o pacote [os-prober](https://archlinux.org/packages/?name=os-prober) e [monte](https://wiki.archlinux.org/title/File_systems_(Portugu%C3%AAs)#Montar_um_sistema_de_arquivos) as partições a partir das quais os outros sistemas inicializam. Em seguida, execute novamente o grub-mkconfig. Se você obtiver a seguinte saída: em seguida, edite e adicione/descomente: `Aviso: os-prober não será executado para detectar outras partições inicializáveis /etc/default/grub`

>GRUB_DISABLE_OS_PROBER=false

Em seguida, tente novamente.

### Observações:

- O ponto de montagem exato não importa, os-prober lê o para identificar lugares para procurar entradas inicializáveis.mtab
- Lembre-se de montar as partições cada vez que você executar grub-mkconfig, a fim de incluir os outros sistemas operacionais sempre.
- O OS-Prober pode não funcionar corretamente quando executado em um chroot. Tente novamente depois de reiniciar no sistema se você enfrentar isso.

Ponta: Você também pode querer que o GRUB se lembre da última entrada de inicialização escolhida.  
Veja [/Dicas e truques#Recuperar entrada anterior (ING)](https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#Recall_previous_entry).
