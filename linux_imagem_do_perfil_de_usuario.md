# Linux, Imagem do perfil de usuário 
 
No Ubuntu (e em outras distros que usam Gnome e o serviço **AccountsService**), a foto de perfil do usuário fica armazenada na pasta:

```
/var/lib/AccountsService/icons/[nome_do_usuario]
```

Esse arquivo é um **PNG** de **96x96 pixels**, usado pelo sistema para exibir o avatar do usuário na tela de login e nas configurações.

Além disso, dentro de `/var/lib/AccountsService/user/`, existe um arquivo chamado **[nome_do_usuario]**, que segue o formato `.desktop`. Esse arquivo contém configurações do usuário, incluindo o caminho para a imagem, por exemplo:

```
[User]
Language=en_GB
XSession=ubuntu
Icon=/var/lib/AccountsService/icons/seu_usuario
```

Caso o usuário defina manualmente uma imagem diferente para o avatar, o sistema ajusta a entrada **Icon=** para apontar para um caminho específico, como:

```
Icon=/usr/share/pixmaps/faces/soccerball.png
```

Se quiser personalizar sua foto de perfil, basta substituir o arquivo de ícone no diretório correto ou editar manualmente essa entrada.
___
- **Fonte**  
[SobreLinux, imagem...do usuário...no Gnome 3](https://sobrelinux.info/questions/4695/where-is-the-users-profile-picture-stored-in-gnome-3)
