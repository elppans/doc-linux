# Archinstall, Imagens da instalação do Archlinux ISO 01.02.2024

- **ATENÇÃO**:  
**NÃO** é um tutorial, é uma **DEMONSTRAÇÃO** em IMAGENS.  
### Para instalar **USE O WIKI PRA SABER COMO USAR O [ARCHINSTALL](https://wiki.archlinux.org/title/Archinstall_(Portugu%C3%AAs))**.  
Partindo do ponto em que [foi feito o boot do instalador no computador "1.1 a 1.4"](https://wiki.archlinux.org/title/Installation_guide_(Portugu%C3%AAs)).  
Dá pra seguir o [Arch Wiki, USB flash installation medium (Português)](https://wiki.archlinux.org/title/USB_flash_installation_medium_(Portugu%C3%AAs)).  

- **Internet**:  
Se não estiver comunicando, seguir as etapas descritas, de acordo com sua rede, em:  

[Arch Wiki, guia de instalação](https://wiki.archlinux.org/title/Installation_guide_(Portugu%C3%AAs)#Conectar_%C3%A0_internet)  
[Arch Wiki, Configuração de rede](https://wiki.archlinux.org/title/Network_configuration_(Portugu%C3%AAs)#Endere%C3%A7o_IP_est%C3%A1tico)  
[Arch Wiki, Wi-Fi — autentique-se à rede sem fio](https://wiki.archlinux.org/title/Iwd_(Portugu%C3%AAs)#iwctl)  
[Arch Wiki, Modem de internet móvel — conecte-se à rede móvel](https://wiki.archlinux.org/title/Mobile_broadband_modem#ModemManager)  

Pra não ficar apanhando do teclado, costumo dar como primeiro comando o loadkeys:

```bash
loadkeys br-abnt2
```

Recomendável testar a conexão com a internet antes de iniciar a instalação:

```
ping -c 4 archlinux.org
```

Estando tudo certo, iniciar a instalação. É muito importante LER COM ATENÇÃO cada item para não cometer erros.  
>Como já tenho o Arch em meu computador, esta instalação foi feita em Máquina Virtual pra mostrar como foi feito pra instalar o ArchLinux com Plasma.  
**Todas as opções devem ser escolhidas prestando atenção e cuidado**  

Para iniciar a instalação, basta usar o comando `archinstall`:  

<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/ZqsFBj7V/Archinstall-1.png" alt="Archinstall-1"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/q7vxvWLN/Archinstall-2.png" alt="Archinstall-2"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/85qRwcVv/Archinstall-3.png" alt="Archinstall-3"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/brkQ5PzB/Archinstall-4.png" alt="Archinstall-4"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/FRfbjcwm/Archinstall-5.png" alt="Archinstall-5"/></a><br/><br/>
<a href="https://postimg.cc/LhmZ0ZQJ" target="_blank"><img src="https://i.postimg.cc/KcMrjPnD/Archinstall-6.png" alt="Archinstall-6"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/YqN6ftD4/Archinstall-7.png" alt="Archinstall-7"/></a><br/><br/>
<a href="https://postimg.cc/TK5yWj14" target="_blank"><img src="https://i.postimg.cc/sgw5qwrs/Archinstall-8.png" alt="Archinstall-8"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/4NRv9YPk/Archinstall-9.png" alt="Archinstall-9"/></a><br/><br/>
<a href="https://postimg.cc/gwvngYvy" target="_blank"><img src="https://i.postimg.cc/Pq7YrJJ7/Archinstall-10.png" alt="Archinstall-10"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/g2Yvg11g/Archinstall-11.png" alt="Archinstall-11"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/KYjt2BGL/Archinstall-12.png" alt="Archinstall-12"/></a><br/><br/>
<a href="https://postimg.cc/fSbyWm15" target="_blank"><img src="https://i.postimg.cc/Rh7HRTdr/Archinstall-13.png" alt="Archinstall-13"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/nzQ7sxQh/Archinstall-14.png" alt="Archinstall-14"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/rsX4xHSC/Archinstall-15.png" alt="Archinstall-15"/></a><br/><br/>
<a href="https://postimg.cc/5j96mWjv" target="_blank"><img src="https://i.postimg.cc/gc88mYWM/Archinstall-16.png" alt="Archinstall-16"/></a><br/><br/>
<a href="https://postimg.cc/Xpmq3ZLc" target="_blank"><img src="https://i.postimg.cc/6p5vrnGS/Archinstall-17.png" alt="Archinstall-17"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/VLwMN3sz/Archinstall-18.png" alt="Archinstall-18"/></a><br/><br/>
<a href="https://postimg.cc/Mcbpy9Sd" target="_blank"><img src="https://i.postimg.cc/mrK1Wn6f/Archinstall-19.png" alt="Archinstall-19"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/NfxX2pLm/Archinstall-20.png" alt="Archinstall-20"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/Jz6BP0Nh/Archinstall-21.png" alt="Archinstall-21"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/Gp4TNRKx/Archinstall-22.png" alt="Archinstall-22"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/fLXtzv63/Archinstall-23.png" alt="Archinstall-23"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/cCSKrnSF/Archinstall-24.png" alt="Archinstall-24"/></a><br/><br/>
<a href="https://postimg.cc/8sCz6dnm" target="_blank"><img src="https://i.postimg.cc/4467jB6q/Archinstall-25.png" alt="Archinstall-25"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/br9ZbwYp/Archinstall-26.png" alt="Archinstall-26"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/CLwB0kJ1/Archinstall-27.png" alt="Archinstall-27"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/rFgdwsY9/Archinstall-28.png" alt="Archinstall-28"/></a><br/><br/>
<a href="https://postimg.cc/McxWK1QR" target="_blank"><img src="https://i.postimg.cc/W4qt8np9/Archinstall-29.png" alt="Archinstall-29"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/pLTmhvwM/Archinstall-30.png" alt="Archinstall-30"/></a><br/><br/>
<a href="https://postimages.org/" target="_blank"><img src="https://i.postimg.cc/dVxLGXFk/Archinstall-31.png" alt="Archinstall-31"/></a><br/><br/>
<a href="https://postimg.cc/VSRzS5qh" target="_blank"><img src="https://i.postimg.cc/mDxk5HtT/Archinstall-32.png" alt="Archinstall-32"/></a><br/><br/>
<a href="https://postimg.cc/Pp5T1hK5" target="_blank"><img src="https://i.postimg.cc/NM1FqjHm/Archinstall-33.png" alt="Archinstall-33"/></a><br/><br/>
<a href="https://postimg.cc/njSZk5wY" target="_blank"><img src="https://i.postimg.cc/hvcjSRLw/Archinstall-34.png" alt="Archinstall-34"/></a><br/><br/>

