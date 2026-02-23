# Guia de Downloads Dropbox e GDrive via CLI (Wget & Curl)

Este guia consolida o conhecimento sobre como realizar downloads eficientes de serviços de nuvem (Dropbox e Google Drive) diretamente pelo terminal Linux, superando barreiras de redirecionamento, permissões e verificação de arquivos.  
Documenta métodos eficazes para realizar downloads, contornando barreiras comuns como redirecionamentos e telas de visualização.
---

## 1. Comparativo de Ferramentas: Curl vs Wget

Dependendo da tarefa, uma ferramenta pode ser mais direta que a outra. Abaixo, os principais parâmetros equivalentes e suas funções:  

### Tabela de Parâmetros
| Função | Parâmetro `curl` | Parâmetro `wget` | Nota |
| :--- | :--- | :--- | :--- |
| **Nome do Arquivo Sugerido** | `-J` (`--remote-header-name`) | `--content-disposition` ou `--trust-server-names` | Usa o header `Content-Disposition` enviado pelo servidor. |
| **Seguir Redirecionamentos** | `-L` (`--location`) | *(Padrão)* ou `--location` | Essencial para links que passam por encurtadores ou proxies. |
| **Ignorar Erros de SSL** | `-k` (`--insecure`) | `--no-check-certificate` | Útil para sites com certificados HTTPS expirados ou "quebrados". |
| **Definir Nome de Saída** | `-o arquivo` | `-O arquivo` | Salva o download com o nome/caminho que você definir localmente. |

### Diferenças de Comportamento
* **Wget**: Focado em downloads robustos e recursividade. Segue redirecionamentos (HTTP 3xx) por padrão.  
* **Curl**: Focado em transferência de dados e APIs. Exige flags explícitas para quase tudo (como o `-L` para seguir links).  

---

## 2. Dropbox

O Dropbox é amigável ao terminal, desde que o link de visualização seja convertido em link de download.  

**Regra:** Altere o final da URL de `?dl=0` para `?dl=1`.  

* **Com Wget:**
```bash
  wget --content-disposition "[https://www.dropbox.com/s/link_exemplo/arquivo.zip?dl=1](https://www.dropbox.com/s/link_exemplo/arquivo.zip?dl=1)"

```


* **Com Curl:**
```bash
curl -L -o "meu_arquivo.zip" "[https://www.dropbox.com/s/link_exemplo/arquivo.zip?dl=1](https://www.dropbox.com/s/link_exemplo/arquivo.zip?dl=1)"

```

---

## 3. Google Drive

O Google Drive possui camadas de segurança que tentam impedir downloads automatizados e exige configurações específicas dependendo da privacidade e do tamanho do arquivo.  

### Estrutura do Link Direto

Para arquivos binários (ZIP, TAR, ISO), use o endpoint `uc?export=download`.  

* **ID do Arquivo:** Encontrado entre `/d/` e `/view`.
* **Resource Key:** Necessária para arquivos criados antes de certas atualizações de segurança.

**Link Base:**
`https://drive.google.com/uc?export=download&id=SEU_ID_AQUI&resourcekey=SUA_KEY_AQUI`

### Comandos de Download

#### Para arquivos pequenos:

```bash
wget --content-disposition --trust-server-names "LINK_DIRETO"

```
### Resumo: Situações e Soluções

| Situação | O que usar |
| --- | --- |
| **Arquivo Público** | Use o link `uc?export=download&id=...`. |
| **Arquivo com ResourceKey** | **Obrigatório** manter o parâmetro `&resourcekey=...` no link. |
| **Google Docs (Texto/Planilha)** | Precisa trocar o final para `/export?format=...` (veja tabela abaixo). |
| **Arquivo Privado** | Só funciona com `--load-cookies` de um arquivo exportado do seu navegador. |

### Exportação de Documentos (Google Docs/Planilhas)

Documentos nativos do Google não possuem extensão física no servidor. É necessário especificar o formato de exportação.  
Como esses arquivos não têm extensão física, você deve "chutar" ou definir o formato no link:  

| Formato Desejado | Adicione ao final do link |
| --- | --- |
| **Word (.docx)** | `export?format=docx` |
| **PDF (.pdf)** | `export?format=pdf` |
| **Texto Simples (.txt)** | `export?format=txt` |
| **Excel (Planilhas) (.xlsx)** | `export?format=xlsx` |

**Exemplo:**

```bash
wget -O "documento.docx" "[https://docs.google.com/document/d/ID_DO_DOC/export?format=docx](https://docs.google.com/document/d/ID_DO_DOC/export?format=docx)"
```

### Download de Arquivos Grandes (Acima de 100MB - Bypass de Aviso de Vírus):

Para arquivos que o Google não consegue escanear (geralmente > 100MB), é necessário capturar o cookie de confirmação.  
Arquivos grandes disparam um aviso de "não é possível verificar vírus", o que interrompe o `wget`. Use este método para capturar o cookie de confirmação:  


1. Salva o cookie e gera o código de confirmação em /tmp
```bash
wget --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate \
"[https://docs.google.com/uc?export=download&id=ID_DO_ARQUIVO](https://docs.google.com/uc?export=download&id=ID_DO_ARQUIVO)" -O- \
| sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p' > /tmp/confirm.txt
```
2. Usa o cookie para o download final
```bash
wget --load-cookies /tmp/cookies.txt \
"[https://docs.google.com/uc?export=download&confirm=$(cat](https://docs.google.com/uc?export=download&confirm=$(cat) /tmp/confirm.txt)&id=ID_DO_ARQUIVO" \
-O arquivo_final.zip
```

---

## 4. Diagnóstico e Resolução de Problemas

Se o download falhar e resultar em um arquivo pequeno ou corrompido, use estas ferramentas esiga estes passos:

### 1. Verificação de Tipo de Arquivo

Muitas vezes o download "funciona", mas o que baixa é uma página de login em HTML.  
Utilize o comando file, ele identifica o tipo real do arquivo, independentemente da extensão:  

```bash
file nome_do_arquivo
```

* **Correto (Exemplo):** `bzip2 compressed data`, `Zip archive`, `ISO 9660 CD-ROM`.  
* **Erro:** `HTML document text`. O Download "falhou", significa que você baixou uma página de erro ou login.  

### 2. Modo Aranha (Spider), (Inspeção de Headers)

Verifica se o arquivo existe e para onde o link está redirecionando sem baixá-lo.  
Verifica os cabeçalhos do servidor sem baixar o arquivo. Útil para ver se o link está redirecionando para uma página de login.  

```bash
wget --spider --server-response "URL_DO_LINK"

```
## 3. Script de Automação (Gdrive-DL) - **OPCIONAL**

Script básico para extrair o ID e baixar arquivos do Drive automaticamente:  

```bash
#!/bin/bash
# Extrai ID do link de compartilhamento
FILE_ID=$(echo "$1" | sed -rn 's/.*(\/d\/|id=)([a-zA-Z0-9_-]+).*/\2/p')
RES_KEY=$(echo "$1" | sed -rn 's/.*resourcekey=([a-zA-Z0-9_-]+).*/\1/p')

DL_URL="[https://drive.google.com/uc?export=download&id=$FILE_ID](https://drive.google.com/uc?export=download&id=$FILE_ID)"
[ ! -z "$RES_KEY" ] && DL_URL="$DL_URL&resourcekey=$RES_KEY"

wget --content-disposition --trust-server-names "$DL_URL"
```

### 4. Permissões de Acesso

Certifique-se de que o arquivo no Google Drive não está como **Restrito**. Ele deve estar configurado como **"Qualquer pessoa com o link"** para que o terminal consiga acessá-lo sem autenticação.

---

## 5. Boas Práticas de Segurança

* **Uso do /tmp:** Salvar cookies em `/tmp/cookies.txt` é recomendado porque o diretório é limpo automaticamente no reboot e evita expor tokens de sessão na sua pasta `home`.
* **O uso de `--no-check-certificate`** é útil em sistemas com certificados CA desatualizados, mas deve ser usado com cautela.
* **Automação:** Para downloads frequentes, considere criar um script que automatize a extração do ID e o gerenciamento de cookies.
___

# Anotações SIMPLES para exemplos

## Arquivos do "Dropbox":

```bash
curl -JLk -o /tmp/arquivo.tar.gz "https://www.dropbox.com/scl/fi/m3rsjpztmrb3w6mh8p9vm/arquivo.tar.gz?rlkey=a12eq8r8hij9cs8idoot1z345&st=abcd1234&dl=1"

```
```bash
wget --content-disposition --trust-server-names --no-check-certificate -O /tmp/arquivo.tar.gz "https://www.dropbox.com/scl/fi/m3rsjpztmrb3w6mh8p9vm/arquivo.tar.gz?rlkey=a12eq8r8hij9cs8idoot1z345&st=abcd1234&dl=1"

```
## Arquivos do "Google Docs":

- Formato do comando:
```bash
wget --no-check-certificate -O "arquivo.docx" "https://docs.google.com/document/d/ID_DO_ARQUIVO/export?format=docx"

```
Exemplo (Usando o **arquivo** "**teste.docx**"):

- Link copiado:
```bash
https://docs.google.com/document/d/1abc1qu_dYBujWQYMjhAt2B4w8v2dzQ0MRi_absz1234/edit?usp=drive_link

```
- Link convertido:
```bash
wget --no-check-certificate -O "Guia_MapleStory2.docx" "https://docs.google.com/document/d/1abc1qu_dYBujWQYMjhAt2B4w8v2dzQ0MRi_absz1234/export?format=docx"
```

Drive, "**arquivo real**":

Formato do comando:
>OPCIONAIS: {--save-cookies e/ou --load-cookies} /tmp/cookies.txt, --keep-session-cookies
```bash
wget --content-disposition --trust-server-names "https://drive.google.com/uc?export=download&id=ID_DO_ARQUIVO"

```
Usando o arquivo **teste.tar.bz2**:

Link copiado, deve tirar "**/view?usp=sharing**" do link para converter para Download:  
```ini
https://drive.google.com/file/d/12345_fE_yh0RdXBXcGdBcAbcdef0/view?usp=sharing&resourcekey=0-Abdcefvn9MO3oODft12345

```

>**Antes:**  12345_fE_yh0RdXBXcGdBcAbcdef0/view?usp=sharing&resourcekey=0-Abdcefvn9MO3oODft12345  
>**Depois:** 12345_fE_yh0RdXBXcGdBcAbcdef0&resourcekey=0-Abdcefvn9MO3oODft12345  

Verificar:
```bash
wget --spider --server-response "https://drive.google.com/uc?export=download&id=12345_fE_yh0RdXBXcGdBcAbcdef0&resourcekey=0-Abdcefvn9MO3oODft12345"
```

Link convertido:
```bash
wget --save-cookies /tmp/cookies.txt --load-cookies /tmp/cookies.txt --keep-session-cookies --content-disposition --trust-server-names --no-check-certificate \
-O "teste.tar.bz2" \
"https://drive.google.com/uc?export=download&id=12345_fE_yh0RdXBXcGdBcAbcdef0&resourcekey=0-Abdcefvn9MO3oODft12345"
```

