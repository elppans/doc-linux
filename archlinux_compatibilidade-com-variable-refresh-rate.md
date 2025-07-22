# 🌀 Verificando compatibilidade com VRR (Variable Refresh Rate) no Arch Linux

O VRR permite que o monitor ajuste dinamicamente sua taxa de atualização conforme os frames gerados pela GPU, melhorando fluidez e eliminando *tearing* e *stuttering*.

---

## ✅ Indicadores de compatibilidade

### 1. Especificações do fabricante

Procure por termos como:

- **AMD FreeSync**
- **NVIDIA G-SYNC / G-SYNC Compatible**
- **HDMI VRR**
- **VESA Adaptive Sync**

Verifique se o monitor está conectado via **DisplayPort 1.2+** ou **HDMI 2.1**, pois são os protocolos que carregam suporte à VRR.

---

### 2. Verificação com `xrandr`

No terminal:

```bash
xrandr --prop
```

Procure pela saída do monitor ativo (`DP-1`, `HDMI-1`, etc) e veja se aparece:

```
vrr_capable: 1
```

Se for `1`, o monitor suporta VRR e está corretamente identificado pelo sistema.

---

### 3. Verificar suporte com `glxinfo`

Instale o pacote:

```bash
sudo pacman -S mesa-utils
```

Depois execute:

```bash
glxinfo | grep "Variable Refresh Rate"
```

Nem todas as distros mostram isso diretamente, mas pode indicar suporte da GPU e drivers ao recurso.

---

### 4. Checagem visual no GNOME 46+

Ative o recurso:

```bash
gsettings set org.gnome.mutter experimental-features "['variable-refresh-rate']"
```

Reinicie a sessão e vá em:

**Configurações → Tela → Taxa de atualização**

Se compatível, aparecerá algo como:  
**“Variável (até 144Hz)”**

---

### 5. Consulta ao EDID do monitor

O EDID revela as capacidades do monitor. Execute:

```bash
sudo cat /sys/class/drm/card0-*/edid | hexdump -C
```

Ou instale:

```bash
sudo pacman -S read-edid
parse-edid < /sys/class/drm/card0-*/edid
```

---

## 🧰 Ativando VRR no Xorg (AMD)

Crie o arquivo de configuração:

```bash
sudo nano /etc/X11/xorg.conf.d/20-amdgpu.conf
```

Conteúdo:

```conf
Section "Device"
  Identifier "AMD"
  Driver "amdgpu"
  Option "VariableRefresh" "true"
EndSection
```

Reinicie a sessão gráfica:

```bash
sudo systemctl restart display-manager
```

Verifique no log:

```bash
grep VariableRefresh /var/log/Xorg.0.log
```

---

## 💡 Observações

- GNOME 46+ e kernel 5.13+ têm suporte nativo ao VRR.
- Placas compatíveis: **AMD RX**, **Intel Gen 11+**, **NVIDIA Pascal+**
- VRR pode estar desativado no menu OSD do monitor — ative manualmente se necessário.
- Alguns monitores só ativam VRR em resoluções ou taxas específicas.

---

# Ativar recurso em monitor não for compatível com VRR

Se você ativar o recurso com:

```bash
gsettings set org.gnome.mutter experimental-features "['variable-refresh-rate']"
```

...e **seu monitor não for compatível com VRR**, o GNOME simplesmente **ignora a funcionalidade** — ou seja, **não há efeitos colaterais** nem erros visíveis. É como se o recurso estivesse ativado, mas **não tivesse onde funcionar**.

---

## ✅ O que acontece na prática:

- O GNOME Shell **não ativa VRR** se o monitor não declarar suporte via EDID.
- A opção **"Taxa de atualização variável"** **não aparece** nas configurações de tela.
- Nenhum aplicativo se beneficia do recurso.
- O sistema continua funcionando normalmente — sem travamentos, sem mensagens de erro.

---

## 🧠 Como o GNOME decide se aplica VRR

O Mutter (compositor do GNOME) verifica se o monitor tem a propriedade `vrr_capable: 1` via `xrandr --prop`. Se não tiver, ele **não tenta aplicar VRR**, mesmo que o recurso esteja ativado nas configurações experimentais.

---

## 💡 Dica extra

Você pode deixar o recurso ativado por padrão, mesmo sem monitor compatível. Assim, se trocar de tela no futuro, o GNOME já estará pronto pra aplicar VRR automaticamente.
