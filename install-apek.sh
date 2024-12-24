#!/bin/bash

# Funkcja do sprawdzania czy komenda zakończyła się powodzeniem
check_success() {
    if [ $? -ne 0 ]; then
        echo "Skrypt się wyjebał. Anuluje siorbanie apek z neta."
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

# Instalacja pakietów z oficjalnych repozytoriów pacman
echo "Instalacja pakietów pierwszej ciszkowej potrzeby"
sudo pacman -S vlc gutenprint cups system-config-printer fish neofetch steam steam-native-runtime lutris wine wine-mono wine-gecko mono obs-studio linux-headers v4l2loopback-dkms nodejs gamescope gameconqueror rsync dkms jdk17-openjdk bluez-utils winetricks kdenlive kdeconnect okular gwenview transmission-qt qnapi
check_success

# Instalacja reszy apek z AUR
echo "Instalacja apek z AUR."
yay -S brave-bin vscodium-bin spotify freeoffice onlyoffice-bin bpytop mangohud-git gzdoom-bin raze-bin ttf-dejavu openrgb minecraft-launcher pnpm yt-dlp caprine protontricks qemu docker vpcs dynamips libvirt ubridge inetutils gns3-server gns3-gui update-grub kvantum-qt6-git librewolf-bin vesktop-bin jetbrains-toolbox heroic-games-launcher protonup-qt xone-dlundqvist-dkms-git
check_success

# Ustawianie czasu na lokalny
echo "Ustawiam czas na lokalny."
timedatectl set-local-rtc 1 --adjust-system-clock
check_success

echo "Instalacja zakończona pomyślnie!"
