#!/bin/bash
echo -n

### Enable IPv4/IPv6 Forwarding
sudo sysctl -w net.ipv4.ip_forward=1

### Add NAT Rule
sudo iptables -t nat -A POSTROUTING -s 10.45.0.0/24 ! -o ogstun -j MASQUERADE
