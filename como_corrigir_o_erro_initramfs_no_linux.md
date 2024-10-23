# Como corrigir o erro initramfs no Linux

Esse erro ocorre por diversos motivos, seja por um **desligamento incorreto**, arquivos corrompidos do sistema ou até mesmo defeitos físicos no disco.

Contudo em todo caso é um sinal de alerta, sendo assim fique atento ao comportamento do seu sistema, e se mesmo após realizar os passos descritos adiante o erro voltar a ocorrer, talvez seja a hora de substituir o seu HD.

Provavelmente se você está com o **erro initramfs** ocorrendo nesse momento, você estará em uma tela parecida com essa:

```bash
BusyBox v1.22.1 (Ubuntu 1:1.22.0-19ubuntu2) built-in shell (ash)
Enter ‘help’ for a list of built-in commands.

(initramfs) :
```

*A versão do BusyBox pode variar de acordo com a sua instalação.*

Em primeiro lugar devemos executar o comando **exit**, pois ele irá fechar o console shell e exibir a exata partição que está com problema.

```bash
BusyBox v1.22.1 (Ubuntu 1:1.22.0-19ubuntu2) built-in shell (ash)
Enter ‘help’ for a list of built-in commands.

(initramfs): exit



/dev/mapper/ubuntu–vg-root: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
(i.e., without -a or -p options)
fsck exited with status code 4.
The root filesystem on /dev/mapper/ubuntu–vg-root requires a manual fsck
```

Como podemos ver a partição que está com erro é a **/dev/mapper/ubuntun–vg-root**, feito isso iremos executar o comando **fsck** para corrigir qualquer erro que esteja impedindo do seu Linux iniciar.

```bash
BusyBox v1.22.1 (Ubuntu 1:1.22.0-19ubuntu2) built-in shell (ash)
Enter ‘help’ for a list of built-in commands.

(initramfs): fsck /dev/mapper/ubuntu–vg-root -y
```

Ao executar o comando **fsck** como mostramos no exemplo acima acrescido da **flag -y** o sistema automaticamente irá procurar por erros e corrigi-los.

Portanto aguarde o processo finalizar, depois basta apenas reiniciar a maquina e pronto o seu sistema Linux irá iniciar normalmente.

Para reiniciar o seu Linux utilize **reboot** conforme mostramos abaixo:

```bash
BusyBox v1.22.1 (Ubuntu 1:1.22.0-19ubuntu2) built-in shell (ash)
Enter ‘help’ for a list of built-in commands.

(initramfs): reboot
```
___
# Nesse tutorial utilizamos o Ubuntu, porém as dicas dadas aqui devem ser [compatíveis com outras distribuições do Linux](https://techstart.xyz/topicos/linux/)
___

- Fonte:

[https://techstart.xyz/linux/linux-nao-inicia-como-corrigir-o-erro-initramfs/](https://techstart.xyz/linux/linux-nao-inicia-como-corrigir-o-erro-initramfs/)  

