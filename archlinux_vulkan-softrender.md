# Driver Vulkan Direct3D e Renderização de Software

## Driver Vulkan Direct3D 12 (Opcional):

Para instalar o driver Vulkan Direct3D 12, você pode executar o seguinte comando no terminal:

```bash
sudo pacman -S vkd3d lib32-vkd3d
```

Essa biblioteca é responsável por traduzir as chamadas do Direct3D 12 para o Vulkan, permitindo que aplicativos e jogos que usam o Direct3D 12 funcionem com o Vulkan.

## Renderização de software:

Se você precisa usar um rasterizador de software em dispositivos que não suportam Vulkan, existem duas opções recomendadas:

1. **Lavapipe**: É um rasterizador de software baseado em Vulkan. Para instalá-lo, execute:

    ```bash
    sudo pacman -S vulkan-swrast
    ```

    Se você estiver usando a versão de 32 bits, instale também o pacote `lib32-vulkan-swrast`.

2. **SwiftShader**: Essa é outra alternativa, mas requer compilação a partir do AUR. Você pode instalá-lo com:

    ```bash
    yay -S swiftshader-git
    ```

## Configuração de variáveis no arquivo /etc/environment:

Se você possui uma placa de vídeo antiga da NVIDIA, adicione a variável `NVK_I_WANT_A_BROKEN_VULKAN_DRIVER=1` ao arquivo `/etc/environment` e reinicie o sistema para que ela tenha efeito.

Se a placa de vídeo não estiver sendo selecionada corretamente, você pode forçar a seleção com a variável `MESA_VK_DEVICE_SELECT=IDVENDOR:IDPRODUCT`. Para obter os valores corretos de IDVENDOR e IDPRODUCT, execute o seguinte comando:

```bash
lspci -nn | grep VGA
```

Aqui está um exemplo de configuração das variáveis:

```bash
VK_DRIVER_FILES=/usr/share/vulkan/icd.d/lvp_icd.i686.json:/usr/share/vulkan/icd.d/lvp_icd.x86_64.json
NVK_I_WANT_A_BROKEN_VULKAN_DRIVER=1
MESA_VK_DEVICE_SELECT=10de:128b
__GLX_VENDOR_LIBRARY_NAME=mesa
```

Você também pode adicionar outras variáveis opcionais, como `MESA_VK_DEVICE_SELECT_FORCE_DEFAULT_DEVICE=1`, `LIBGL_ALWAYS_SOFTWARE=1`, `__GLX_VENDOR_LIBRARY_NAME=nvidia` e `DRI_PRIME=1`, conforme necessário.
___

# Variáveis

1. **VK_DRIVER_FILES**:
   - Essa variável especifica os arquivos de driver Vulkan a serem usados.
   - No seu caso, os arquivos especificados são `/usr/share/vulkan/icd.d/lvp_icd.i686.json` e `/usr/share/vulkan/icd.d/lvp_icd.x86_64.json`.
   - Esses arquivos contêm informações sobre os drivers Vulkan disponíveis no sistema.
   - O Vulkan carrega esses arquivos para determinar quais drivers estão instalados e disponíveis para uso.

2. **NVK_I_WANT_A_BROKEN_VULKAN_DRIVER=1**:
   - Essa variável é específica para o driver Vulkan "lvp" (Lavapipe).
   - Quando definida como 1, ela permite que você use uma versão experimental ou "quebrada" do driver Lavapipe.
   - Isso pode ser útil para depurar problemas ou testar recursos específicos do driver.
   - Também se você possui uma placa de vídeo antiga da NVIDIA

3. **MESA_VK_DEVICE_SELECT=10de:128b**:
   - Essa variável define o dispositivo Vulkan a ser usado.
   - O valor "10de:128b" como exemplo, corresponde ao ID da sua placa de vídeo NVIDIA GeForce GT 710.
   - Ela direciona o Vulkan para usar essa GPU específica para renderização.

4. **__GLX_VENDOR_LIBRARY_NAME=mesa**:
   - Essa variável especifica a biblioteca GLX (OpenGL Extension to the X Window System) a ser usada.
   - Definindo-a como "mesa", você garante que a biblioteca GLX da Mesa (open-source) seja usada.
   - Isso é relevante quando você deseja usar o OpenGL com a renderização de software ou com drivers Mesa.

___

# Variáveis Opcionais

Propósito de cada uma dessas variáveis opcionais e quando você deve usá-las:

1. **MESA_VK_DEVICE_SELECT_FORCE_DEFAULT_DEVICE=1**:
   - Essa variável é usada para forçar a seleção do dispositivo de renderização Vulkan padrão.
   - Quando você define essa variável como 1, o sistema sempre escolhe o dispositivo Vulkan padrão, independentemente de outras configurações ou dispositivos disponíveis.
   - Use essa variável se você deseja garantir que o dispositivo Vulkan padrão seja sempre selecionado.

2. **LIBGL_ALWAYS_SOFTWARE=1**:
   - Essa variável força a renderização de software para aplicativos que usam a biblioteca OpenGL (libGL).
   - Quando ativada, a renderização será feita exclusivamente por software, ignorando qualquer aceleração de hardware.
   - Use essa variável se você estiver depurando problemas de hardware ou se precisar executar aplicativos OpenGL em modo de renderização de software.

3. **__GLX_VENDOR_LIBRARY_NAME=nvidia**:
   - Essa variável especifica a biblioteca GLX (OpenGL Extension to the X Window System) a ser usada.
   - Definindo-a como "nvidia", você garante que a biblioteca GLX da NVIDIA seja usada.
   - Isso pode ser útil se você estiver usando drivers proprietários da NVIDIA e desejar garantir compatibilidade com aplicativos específicos.

4. **DRI_PRIME=1**:
   - Essa variável é usada para ativar a renderização de GPU discreta (como uma placa NVIDIA) em sistemas híbridos com GPUs integradas (como Intel ou AMD).
   - Quando definida como 1, o DRI (Direct Rendering Infrastructure) prioriza a GPU discreta para renderização.
   - Use essa variável se você deseja direcionar aplicativos específicos para a GPU dedicada em um laptop ou sistema com duas GPUs.

- Lembre-se de que essas variáveis devem ser configuradas no arquivo `/etc/environment` e exigem uma reinicialização do sistema para que as alterações tenham efeito.
___

- Fontes:

https://wiki.archlinux.org/title/Vulkan  
https://wiki.winehq.org/Vkd3d
___
