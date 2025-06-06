#!/bin/bash
# Установка VPN-конфигурации

CONFIG_DIR="/etc/vpn-org"
SCRIPT_DIR="/usr/local/bin"

echo "Создание директории для конфигурации..."
sudo mkdir -p $CONFIG_DIR

echo "Копирование конфигурационных файлов..."
sudo cp config/* $CONFIG_DIR/

echo "Копирование скриптов..."
sudo cp scripts/connect-vpn.sh $SCRIPT_DIR/connect-vpn
sudo cp scripts/disconnect-vpn.sh $SCRIPT_DIR/disconnect-vpn

echo "Настройка прав доступа..."
sudo chmod +x $SCRIPT_DIR/connect-vpn
sudo chmod +x $SCRIPT_DIR/disconnect-vpn
sudo chmod 600 $CONFIG_DIR/ipsec.secrets
sudo chmod 600 $CONFIG_DIR/options.l2tpd.client

echo "Создание симлинков для systemd..."
sudo ln -sf $CONFIG_DIR/ipsec.conf /etc/ipsec.conf
sudo ln -sf $CONFIG_DIR/ipsec.secrets /etc/ipsec.secrets
sudo ln -sf $CONFIG_DIR/xl2tpd.conf /etc/xl2tpd/xl2tpd.conf

echo "Включение автозапуска служб..."
sudo systemctl enable strongswan
sudo systemctl enable xl2tpd

echo "Установка завершена!"
echo "Используйте команды:"
echo "  sudo connect-vpn    - для подключения"
echo "  sudo disconnect-vpn - для отключения"
