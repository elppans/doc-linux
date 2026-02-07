# ArchLinux, Audio e Microfone

O Arch Linux é "minimalista" por padrão, então ele não traz algumas configurações de firmware e perfis de áudio que o Ubuntu já deixa prontos. Se o microfone funciona no Live USB do Ubuntu e não no seu Arch, o problema quase certamente é a falta de **firmware específico** ou o **gerenciamento de perfis** do ALSA/Pipewire.

Pprocessador **Renoir (Family 17h)**: Esses processadores usam um Co-processador de Áudio (ACP) para o microfone digital que muitas vezes exige pacotes extras.

- Roteiro para ativar o microfone:

### 1. Instale os Firmwares e Perfis de Áudio Necessários

Muitos microfones modernos (especialmente em laptops ou máquinas com APU AMD) dependem do Sound Open Firmware (SOF) e de configurações de caso de uso (UCM).

Execute:

```bash
sudo pacman -S sof-firmware alsa-ucm-conf

```

* **sof-firmware:** Essencial para drivers de áudio modernos processarem a entrada de som.
* **alsa-ucm-conf:** Contém as "receitas" (Use Case Manager) que dizem ao sistema como o microfone físico deve ser mapeado.

**Após instalar, reinicie o computador.**

---

### 2. Verifique o Alsamixer, se estiver instalado

Às vezes o microfone é detectado, mas está "mutado" ou com ganho zero no nível mais baixo do driver.

1. Abra o terminal e digite: `alsamixer`
2. Aperte **F6** e selecione a placa de som correspondente ao **Family 17h** (não selecione a da GPU Ellesmere).
3. Aperte **F5** para ver todos os controles.
4. Procure por colunas como **Capture**, **Mic** ou **Internal Mic**.
5. Se embaixo da coluna estiver escrito `MM`, o canal está mutado. Aperte **M** para desmutar (deve aparecer `00`).
6. Use as setas para aumentar o volume de captura.

---

### 3. Verifique os Perfis no GNOME / Pavucontrol

Se está usando GNOME, instale o Controle de Volume do PulseAudio para uma visão mais detalhada:

```bash
sudo pacman -S pavucontrol

```

1. Abra o **Controle de volume do PulseAudio** (pavucontrol).
2. Vá na aba **Configuração**.
3. Procure o dispositivo **Family 17h HD Audio Controller**.
4. No menu suspenso "Perfil", verifique se ele está em algo como **"Duplex Estéreo Analógico"** ou se há uma opção que mencione **"Input"**. Se estiver apenas como "Output", o microfone não será listado na entrada.

---

### 4. Parâmetro do Kernel (Caso persista)

Alguns sistemas AMD Renoir têm um conflito de driver onde o driver de áudio genérico "atropela" o driver do microfone. Se os passos acima não funcionarem, tente o seguinte:

1. Edite o arquivo do GRUB: `sudo nano /etc/default/grub`
2. Na linha `GRUB_CMDLINE_LINUX_DEFAULT`, adicione o seguinte parâmetro dentro das aspas:
`snd_rn_pci_acp3x.dmic_acp_check=1`
3. Salve, saia e atualize o GRUB:
`sudo grub-mkconfig -o /boot/grub/grub.cfg`
4. Reinicie.
___

## Utilizando o `pavucontrol` com `Gnome Settings`

>Em Gnome Settings não aparece o microfone detectado, mas o pavucontrol mostra corretamente.
Após instalar **pavucontrol** e confirmar que o hardware e o driver estão funcionando perfeitamente; com o gráfico de barras azul em movimento, prova que o sistema está capturando som. O problema agora é apenas uma falha de sincronização na interface do **GNOME Settings**, que não está "enxergando" o que o servidor de áudio já detectou.

Isso geralmente acontece por uma inconsistência no **WirePlumber** (o gerenciador de sessão do PipeWire). Tente os seguintes passos para forçar o GNOME a atualizar a lista de dispositivos:

### 1. Reinicie os Serviços de Áudio

Abra o terminal e execute o comando abaixo para reiniciar o PipeWire e o WirePlumber sem precisar reiniciar o PC:

```bash
systemctl --user restart pipewire pipewire-pulse wireplumber
```

Depois de rodar isso, feche e abra novamente a janela de **Configurações do GNOME** para ver se o dispositivo aparece em "Entrada".

### 2. Verifique o Perfil de Configuração

No **pavucontrol** (Controle de Volume), vá até a última aba chamada **Configuração**:

* Localize o dispositivo **Ryzen HD Audio Controller**.
* Verifique se o "Perfil" selecionado é algo como **Analog Stereo Duplex** (Estéreo Analógico Duplex).
* Se estiver selecionado apenas "Saída Estéreo Analógica", o microfone ficará oculto para o GNOME. Mude para o perfil que mencione **"Duplex"** ou **"Input"**.

### 3. Limpe o Cache do WirePlumber (Se o erro persistir)

Se o GNOME continuar mostrando "Nenhum dispositivo de entrada", pode haver um arquivo de configuração temporário corrompido:

1. No terminal: `rm -rf ~/.local/state/wireplumber/*`
2. Reinicie o sistema ou use o comando do Passo 1 novamente.

Como o microfone já está funcional no nível do sistema (visto no `pavucontrol`), esses passos devem resolver a parte visual no GNOME.
___

## Pro Audio

O perfil **"Áudio Pro"** (ou *Pro Audio*) é uma das belezas do PipeWire.

Diferente dos perfis convencionais (como o "Analog Stereo Duplex"), que tentam adivinhar o que você quer e às vezes se perdem nas rotas do hardware, o **Áudio Pro** expõe todas as entradas e saídas físicas do seu chip AMD de forma direta e sem filtros. Para muitos hardwares da linha Family 17h, essa é justamente a "chave mestra" que libera o microfone digital.

### Só um pequeno detalhe:

Como o modo "Áudio Pro" trata cada canal como uma entidade separada, às vezes o GNOME ou apps de chat podem resetar o volume para 100% ou 0% na primeira vez que você os abre. Se sentir que o som sumiu ou ficou estourado, dê uma conferida rápida no `pavucontrol` novamente.

---
