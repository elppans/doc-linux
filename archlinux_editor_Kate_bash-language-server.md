# Archlinux, editor Kate, bash-language-server


O editor Kate tem este erro de saída, apesar de funcionar corretamente:

```ini
[17:38:54 ￼ Cliente LSP Aviso] Falha ao encontrar o executável do servidor: bash-language-server
Verifique seu PATH pelo executável
Veja também https://github.com/bash-lsp/bash-language-server para instalação ou detalhes
```

- Solução:

Instalar os pacotes `shellcheck` e `shfmt` como dependência e depois instalar o pacote `bash-language-server`:  

[shellcheck](https://github.com/koalaman/shellcheck#installing) - Para habilitar o linting  
Se estiver instalado, bash-language-server irá chamá-lo automaticamente para fornecer linting e análise de código cada vez que o O arquivo é atualizado (com tempo de debounce de 500ms).

[shfmt](https://github.com/mvdan/sh#shfmt) - Para que os scripts de shell sejam formatados de forma consistente  
Se estiver instalado, seus documentos serão formatados sempre que você pegar o 'formato de documento' ação. Na maioria dos editores, isso pode ser configurado para acontecer automaticamente quando os arquivos são salvos.

[bash-language-server](https://github.com/bash-lsp/bash-language-server) - Implementação do servidor de linguagem Bash com base no Tree Sitter e sua gramática para Bash  

- Instalação:

Dependências

```bash
sudo pacman -S shellcheck shfmt
```

Pacote

```bash
sudo pacman -S bash-language-server
```

