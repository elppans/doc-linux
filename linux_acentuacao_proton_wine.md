# Correção de Acentuação em Jogos via Proton/Wine (Heroic Games Launcher)

Ao rodar jogos de Windows no Linux (como o [**Call of Dragons**](https://store.epicgames.com/pt-BR/p/call-of-dragons-d85ee6)) através do [**Heroic Games Launcher**](https://heroicgameslauncher.com/) ou [**Steam (Proton)**](https://github.com/ValveSoftware/Proton), é comum que o chat ou campos de texto não reconheçam teclas mortas (acentos). O resultado costuma ser a repetição do caractere, como `n~ao` em vez de `não`.

## 🔍 Causa
O problema ocorre devido ao conflito entre o sistema de entrada do Linux (IM - Input Method) e a tradução de teclado feita pelo Wine/Proton. O sistema tenta processar o acento, mas o "container" do jogo recebe os inputs de forma separada.

## 🛠️ Solução: Variável de Ambiente

A solução consiste em forçar o Wine a ignorar os modificadores externos do sistema, permitindo que a acentuação funcione nativamente dentro do jogo.

### Passo a Passo no Heroic Games Launcher:

1. Abra o **Heroic Games Launcher**.
2. Clique no jogo desejado (ex: *Call of Dragons*).
3. Vá em **Settings** (Configurações) no menu lateral do jogo.
4. Desça até a seção **Advanced** (Avançado).
5. Localize o campo **Environment Variables** (Variáveis de Ambiente).
6. Adicione a seguinte configuração:
   * **Key (Chave):** `XMODIFIERS`
   * **Value (Valor):** `@im=none`
7. Clique no botão de adicionar (`+`) e reinicie o jogo.

### Solução via Terminal (Caso use Wine puro):
Caso esteja rodando o binário diretamente via terminal, utilize:
```bash
XMODIFIERS=@im=none wine nome_do_jogo.exe

```

---

## ✅ Resultado Esperado

Após a aplicação, as teclas mortas ( `~`, `´`, `^`, ``` ) deverão aguardar a próxima tecla para realizar a combinação corretamente dentro do chat do jogo.

---

