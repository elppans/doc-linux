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


