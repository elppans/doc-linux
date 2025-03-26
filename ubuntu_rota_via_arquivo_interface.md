# Ubuntu, rota via arquivo interface

- Configuração da rota no Windows:

Comando:
```bash
route add 172.19.0.0 mask 255.255.0.0 192.168.1.201 –p
```

Rotas persistentes:
  Endereço de rede         Máscara  Ender. gateway    Custo
          0.0.0.0          0.0.0.0     192.168.0.99  Padrão
       172.19.0.0      255.255.0.0    192.168.1.201       1
       
- Comando da rota no Linux:

sudo ip route add 172.19.0.0/16 via 192.168.1.201
___

## Entendendo a Configuração e o Comando

**Configuração Atual:**

Sua configuração do arquivo de interfaces do Ubuntu define duas interfaces:

* **eth0:** Interface principal com endereço IP estático na rede 192.168.15.0.
* **eth0:0:** Uma sub-interface de eth0 com endereço IP estático na rede 192.168.1.0.

**Comando ip route add:**

O comando `sudo ip route add 172.19.0.0/16 via 192.168.1.201` adiciona uma rota estática à tabela de roteamento. Isso significa que qualquer tráfego destinado à rede 172.19.0.0/16 será enviado para o gateway 192.168.1.201.

## Configurando a Rota Estática no Arquivo de Interfaces

**Por que não é recomendado:**

Normalmente, **não é recomendado** adicionar rotas estáticas diretamente ao arquivo de interfaces. Isso se deve a alguns motivos:

* **Flexibilidade:** Configurar rotas através do arquivo de interfaces pode limitar a flexibilidade na gestão da rede.
* **Gerenciamento:** Alterações frequentes no arquivo de interfaces podem levar a erros de configuração.
* **Ferramentas:** Existem ferramentas mais adequadas para gerenciar rotas, como o próprio comando `ip route`.

**Melhor Prática:**

A maneira mais comum e recomendada de configurar rotas estáticas é através do comando `ip route`. Você pode adicionar essa linha ao seu script de inicialização ou executá-la manualmente quando necessário.

**Exemplo:**

Para adicionar a rota permanentemente, você pode adicionar a seguinte linha a um script de inicialização (por exemplo, um script na pasta `/etc/network/if-up.d/`):

```bash
#!/bin/bash
# Adiciona rota estática ao iniciar a interface

ip route add 172.19.0.0/16 via 192.168.1.201
```

**Quando Adicionar ao Arquivo de Interfaces:**

Em alguns casos muito específicos, você pode adicionar a rota diretamente ao arquivo de interfaces. **No entanto, avalie cuidadosamente os prós e contras antes de tomar essa decisão.**

**Exemplo (não recomendado):**

```
iface eth0 inet static
address 192.168.15.233
netmask 255.255.255.0
gateway 192.168.15.1
dns-nameservers 8.8.8.8 8.8.4.4

post-up ip route add 172.19.0.0/16 via 192.168.1.201
```

**Observações:**

* A linha `post-up ip route add 172.19.0.0/16 via 192.18.1.201` adicionará a rota após a interface ser ativada.
* **Recomenda-se fortemente** usar um script de inicialização para adicionar a rota de forma mais organizada e gerenciável.

## Considerações Adicionais:

* **Rotas Dinâmicas:** Se você estiver trabalhando com rotas dinâmicas (por exemplo, através de protocolos como OSPF ou BGP), configurar rotas estáticas manualmente pode interferir no funcionamento desses protocolos.
* **Tabelas de Roteamento Múltiplas:** Em cenários mais complexos, você pode querer usar tabelas de roteamento múltiplas para gerenciar diferentes tipos de tráfego.

**Conclusão:**

Embora seja possível adicionar rotas estáticas ao arquivo de interfaces, a prática mais comum e recomendada é utilizar o comando `ip route`. Isso oferece maior flexibilidade, facilidade de gerenciamento e evita possíveis conflitos de configuração.

**Se você precisar de mais informações ou tiver alguma dúvida específica, por favor, me diga.**

**Gostaria de saber mais sobre algum desses tópicos?** 
* Scripts de inicialização
* Tabelas de roteamento múltiplas
* Protocolos de roteamento dinâmico

