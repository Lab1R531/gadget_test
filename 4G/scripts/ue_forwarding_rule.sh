#!/bin/bash
echo -n

sudo route add default gw 10.45.0.1

sudo bash -c 'if ! grep -q "nameserver 8.8.8.8" /etc/resolv.conf; then
	echo "nameserver 8.8.8.8" >> /etc/resolv.conf
fi'


