#!/bin/bash
echo -n
############################  IP base UE    #Interfaccia UE (da ifconfig)
sudo ip route add default via 10.45.1.1 dev tun_srsue

sudo bash -c 'if ! grep -q "nameserver 8.8.8.8" /etc/resolv.conf; then
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi'
