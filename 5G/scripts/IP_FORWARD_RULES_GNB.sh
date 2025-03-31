#!/bin/bash
echo -n

### Enable IPv4/IPv6 Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

### Add NAT Rule
#                                      #IP UE           #INTERFACCIA CHE VA VERSO INTERNET
sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/16 ! -o wlp3s0 -j MASQUERADE



#sudo ip route add 10.45.0.0/16 via 10.53.1.1 dev br-a278fde55116
#!/bin/bash

# Trova l'interfaccia che ha l'IP 10.53.1.1
INTERFACE=$(ip -o -4 addr show | grep '10.53.1.1' | awk '{print $2}')

# Se l'interfaccia è stata trovata, aggiunge la route
if [ -n "$INTERFACE" ]; then
    echo "Trovata interfaccia: $INTERFACE"
###################   IP UE        # IP CN (da ifconfig)  #INTERFACCIA CN (da ifconfig)
    sudo ip route add 10.45.0.0/16 via 10.53.1.1 dev $INTERFACE
else
    echo "Errore: Nessuna interfaccia con IP 10.53.1.1 trovata!"
    exit 1
fi