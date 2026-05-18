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
sudo pacman -S vlc gutenprint cups system-config-printer fish ghostty kitty neovim steam discord lutris wine wine-mono wine-gecko mono obs-studio linux-headers v4l2loopback-dkms gamescope gameconqueror rsync dkms jdk17-openjdk bluez-utils winetricks kdenlive kdeconnect okular gwenview transmission-gtk qnapi github-cli imagemagick ttf-jetbrains-mono ttf-fira-code ttf-fira-sans flatpak
check_success

# Instalacja reszy apek z AUR
echo "Instalacja apek z AUR."
yay -S zen-browser-bin vscodium-bin spotify onlyoffice-bin bpytop mangohud-git ttf-dejavu openrgb pnpm yt-dlp protontricks update-grub kvantum-qt6-git protonup-qt xone-dkms-git ttf-times-new-roman nwg-look qt5ct qt6ct
check_success

# Instalacja flathub
flatpak install flathub

# Ustawianie czasu na lokalny
echo "Ustawiam czas na lokalny."
timedatectl set-local-rtc 1 --adjust-system-clock
check_success

# Instalacja Hyprland z konfiguracją end_4
bash <(curl -s https://ii.clsty.link/get)

echo "Instalacja zakończona pomyślnie!"
