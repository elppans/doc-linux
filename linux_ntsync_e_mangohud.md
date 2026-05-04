# Linux, ntsync e mangohud

Verificando se o ntsync esta ativo:
```bash
lsmod | grep ntsync
```
Carregando o modulo manualmente:
```bash
sudo modprobe ntsync
```
configuração permanente no sistema:
```bash
echo "ntsync" | sudo tee /etc/modules-load.d/ntsync.conf
```
___

## Monitoramento Avançado com MangoHud:

Instale o pacote mangohud em seu sistema

Baixe o arquivo MangoHud.conf em seu diretorio:
```bash
mkdir -p "$HOME/.config/MangoHud"
```
```bash
curl -JLk -o "$HOME/.config/MangoHud/MangoHud.conf" https://raw.githubusercontent.com/elppans/doc-linux/refs/heads/main/files/MangoHud.conf
```
___

# Ativar instruções de sincronização otimizadas no Steam

Ativar na inicializaçao dos jogos estas opçoes:
```ini
PROTON_RECV_MMSG=1 PROTON_NT_SYNC=1 mangohud %command%
```

Fonte:  
https://certbestnews.com/post/fedora-44-kde--plasma----aprenda-a-ativar-o-ntsync
