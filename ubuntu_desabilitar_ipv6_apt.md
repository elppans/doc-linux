# Desabilitar IPV6 no Ubuntu

01) Desabilitar IPV6 no Sistema Temporariamente (Pode escolher fazer a configuração do ítem 02 ou apenas desativar temporariamente):
```
echo '1' | sudo tee /proc/sys/net/ipv6/conf/all/disable_ipv6
```
02) Desabilitar IPV6 no Sistema (Opcional, se o apt não estiver funcionando, apesar do teste ping funcionar):
```
echo -e '
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
' | tee /etc/sysctl.d/99-sysctl.conf | sudo tee -a /dev/null
```
```
sysctl -p
```

03) Desabilitar IPV6 no APT (opcional):

Adicione `Acquire::ForceIPv4 "true";` na última linha do arquivo /etc/apt/apt.conf:

```
echo -e 'Acquire::ForceIPv4 "true";' | sudo tee -a /etc/apt/apt.conf
```

Outro método é criar um arquivo em "/etc/apt/apt.conf.d" adicionar o código lá:
```
echo -e 'Acquire::ForceIPv4 "true";' | tee -a /etc/apt/apt.conf.d/99force-ipv4  >> /dev/null
```
