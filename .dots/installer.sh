#!/bin/bash

username_azfr=$(whoami)
substring_azfr="noface" 

if [[ "${username,,}" == *"${substring,,}"* ]]; then
    echo "The username contains '${substring}' (case-insensitive)."
else
    exit 1
fi

if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "ubuntu" ]]; then
        echo "Adding Universe APT Source"
        apt install software-properties-common
        add-apt-repository -y universe
    elif [[ "$ID" == "debian" ]]; then
        echo "Adding Trixie APT Source"
        echo "deb http://deb.debian.org/debian/ trixie main" | tee /etc/apt/sources.list.d/trixie.list
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
    sddm
    pipewire
    pulsemixer
    nano
    python3
    firefox
)

mkdir -p /etc/apt/keyrings
mkdir -p /etc/apt/sources.list.d/

echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" > /etc/apt/sources.list.d/mozilla.list
cat <<EOF > /etc/apt/keyrings/packages.mozilla.org.asc
-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBGCRt7MBCADkYJHHQQoL6tKrW/LbmfR9ljz7ib2aWno4JO3VKQvLwjyUMPpq
/SXXMOnx8jXwgWizpPxQYDRJ0SQXS9ULJ1hXRL/OgMnZAYvYDeV2jBnKsAIEdiG/
e1qm8P4W9qpWJc+hNq7FOT13RzGWRx57SdLWSXo0KeY38r9lvjjOmT/cuOcmjwlD
T9XYf/RSO+yJ/AsyMdAr+ZbDeQUd9HYJiPdI04lGaGM02MjDMnx+monc+y54t+Z+
ry1WtQdzoQt9dHlIPlV1tR+xV5DHHsejCZxu9TWzzSlL5wfBBeEz7R/OIzivGJpW
QdJzd+2QDXSRg9q2XYWP5ZVtSgjVVJjNlb6ZABEBAAHNVEFydGlmYWN0IFJlZ2lz
dHJ5IFJlcG9zaXRvcnkgU2lnbmVyIDxhcnRpZmFjdC1yZWdpc3RyeS1yZXBvc2l0
b3J5LXNpZ25lckBnb29nbGUuY29tPsLAjgQTAQoAOBYhBDW6oLM+nrOW9ZyoOMC6
XObcYxWjBQJgkbezAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMC6XObc
YxWj+igIAMFh6DrAYMeq9sbZ1ZG6oAMrinUheGQbEqe76nIDQNsZnhDwZ2wWqgVC
7DgOMqlhQmOmzm7M6Nzmq2dvPwq3xC2OeI9fQyzjT72deBTzLP7PJok9PJFOMdLf
ILSsUnmMsheQt4DUO0jYAX2KUuWOIXXJaZ319QyoRNBPYa5qz7qXS7wHLOY89IDq
fHt6Aud8ER5zhyOyhytcYMeaGC1g1IKWmgewnhEq02FantMJGlmmFi2eA0EPD02G
C3742QGqRxLwjWsm5/TpyuU24EYKRGCRm7QdVIo3ugFSetKrn0byOxWGBvtu4fH8
XWvZkRT+u+yzH1s5yFYBqc2JTrrJvRU=
=QnvN
-----END PGP PUBLIC KEY BLOCK-----
EOF

apt install -y "${packages[@]}"

systemctl enable sddm
sudo reboot
