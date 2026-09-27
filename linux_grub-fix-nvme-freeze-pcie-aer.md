# Linux, GRUB fix NVME freeze PCIE-AER

Tive um problema no NoteBook que ficava congelando com o tempo e foi resolvido com estas opções:

```ini
GRUB_CMDLINE_LINUX="pci=noaer nvme_core.default_ps_max_latency_us=0"
```
---
## `pci=noaer`

Desativa o **AER (Advanced Error Reporting)** do barramento PCIe. O AER é um mecanismo que detecta e reporta erros de hardware/protocolo no PCIe (ex: erros de sinal, timeouts, etc). Em alguns notebooks, controladores PCIe (Wi-Fi, NVMe, chipsets Intel/AMD com bugs de firmware) geram uma enxurrada de eventos AER espúrios — o kernel fica logando e tentando lidar com "erros" que na prática não afetam o funcionamento, mas consomem recursos e podem travar processos ou gerar lentidão progressiva. Desativar isso evita esse ruído/loop de tratamento de erro.

## `nvme_core.default_ps_max_latency_us=0`

Controla o **APST (Autonomous Power State Transition)** dos SSDs NVMe — o recurso que faz o SSD entrar sozinho em estados de economia de energia mais profundos quando ocioso. O parâmetro define a **latência máxima aceitável** (em microssegundos) para transições de power state; com valor `0`, você está essencialmente dizendo ao driver para não permitir que o SSD entre nesses estados de baixo consumo mais agressivos.

Isso é um fix clássico para SSDs NVMe (principalmente certos modelos com firmware problemático) que travam, ficam extremamente lentos ou até "somem" do barramento depois de ficarem ociosos e tentarem voltar de um deep sleep state malfeito.

---

**Por que isso resolveu seu congelamento progressivo:** os dois sintomas combinados — AER gerando erros falsos no PCIe e o NVMe entrando/saindo mal de estados de energia — são causas muito comuns de notebooks que "vão travando com o tempo" (ao contrário de travar na hora do boot), porque o problema só aparece depois que o hardware tenta economizar energia ou após acumular erros no PCIe.

---

> 📖 Para um diagnóstico mais detalhado (identificação do dispositivo culpado via `lspci`, e limpeza dos logs gerados pelo erro), veja: [Erro AER no Linux: Análise e Solução](./linux_pci_e_ssd_solucao_erro_aer.md)
