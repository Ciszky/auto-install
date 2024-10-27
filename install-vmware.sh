#!/bin/bash

# Funkcja do sprawdzania czy komenda zakończyła się powodzeniem
check_success() {
    if [ $? -ne 0 ]; then
        echo "Wydupcyło się. Zatrzymano skrypt."
        exit 1
    fi
}

# Instalacja VMware Workstation za pomocą yay
echo "Instalacja VMware Workstation..."
yay -S vmware-workstation
check_success

# Uruchomienie usługi sieciowej VMware
echo "Uruchamianie vmware-networks-configuration"
sudo systemctl start vmware-networks-configuration.service
check_success

# Ładowanie modułów kernela dla VMware
echo "Ładowanie modułów vmw_vmci i vmmon..."
sudo modprobe -a vmw_vmci vmmon
check_success

# Włączanie automatycznego uruchamiania usług sieciowych i USB dla VMware
echo "Włączanie usług vmware-networks.service oraz vmware-usbarbitrator.service..."
sudo systemctl enable vmware-networks.service
check_success
sudo systemctl enable vmware-usbarbitrator.service
check_success

echo "Zainstalowano VMWare Workstation."
