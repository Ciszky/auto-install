#!/bin/bash

# Funkcja do sprawdzania czy komenda zakończyła się powodzeniem
check_success() {
    if [ $? -ne 0 ]; then
        echo "Błąd podczas wykonywania komendy. Zatrzymano skrypt."
        exit 1
    fi
}

# Instalacja pakietów firewalld, clamav i clamtk
echo "Instalacja antyświrów."
sudo pacman -S --needed firewalld clamav clamtk
check_success

# Uruchamianie usługi firewalld
echo "Uruchamianie firewalld..."
sudo systemctl start firewalld.service
check_success

echo "Włączenie firewalla przy starcie systemu..."
sudo systemctl enable firewalld.service
check_success

# Dodawanie portów do strefy publicznej w firewalld
echo "Dodawanie portów używanych przez KDE Connect do strefy publicznej..."
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp
check_success
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp
check_success

# Restart firewalld, aby zastosować zmiany
echo "Restart antyświra, aby zastosować zmiany..."
sudo systemctl restart firewalld.service
check_success

# Aktualizacja bazy sygnatur ClamAV
echo "Aktualizacja bazy sygnatur ClamAV za pomocą freshclam..."
sudo freshclam
check_success

echo "Antyświr zainstalowany. Tylko go musisz skonfiguorwać ręcznie."
echo "Szybki restart żeby antyświr się odpalił"
reboot
