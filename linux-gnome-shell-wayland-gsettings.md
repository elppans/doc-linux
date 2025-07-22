# 🐧 Personalizações e comandos avançados para GNOME Shell (Wayland)

## 🔄 Reiniciar ou recarregar o GNOME Shell

### Sessão Wayland
> No Wayland, reiniciar o GNOME Shell encerra a sessão. Aqui vão alternativas:

- **Bloquear/desbloquear a tela** (`Super + L`)
- **Recarregar extensões**:
  ```bash
  gnome-extensions reload <nome-da-extensão>
  ```
- **Sessão Wayland aninhada**:
  ```bash
  dbus-run-session -- gnome-shell --nested --wayland
  ```

## 🧹 Resetar layout do menu de aplicativos

- **Reset padrão**:
  ```bash
  gsettings reset org.gnome.shell app-picker-layout
  ```

- **Forçar recriação da grade**:
  ```bash
  gsettings set org.gnome.shell app-picker-layout "[]"
  ```

- **Reset via dconf**:
  ```bash
  dconf reset -f /org/gnome/shell/app-picker-layout/
  ```

- **Reset geral do GNOME (use com cuidado)**:
  ```bash
  dconf reset -f /org/gnome/
  ```

⚠️ Em sessões Wayland, o logout é necessário para aplicar alterações.

---

## ⚙️ Escala fracionada e configurações experimentais

Ative várias opções com:
```bash
gsettings set org.gnome.mutter experimental-features "['feature1', 'feature2']"
```

### 🧪 Recursos disponíveis

| Recurso | Descrição |
|--------|-----------|
| `scale-monitor-framebuffer` | Escala fracionada no Wayland |
| `variable-refresh-rate` | Taxa de atualização variável (VRR) |
| `xwayland-grab` | Captura de entrada para apps XWayland |
| `kms-modifiers` | Otimização gráfica via driver |
| `autoclose-popups` | Fecha pop-ups automaticamente |
| `center-new-windows` | Centraliza novas janelas |
| `attach-modal-dialogs` | Modais “presas” à janela principal |
| `use-dynamic-workspaces` | Áreas de trabalho dinâmicas |

### Recursos que me chamaram a atenção

####  **Escala fracionada no Wayland**

🖥️ A escala fracionada no Wayland serve para **ajustar o tamanho da interface gráfica** de forma mais precisa — especialmente útil em monitores **HiDPI** (alta densidade de pixels), como telas 4K ou laptops com telas pequenas e resolução alta.

### 📐 O que é escala fracionada?
Tradicionalmente, o GNOME só permitia escalas inteiras: 100%, 200%, etc. Mas isso nem sempre é ideal — às vezes 100% é pequeno demais e 200% é grande demais. A escala fracionada permite valores como **125% ou 150%**, oferecendo um meio-termo mais confortável para leitura e uso.

---

### ⚙️ Como funciona no Wayland
- O compositor (como o **Mutter**, usado pelo GNOME) sugere uma escala fracionada para cada superfície.
- Os aplicativos que suportam o protocolo (como **GTK** e **Blender**) podem renderizar suas interfaces com mais nitidez, evitando borrões causados por redimensionamento forçado.
- A escala é aplicada diretamente nos buffers gráficos, garantindo que os elementos da interface fiquem proporcionais e legíveis.

---

### ⚠️ Limitações e bugs
- Alguns apps (especialmente Flatpaks ou baseados em Electron) ainda não suportam bem essa escala, podendo ficar **embaçados ou distorcidos**.
- A compatibilidade depende do compositor e da versão do GNOME. O suporte está melhorando, mas ainda é considerado **experimental** em alguns casos.

#### **Taxa de atualização variável (VRR)**

🌀 A configuração `variable-refresh-rate` ativa o suporte ao **VRR (Variable Refresh Rate)** no GNOME Shell — um recurso que permite que o monitor **adapte dinamicamente sua taxa de atualização** à taxa de quadros da placa de vídeo.

### 🎮 Benefícios práticos
- **Elimina o screen tearing** (corte na imagem durante jogos ou vídeos)
- **Reduz stuttering** (travamentos causados por sincronização forçada)
- **Melhora a fluidez em jogos e animações**
- **Economiza energia**, já que o monitor não precisa atualizar em taxa máxima o tempo todo

---

### ⚙️ Como funciona
Quando ativado com:
```bash
gsettings set org.gnome.mutter experimental-features "['variable-refresh-rate']"
```
...o GNOME Shell (a partir da versão 46) passa a permitir que monitores compatíveis com VRR (como FreeSync ou G-SYNC) **sincronizem sua taxa de atualização com o conteúdo exibido**, especialmente em **aplicativos em tela cheia**.

---

### 🧪 Requisitos
- **Monitor compatível com VRR** (FreeSync, G-SYNC ou Adaptive Sync)
- **Placa de vídeo compatível** (AMD, Intel Gen 11+, NVIDIA Pascal+)
- **Conexão via DisplayPort ou HDMI 2.1**
- **Sessão Wayland** (o suporte é nativo no GNOME 46+)

---

### 📋 Observações
- Após ativar, é necessário **reiniciar a sessão** para aplicar.
- A opção aparece em **Configurações → Tela → Taxa de atualização**, como “Variável (até xxx Hz)”.
- Alguns monitores só ativam VRR em resoluções ou taxas específicas (ex: até 144Hz).

---

## 🎨 Personalização visual

- Ative extensão **User Themes** para temas do GNOME Shell
- Temas recomendados: **Papirus**, **Tela**, **Zafiro**
- Cursore: **Bibata**, **Capitaine Cursors**
- Fontes, antialiasing e escala podem ser ajustados via GNOME Tweaks

---

## 🧩 Extensões recomendadas

| Extensão | Função |
|---------|--------|
| Dash to Panel | Une dock e painel superior |
| Just Perfection | Ajustes finos na interface |
| Blur My Shell | Desfoque em menus e painel |
| AppIndicator | Ícones na barra superior |
| GSConnect | Integração com Android |

Explore em: [https://extensions.gnome.org](https://extensions.gnome.org)

---

## 🧰 Ferramentas gráficas úteis

- **GNOME Tweaks**:
  ```bash
  sudo apt install gnome-tweaks
  ```

- **Extension Manager** (via Flathub):
  ```
  flatpak install flathub com.mattjakeman.ExtensionManager
  ```

- **Refine (configurações avançadas)**:
  ```
  flatpak install flathub page.tesk.Refine
  ```

Mais sobre o Refine: [https://livreeaberto.com/refine](https://livreeaberto.com/refine)

---

## 💬 Notas finais

- Muitos recursos são dependentes do Wayland e da versão do GNOME Shell.
- Use logout para aplicar mudanças quando reiniciar o shell não for viável.
- Sempre teste configurações antes de aplicar em ambientes produtivos.

---


