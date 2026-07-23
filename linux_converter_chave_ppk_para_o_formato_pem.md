# Linux, Converter chave .ppk (Putty) para o formato .pem (OpenSSH)

O cliente SSH padrão do Ubuntu (OpenSSH) não aceita o formato `.ppk` diretamente, pois este é um formato específico do programa PuTTY (muito comum no Windows).

Para se conectar, o caminho mais simples e correto é **converter essa chave `.ppk` para o formato `.pem**` (OpenSSH) usando uma ferramenta rápida no próprio terminal.

---

## Passo a Passo para Conexão

1. **Instalar o conversor de chaves:** Requer acesso sudo.
   Abra o seu terminal e instale o pacote `putty-tools`, que contém o utilitário necessário para a conversão:

```bash
sudo apt update && sudo apt install putty-tools -y
```

2. **Converter o arquivo .ppk para .pem:** Rápido e local.
   Navegue até a pasta onde está o seu arquivo `.ppk` e execute o comando abaixo (substitua `suachave.ppk` pelo nome real do seu arquivo):

```bash
puttygen suachave.ppk -O private-openssh -o chave_convertida.pem
```

3. **Ajustar as permissões do arquivo convertido:** Obrigatório para segurança do SSH.
   O Linux exige que chaves privadas de SSH tenham permissões restritas (apenas você pode ler o arquivo). Se não fizer isso, o SSH recusará a conexão por segurança:

```bash
chmod 400 chave_convertida.pem
```

4. **Conectar ao servidor:** Pronto para o acesso.
   Agora use o comando SSH apontando para o arquivo `.pem` que você acabou de criar. Lembre-se de substituir `usuario` pelo nome de usuário que lhe forneceram:

```bash
ssh -i chave_convertida.pem usuario@10.0.24.87
```

---

# Arquivo .PEM no Remmina

Você deve usar na primeira opção: **Arquivo de identidade SSH** (ou *Identity file*).

---

### Por que nessa opção?

* **Arquivo de identidade SSH:** É onde inserimos a nossa chave privada (seja ela `.pem`, `.key` ou, neste caso específico do Remmina, o `.ppk`). Ela serve para provar quem você é (sua identidade) ao servidor.
* **Ficheiro de certificado SSH:** Esta opção é usada apenas em infraestruturas muito específicas que utilizam certificados assinados por uma Autoridade de Certificação (CA) de SSH, o que não é o caso de uma chave privada comum.

---

### Uma dica sobre o Remmina:

Diferente do terminal padrão do Ubuntu, o **Remmina suporta chaves `.ppk` nativamente**!

Isso significa que você **não precisa converter** o arquivo para `.pem` se for usar a interface gráfica dele. Pode selecionar o seu arquivo `.ppk` diretamente no campo **Arquivo de identidade SSH** que ele fará a autenticação sem problemas.
