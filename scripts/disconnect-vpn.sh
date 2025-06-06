#!/bin/bash
# Отключение от VPN организации

echo "Разрыв L2TP соединения..."
sudo sh -c 'echo "d org-vpn" > /var/run/xl2tpd/l2tp-control'

sleep 2

echo "Остановка IPsec туннеля..."
sudo ipsec down org-vpn

echo "Удаление маршрута..."
sudo ip route del 192.168.0.0/24 2>/dev/null

echo "Остановка служб..."
sudo systemctl stop xl2tpd
sudo systemctl stop strongswan

echo "Проверка состояния:"
sudo ipsec status
