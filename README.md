# auto-install
Skrypty do automatycznej instalacji i konfiguracji pakietów Arch Linux po świeżej instalacji systemu.

## install-apek.sh
Skrypt instaluje najpierw `git` oraz  `base-devel` potrzebny do zainstalowania `yay`. Następnie klonuje repo, wchodzi do katalogu i go buduje.

Po zbudowaniu zaczyna pobierać pakiety "**pierwszej ciszkowej potrzeby**" za pomocą menadżera pakietów `pamac`. Pakiety skupiają się głównie na programach związanych z środowiskiem grafycznym KDE Plasma. Wersja GNOME ~~jest~~ będzie dostępna w innym repo.

Na koniec ustawia czas zegara systemowego na lokalny, co zapobiega przestawianiu czasu podczas dual boot z systemem Windows 10/11.

## install-firewall.sh
Skrypt pobiera i instaluje pakiety `clamav`, `clamtk` i `firewalld`. 

Po instalacji włącza usługę `firewalld` i korzysta z klasy `check_success()` aby sprawdzić poprawność wykonania komend.

Klasa `check_success()` jest wykonywana po każdej komendzie.

Aby zezwolić na korzystanie z aplikacji KDE Connect, wykonywana jest komenda otwierająca zakres portów 1714-1764 na protokołach UDP i TCP.

Na koniec w celu zatwierdzenia zmian, `firewalld` jest restartowane i komenda `sudo freshclam` aktualizuje baze sygnatur.

## install-vmware.sh
Skrypt instaluje pakiet `vmware-workstation` z Arch User Repository i włącza `vmware-networks-configuration.service` aby wygenerować pierwszą konfiguracje sieci wirtualnych.
> For `vmware-workstation`, start `vmware-networks-configuration.service` first to generate `/etc/vmware/networking`.

Na koniec usługi sieciowe i kontrolujące USb są włączone i instalacja pakietów jest zakończona.

# Koniec
Po wykonaniu tych trzech skryptów jesteś gotowy na korzystanie ze swojego systemu.

Miłego!