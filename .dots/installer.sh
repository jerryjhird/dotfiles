#!/bin/bash

mkdir -p /etc/apt/keyrings
mkdir -p /etc/apt/sources.list.d/

if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        echo "Adding Universe APT Source"
        apt install software-properties-common
        add-apt-repository -y universe
    elif [[ "$ID" == "debian" ]]; then
        echo "Adding Ubuntu Universe Source Repo"
        echo -e "Types: deb\nURIs: http://archive.ubuntu.com/ubuntu/\nSuites: focal\nComponents: universe\nSigned-By: " > /etc/apt/sources.list.d/ubuntu.sources
        echo -e "deb https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/Debian_12/ /\nTypes: deb\nURIs: https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/Debian_12/\nSuites: /\nComponents: \nSigned-By: " > /etc/apt/sources.list.d/waterfox.list
    else
        echo "unsupported distro"
        exit 1
    fi
else
    echo "/etc/os-release not found. your system is weird."
    exit 1
fi

apt update
apt full-upgrade

packages=(
    curl
    git
    linux-firmware
    ffmpeg
    fastfetch
    hyprland
    waybar
    swaybg
    foot
    sddm
    pipewire
    pulsemixer
    nano
    python3
    waterfox
)

apt install -y "${packages[@]}"

systemctl enable sddm
sudo reboot
