#!/bin/bash
# ============================================
# Script para desativar suspensão/hibernação da rede (Wi-Fi e Ethernet)
# Compatível com Ubuntu 16.x e 22.x
# ============================================

echo ">>> Desativando economia de energia do Wi-Fi..."
for iface in $(iw dev | awk '$1=="Interface"{print $2}'); do
    sudo iwconfig $iface power off
    echo "Wi-Fi $iface configurado para não dormir."
done

echo ">>> Configurando NetworkManager para manter Wi-Fi ativo..."
sudo mkdir -p /etc/NetworkManager/conf.d
echo "[connection]
wifi.powersave = 2" | sudo tee /etc/NetworkManager/conf.d/default-wifi-powersave-off.conf > /dev/null
sudo systemctl restart NetworkManager

echo ">>> Desativando economia de energia do PCIe (Ethernet)..."
# Adiciona parâmetro ao GRUB
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="pcie_aspm=off /' /etc/default/grub
sudo update-grub

echo ">>> Desativando Wake-on-LAN em todas interfaces Ethernet..."
for iface in $(ls /sys/class/net | grep -E '^eth|^en'); do
    sudo ethtool -s $iface wol d
    echo "Ethernet $iface configurada sem Wake-on-LAN."
    # Torna permanente
    sudo bash -c "echo -e '#!/bin/sh\nethtool -s $iface wol d' > /etc/network/if-up.d/disable-${iface}-power"
    sudo chmod +x /etc/network/if-up.d/disable-${iface}-power
done

echo ">>> Criando regra udev para garantir persistência..."
sudo bash -c 'cat > /etc/udev/rules.d/10-network-card.rules <<EOF
ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth*", RUN+="/usr/sbin/ethtool -s %k wol d"
ACTION=="add", SUBSYSTEM=="net", KERNEL=="wlan*", RUN+="/sbin/iwconfig %k power off"
EOF'

echo ">>> Todas as configurações aplicadas. Reinicie o sistema para garantir efeito completo."

