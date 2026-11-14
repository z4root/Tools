#!/usr/bin/env sh

#	Author	-	z4root
#	Repo	-	https://github.com/z4rrot/Tools/Arch-minimal
#	arch-minimal - Script to install dotfiles
#
# Copyright (C) 2026-2027 z4root
# Licensed under GPL-3.0 license

logo() {
	text="$1"
	printf "%b" "
          .            *            .
                   /\ 
                  /  \     /\  
               __/    \___/  \__    
            __/                 \__  
           /     ___ __ ___       \ 
          /    /  o      O  \     \ 
         |    |    ______    |    |
         |    |    \^^^^/    |    |
         |    |     |__|     |    |
          \    \___/    \___/    /
           \________    ________/

       .            *            .
        
${BLD}${CRE}[ ${CYE}${text} ${CRE}]${CNC}\n\n"
}

logo "Add gh0stzk custom repo"

# Instalar paru

# git clone https:/aur.archlinux.org/paru.git #(Local compilation For my is better less problems in my experience than 'paru-bin'.)
# cd /paru
# make -si

# Opcional
# Agrear el repositorio para tener las herramientas de black arch
# curl -O https://balckarch.org/strap.sh
# chmod +x strap.sh
# sudo ./strap.sh

initial_checks() {
	# Verificar usuario root

	if [ "$(id -u)" = 0 ]; then
		printf "This script MUST NOT be run as root user."
		exit 1
	fi

	# Verificar directorio HOME
	if [ "$PWD" != "$HOME" ]; then
		printf "The script must be executed from HOME directory."
		exit 1
	fi
}

# Instalar el servidor y el init

# pacman -S xorg xorg-server xorg-xinit

# verificar de aplicaciones

bspwm_loc=$(type -p bspwm 2>/dev/null)
sxhkd_loc=$(type -p sxhkd 2>/dev/null)
virt_manager_loc=$(type -p virt-manager 2>/dev/null)
obsidian_loc=$(type -p obsidian)
term=$(echo $TERM)

# ~/.config/{bspwms,sxhkd}
# ~/.config/{bspwms/scripts}

if [[ -s "$bspwm_loc" ]]; then
	echo "Existe bspwm"
else
	echo "Instalando bspwm [y/n]"
fi

if [[ -s "$sxhkd_loc" ]]; then
	echo "Existe sxhkd"
else
	echo "No existe sxhkd"
fi

if [ $term == "alacritty" ]; then
	echo "Ya tienes alacritty"
else
	echo "Se instalara alacrity..."
fi

if [ -s "$virt_manager_loc" ]; then
	echo "Ya tienes virt manager"
else
	echo "Se instalara virt manager..."
fi

if [ -s "$obsidian_loc" ]; then
	echo "Ya tienes obsidian"
else
	echo "Se instalara obsidian..."
fi
