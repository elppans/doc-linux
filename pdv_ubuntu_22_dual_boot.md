# Configurar Dual Boot para PDV Ubuntu 22.04
___
- Ps.: PDV Ubuntu é diferente de Ubuntu original.  
  PDV Ubuntu contém customizações para funcionar um sistema voltado para PDV's
___

Editar o arquivo cd /etc/default/grub

A configuração padrão do GRUB do PDV Ubuntu 22.04 tem 2 linhas que devemos modificar:

```
GRUB_TIMEOUT_STYLE=hidden
GRUB_TIMEOUT=0
```

Estas 2 linhas, devem ficar desta maneira:

```
GRUB_TIMEOUT_STYLE=menu  
GRUB_TIMEOUT=30
```

Para definir o sistema padrão para a inicialização, deve editar a 1ª variável:

```
GRUB_DEFAULT=0
```

O número 0, significa a 1ª opção de boot lá no menú do grub ao iniciar.  
Então para indicar outro sistema diferente do padrão, deve contar quantas linhas até o sistema.  
Por exemplo, se o Sistema está na 3ª linha no menú do grub, deve configurar na variável o número 2 (Para as variáveis do GRUB, 0 é um caracter válido).  
Exemplo:  

```
GRUB_DEFAULT=2
```

Salve e saia do arquivo /etc/default/grub  

Algumas vezes, a customização do PDV Ubuntu não vai deixar configurado o local correto da atualização do arqiuvo grub.cfg, que é o Script que é usado quando o sistema vai dar boot.  
Nesta customização, mesmo que o sistema esteja configurado com boot EFI, o grub.cfg que é atualizado é o do diretório do boot Legacy.  
Para "Resolver", faça o seguinte procedimento:  

- Renomear o diretório grub da versão Legacy
- Criar um HARDLINK do grub EFI para o grub Legacy (Hard link é diferente de Simbolic link)

```
mv /boot/grub /boot/grub.old
```
```
ln -s  /boot/efi/EFI/ubuntu /boot/grub
```

- Após o ajuste técnico, faça o comando para atualizar o grub

```
update-grub
```
