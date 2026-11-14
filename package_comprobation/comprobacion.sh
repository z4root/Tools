#!/bin/sh

echo "===== 1. PAQUETE INSTALADO ====="
pacman -Q $1 2>&1

echo -e "\n===== 2. EJECUTABLE ====="
command -v $1 || echo "No encontrado"

echo -e "\n===== 3. SERVICIOS SYSTEMD ====="
systemctl list-unit-files --type=service | grep -i $1 || echo "No hay servicios registrados"

echo -e "\n===== 4. ESTADO DE LOS SERVICIOS ====="
#systemctl status $1 cloudflared-update --no-pager 2>&1
systemctl status $1 --no-pager 2>&1

echo -e "\n===== 5. PROCESOS ACTIVOS ====="
pgrep -af $1 || echo "No hay procesos activos"

echo -e "\n===== 6. CONFIGURACIÓN DEL SISTEMA ====="
sudo find /etc/$1 /etc/systemd/system \
	-maxdepth 2 -iname '*$1*' -print 2>/dev/null

echo -e "\n===== 7. CONFIGURACIÓN DEL USUARIO ====="
ls -la ~/.$1 2>&1

echo -e "\n===== 9. REPOSITORIOS RELACIONADOS ====="
grep -Ril '$1\|$1' \
	/etc/pacman.conf /etc/pacman.d 2>/dev/null

echo -e "\n===== FIN DE LA COMPROBACIÓN ====="
