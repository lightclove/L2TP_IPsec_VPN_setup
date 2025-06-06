#!/bin/bash
# Подключение к VPN организации

echo "Запуск VPN подключения..."
sudo systemctl start strongswan
sudo systemctl start xl2tpd

echo "Установка IPsec туннеля..."
sudo ipsec up org-vpn

sleep 2

echo "Активация L2TP соединения..."
sudo sh -c 'echo "c org-vpn" > /var/run/xl2tpd/l2tp-control'

echo "Ожидание установки соединения..."
sleep 5

echo "Добавление маршрута к внутренней сети..."
sudo ip route add 192.168.0.0/24 dev ppp0 2>/dev/null

echo "Проверка состояния:"
sudo ipsec status
ip a show dev ppp0
