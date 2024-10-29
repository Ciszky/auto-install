#!/bin/bash

#Sprawdzanie czy komenda zakończyła się poprawnie.
check_success(){
	if [ $? -ne 0 ]; then
		echo "Błąd. Nie będziesz miał internetu."
		exit 1
	fi
}

# Instalacja pakietów niezbędnych do uruchomienia yay
echo "Instaluje yay."
sudo pacman -S --needed git base-devel
check_success

# Klonowanie yay z AUR i instalacja
if ! command -v yay &> /dev/null; then
    echo "Klonowanie yay..."
    git clone https://aur.archlinux.org/yay.git
    check_success
    cd yay || exit
    echo "Instalacja yay..."
    makepkg -si
    check_success
    cd ..
    rm -rf yay
else
    echo "yay jest już zainstalowany."
fi

#Instalacja pakietów związanych z powolnym internetem bezprzewodowym.
echo "Insalowanie sterowników do AX200."
yay -S iwlwifi-lar-disable-dkms networkmanager-iwd

#Restartowanie w celu zatwierdzenia zmian.
reboot
