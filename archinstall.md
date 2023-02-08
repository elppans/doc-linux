# Script archinstall

Atenção, use o Wiki para saber como usar o [Archinstall](https://wiki.archlinux.org/title/Archinstall_(Portugu%C3%AAs)).  

Fazer uma instalação usando o Script archinstall é bem simples, porém, tem alguns detalhes pra evitar erros do Script, que impedem a finalização da instalação.

Em uma máquina virtual, criei algumas partições para simular um HD já usado, com Swap, EFI, partição Linux.

Para iniciar a instalação via archinstall, faça o comando

```
archinstall
```

Faça as configurações de acordo com sua preferência e chegando na configuração das partições, faça o seguinte.
Se for um HD que já tem outro sistema ou partições que queira usar, escolha a opção para configurar as partições manualmente e lá se atente com estes detalhes:  

1) Se você já tiver uma partição Swap em seu HD e NÃO quer apagar ou simplesmente quer ignorar, simplesmente **NÃO MEXA NA PARTIÇÃO SWAP**, deixe assim mesmo do jeito que tá, finge que nem tá lá.  
2) Ainda sobre o Swap, uma das opções do instalador é o uso do ZRAM, que já tem a flag marcado para ser criado por padrão. Deixe assim mesmo, **NÃO DESATIVE O ZRAM**.  
3) Sobre a partição de boot, no exemplo usando EFI. Em uma instalação MANUAL, algumas pessoas configuram o local do EFI, ponto de montagem em **/efi** e outras configuram em **/boot/efi**, etc., depende de como cada um gosta de configurar seu boot. Porém, usando o Script archinstall, o ponto de montagem do boot EFI, **DEVE SER CONFIGURADO EM** **`/boot`**  
4) Configure o tipo de partição do EFI como **`fat32`**, **NÃO DEIXE COMO VFAT**.  

Se seguir estes 4 detalhes, mais difícil vai ser para o Script dar erros.  
Claro que pode dar algum erro sobre outras coisas, então pode pedir ajuda para a comunidade, não esquecendo de avisar que tá usando o Script para a instalação e, se possível, enviar o log de instalação, que é salvo em **`/var/log/archinstall/install.log`**  

* Esta é a configuração que fiz em meu teste, como pode ver, tenho um Swap como 1ª partição e o ignorei e configurei apenas as outras partições.  

[![archinstall-01.png](https://i.postimg.cc/SRCppZVw/archinstall-01.png)](https://postimg.cc/ctxzRBpm)  

* Interessante, depois que fiz o boot verifiquei como está configurado o Swap e notei que a partição que ignorei, foi configurado para iniciar junto com o ZRAM.  

[![archinstall-02.png](https://i.postimg.cc/SxdwWdqq/archinstall-02.png)](https://postimg.cc/jDWgTzLk)  

Para mais informações sobre o archinstall, consulte o Wiki:  

[Archinstall (Português)](https://wiki.archlinux.org/title/Archinstall_(Portugu%C3%AAs))  
[Sudo (Português, Desabilitar o login do root)](https://wiki.archlinux.org/title/Sudo_(Portugu%C3%AAs)#Desabilitar_o_login_do_root). Bonus, interessante.  
