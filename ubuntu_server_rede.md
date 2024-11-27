# Ubuntu Server, configuração da rede

![image](https://github.com/user-attachments/assets/95de9693-9dee-49c4-8ef9-ca96d927e9cb)

Essa tela pertence à configuração de IPv4 no **Ubuntu Server**, e você está configurando manualmente as informações de rede para a interface `ens33`. Aqui está um passo a passo para preencher corretamente os campos:

1. **Método IPv4:**  
   Já está em "Manual", o que significa que você precisa fornecer os detalhes manualmente.

2. **Subnet:**  
   Insira o endereço da rede em formato CIDR. Por exemplo:  
   - Para uma rede com máscara 255.255.255.0 (24 bits), use: `192.168.1.0/24`.

3. **Endereço:**  
   Insira o IP que será atribuído ao servidor. Por exemplo:  
   - `192.168.1.100`.

4. **Gateway:**  
   Insira o endereço IP do gateway (roteador da rede). Por exemplo:  
   - `192.168.1.1`.

5. **Nomear servidores:**  
   Insira os endereços IP dos servidores DNS. Você pode usar servidores públicos como:  
   - `8.8.8.8, 8.8.4.4` (DNS do Google)  
   - ou outros DNS locais se aplicável.

6. **Procurar em domínios:**  
   É opcional, mas pode incluir os domínios pesquisáveis, como `localdomain` ou o domínio usado na rede.

7. **Salvar:**  
   Depois de preencher os campos, pressione a tecla para **[Guardar]**. No teclado, você geralmente pode usar **TAB** para navegar entre as opções e **Enter** para confirmar.

### Exemplo:
Se sua rede for assim:
- IP da máquina: `192.168.1.100`
- Máscara: `255.255.255.0` (equivalente a /24)
- Gateway: `192.168.1.1`
- Servidores DNS: `8.8.8.8, 1.1.1.1`

Você preenche assim:
- Subnet: `192.168.1.0/24`
- Endereço: `192.168.1.100`
- Gateway: `192.168.1.1`
- Nomear servidores: `8.8.8.8, 1.1.1.1`

Após configurar, salve as alterações e reinicie o serviço de rede com:  
```bash
sudo systemctl restart networking
```
___

## Exemplo, configuração para um IP range 15

![image](https://github.com/user-attachments/assets/e421961d-3163-4892-bd71-df4c0beb7cce)

Configuração que parece correta, considerando o seguinte:

1. **Subnet:**  
   Definido como `192.168.15.0/24`, que indica uma rede com máscara de sub-rede `255.255.255.0`. Isso está correto para a maioria das redes locais.

2. **Endereço:**  
   O IP `192.168.15.140` está dentro da faixa da rede `192.168.15.0/24`. Certifique-se de que este endereço não esteja sendo usado por outro dispositivo na rede.

3. **Gateway:**  
   O endereço do gateway está configurado como `192.168.15.1`. Isso parece ser o roteador ou outro dispositivo que faz a interconexão com outras redes.

4. **Nomear servidores:**  
   Os servidores DNS estão definidos como `1.1.1.1` (Cloudflare) e `8.8.8.8` (Google), que são públicos e confiáveis.

5. **Procurar em domínios:**  
   Esse campo está vazio, mas é opcional. Você pode deixá-lo assim, a menos que precise de pesquisa de nomes específicos na sua rede.

### Após configurar:
1. Salve clicando em **[Guardar]**.
2. Reinicie o serviço de rede para aplicar as alterações:
   ```bash
   sudo systemctl restart networking
   ```
3. Teste a conectividade com a rede e internet:
   - Verifique a conectividade local:
     ```bash
     ping 192.168.15.1
     ```
   - Verifique a resolução de nomes e conectividade externa:
     ```bash
     ping 8.8.8.8
     ping google.com
     ```

Se os testes funcionarem, sua configuração está concluída! 
