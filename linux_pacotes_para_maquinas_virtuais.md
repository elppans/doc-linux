# Pacotes para máquinas virtuais

Pacotes utilizados para melhorar a integração e o desempenho de sistemas operacionais rodando como **máquinas virtuais** em diferentes hipervisores. Vamos detalhar o propósito de cada um:

---

### **Virtual Machines**
1. **`open-vm-tools`**  
   - Pacote oficial de ferramentas da VMware para melhorar a integração de sistemas operacionais convidados (guest) rodando em um ambiente VMware (como VMware Workstation, ESXi e vSphere).  
   - Oferece funcionalidades como redimensionamento de tela automático, compartilhamento de arquivos via drag-and-drop e melhor comunicação entre a máquina virtual e o host.

2. **`qemu-guest-agent`**  
   - Agente para sistemas operacionais convidados rodando no **QEMU/KVM**, que permite uma comunicação eficiente entre a VM e o host.  
   - Ajuda na sincronização de tempo, no envio de comandos entre host e VM, e melhora a detecção de status da VM.

3. **`gdk-pixbuf-xlib`**  
   - Biblioteca usada para manipulação de imagens no X11, necessária para alguns aplicativos gráficos em ambientes virtuais.

4. **`xf86-input-vmmouse`**  
   - Driver para melhorar o suporte a **mouse em máquinas virtuais** usando o Xorg.  
   - Permite movimentação fluida do ponteiro entre o host e a VM sem precisar capturar e liberar o mouse manualmente.

---

### **Imported from live**
Pacotes importados de uma versão "live" do sistema, geralmente para melhorar compatibilidade ao rodar como live CD/USB.

#### **BigLinux**
1. **`spice-vdagent-autostart-kde`**  
   - Ferramenta de integração para máquinas virtuais rodando no **SPICE**, usado pelo QEMU/KVM.  
   - Melhora a experiência gráfica, suporta redimensionamento dinâmico da tela, copiar/colar entre host e VM, e compartilhamento de diretórios.  
   - A versão com "autostart-kde" sugere que ele inicia automaticamente no ambiente KDE.

2. **`virtualbox-guest-utils`**  
   - Conjunto de utilitários para máquinas virtuais rodando no **VirtualBox**.  
   - Inclui suporte para **clipboard compartilhado, drivers gráficos melhorados, redimensionamento automático de tela**, compartilhamento de arquivos entre host e VM, entre outras funcionalidades.

---

### **Resumo**  
Esses pacotes são essenciais para rodar sistemas operacionais dentro de máquinas virtuais de maneira eficiente, garantindo melhor suporte a drivers, integração entre host e guest, e usabilidade aprimorada. O uso de cada um depende do hipervisor escolhido (**VMware, QEMU/KVM, VirtualBox, SPICE**).
___
### **Pacotes recomendados para melhor uso da VM:**
Se você estiver rodando uma VM no **QEMU/KVM** com SPICE, instale os seguintes pacotes dentro da VM:  

1. **`qemu-guest-agent`** → Essencial para comunicação entre a VM e o host, melhora o controle de snapshots e desligamento seguro.  
   ```sh
   sudo pacman -S qemu-guest-agent
   sudo systemctl enable --now qemu-guest-agent
   ```  

2. **`spice-vdagent`** → Habilita funcionalidades como **clipboard compartilhado, redimensionamento automático de tela e arrastar e soltar arquivos** entre host e VM.  
   ```sh
   sudo pacman -S spice-vdagent
   sudo systemctl enable --now spice-vdagentd
   ```  

3. **`xf86-input-vmmouse`** → Melhora o suporte ao mouse em ambientes gráficos usando Xorg. Se você sentir problemas com o mouse, pode instalá-lo:  
   ```sh
   sudo pacman -S xf86-input-vmmouse
   ```  

4. **`gdk-pixbuf-xlib`** → Pode ser necessário para alguns aplicativos gráficos dentro da VM, especialmente em ambientes com X11.  
   ```sh
   sudo pacman -S gdk-pixbuf-xlib
   ```  

---

### **Se estiver usando VMware ou VirtualBox:**  
- **VMware:** Instale `open-vm-tools`  
  ```sh
  sudo pacman -S open-vm-tools
  sudo systemctl enable --now vmtoolsd
  ```  
- **VirtualBox:** Instale `virtualbox-guest-utils`  
  ```sh
  sudo pacman -S virtualbox-guest-utils
  sudo systemctl enable --now vboxservice
  ```

### **Conclusão:**  
Se você está rodando **QEMU/KVM com SPICE**, os pacotes **`qemu-guest-agent` e `spice-vdagent`** são os mais importantes para melhor integração. Se estiver usando outro hipervisor, pode precisar de outros pacotes específicos como `open-vm-tools` (VMware) ou `virtualbox-guest-utils` (VirtualBox).
___
## QEMU/KVM com VNC
Se você estiver rodando uma VM no **QEMU/KVM com VNC** (ao invés de SPICE), a configuração muda um pouco. Como o VNC **não** suporta clipboard compartilhado, redimensionamento automático e outras funções avançadas do SPICE, você pode precisar de soluções alternativas.  

### **Pacotes recomendados para QEMU/KVM com VNC**  

#### **1. `qemu-guest-agent` (Altamente recomendado)**  
Melhora a comunicação entre a VM e o host, permitindo desligamento seguro, sincronização de tempo e gerenciamento eficiente da VM.  
```sh
sudo pacman -S qemu-guest-agent
sudo systemctl enable --now qemu-guest-agent
```

#### **2. `xf86-input-vmmouse` (Opcional, melhora o mouse)**  
Se o mouse estiver "preso" dentro da VM ou o movimento não estiver fluido, esse driver pode ajudar.  
```sh
sudo pacman -S xf86-input-vmmouse
```

#### **3. `gdk-pixbuf-xlib` (Opcional, para suporte gráfico em algumas aplicações X11)**  
Pode ser útil para evitar problemas de renderização em alguns aplicativos gráficos dentro da VM.  
```sh
sudo pacman -S gdk-pixbuf-xlib
```

---

### **Funcionalidades Perdidas ao Usar VNC vs. SPICE**
- ❌ **Clipboard compartilhado** (solução: instalar `x11vnc` dentro da VM para acesso remoto avançado)
- ❌ **Arrastar e soltar arquivos**
- ❌ **Redimensionamento automático da tela** (você terá que definir a resolução manualmente dentro da VM)

Se precisar dessas funções, seria melhor considerar **SPICE** ao invés de VNC. Se você precisa usar **VNC**, pode instalar um servidor VNC na VM (`x11vnc` ou `tigervnc`) para acesso remoto avançado.

---

### **Conclusão**
Se está rodando **QEMU/KVM com VNC**, os pacotes essenciais são:
✅ `qemu-guest-agent` → Melhor integração e gerenciamento da VM  
✅ `xf86-input-vmmouse` → Melhor controle do mouse (caso tenha problemas)  
✅ `gdk-pixbuf-xlib` → Suporte a gráficos (caso necessário)  

Se quiser um VNC mais funcional dentro da VM, pode instalar `x11vnc`.  
Se precisar de uma experiência mais integrada, o **SPICE** é uma opção melhor que o VNC.
___
- **Fonte:**
[BIGLinux ISO Profiles, Root ADD](https://github.com/biglinux/iso-profiles/blob/main/biglinux-make-iso-profiles/base/Root-add)
