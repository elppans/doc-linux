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

- **Fonte:**
[BIGLinux ISO Profiles, Root ADD](https://github.com/biglinux/iso-profiles/blob/main/biglinux-make-iso-profiles/base/Root-add)
