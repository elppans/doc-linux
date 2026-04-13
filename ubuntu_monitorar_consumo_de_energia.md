# Monitorar Consumo de Energia no Ubuntu

- **Ferramentas recomendadas (CLI)**

```
sudo apt update
```

```
sudo apt install powertop powerstat
```

- Estima quanto cada processo está consumindo

```
sudo powertop
```

- aba "Tunables" permite otimizar o sistema automaticamente para economizar energia com a tecla Enter. Ou configure diretamente com o comando:

```
sudo powertop --auto-tune
```

- Gerar relatórios de média de consumo durante um período

```
sudo powerstat
```

- Ver detalhes técnicos da bateria (capacidade, taxa de descarga, voltagem)

```
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```

> (O nome battery_BAT0 pode variar, use upower -e para listar os dispositivos)

- **Mission Center (GUI, Flatpak)**

Mostra o uso de CPU, GPU e memória de forma muito clara, ajudando a identificar visualmente qual app está "pesado".

```
sudo flatpak install flathub io.missioncenter.MissionCenter
```

---
Se notar que o consumo está alto mesmo "parado", verifique se não há processos zumbis ou se o driver de vídeo (especialmente se for NVIDIA) está preso no modo de alta performance. O comando nvidia-smi (se aplicável) pode ajudar a ver se a GPU dedicada está sendo ativada desnecessariamente por algum app.

