#!/bin/sh

# 1. Detener y deshabilitar el temporizador y sus servicios
sudo systemctl disable --now cloudflared-update.timer
sudo systemctl disable --now cloudflared.service
sudo systemctl stop cloudflared-update.service

# 2. Eliminar las unidades de systemd que quedaron
sudo rm -f /etc/systemd/system/cloudflared.service
sudo rm -f /etc/systemd/system/cloudflared-update.service
sudo rm -f /etc/systemd/system/cloudflared-update.timer

# 3. Recargar systemd
sudo systemctl daemon-reload
sudo systemctl reset-failed

# 4. Eliminar configuraciones y credenciales residuales
sudo rm -rf /etc/cloudflared
rm -rf ~/.cloudflared

# 5. Comprobar el resultado
echo "===== PAQUETE ====="
pacman -Q cloudflared 2>&1

echo "===== PROCESOS ====="
pgrep -af cloudflared || echo "Sin procesos activos"

echo "===== SERVICIOS ====="
systemctl list-unit-files --type=service | grep -i cloudflared || echo "Sin servicios registrados"

echo "===== ARCHIVOS ====="
ls -ld /etc/cloudflared ~/.cloudflared 2>&1
