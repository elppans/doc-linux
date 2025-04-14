# Configuração do Input Remapper

## Instalação
Para instalar o pacote do AUR, utilize:

```bash
paru -S input-remapper-git
```
## Ative o serviço

```bash
sudo systemctl enable --now input-remapper.service
```

## Abrindo o aplicativo
Execute o seguinte comando para abrir o Input Remapper:

```bash
input-remapper-gtk
```

## Configuração

1. Na aba **"Dispositivos"**, selecione **"AT Translated Set 2 Keyboard"**.
![image](https://github.com/user-attachments/assets/c4ade2e6-be5e-4ec4-a8ba-273c0327cce9)
2. Em **"Predefinições"**, adicione um nome de sua preferência para o perfil.
![image](https://github.com/user-attachments/assets/c05f1a90-927d-4258-aa70-8c2b0c1e7fe3)
3. Em **"Editor"**, edite as teclas seguindo os passos abaixo:

### Criando um atalho

- Em **"Entrada"**, configure o atalho desejado.  
  Exemplo: `Alt_L + w`
- Em **"Saída"**, selecione **"Chave ou Macro"** e defina **"Keyboard"** como o alvo.
- Na área de edição, digite a tecla ou configuração desejada como resposta.

#### Exemplos:
```plaintext
[ \ ] = backslash
[ | ] = modify(Shift_L, key(backslash))
```
![image](https://github.com/user-attachments/assets/e7d516d7-fa73-4836-ad34-755ec1940159)
![image](https://github.com/user-attachments/assets/5a154ebd-dfc2-4364-960e-4cfca180fc3b)


Para mais informações, acesse o link:  
🔗 [Documentação oficial](https://github.com/sezanzeb/input-remapper/blob/main/readme/examples.md)


