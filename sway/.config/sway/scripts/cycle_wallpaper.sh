#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SYMLINK="$HOME/Pictures/sym_wallpaper"

mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

current=$(readlink "$SYMLINK")

for i in "${!wallpapers[@]}"; do
    if [[ "${wallpapers[$i]}" == "$current" ]]; then
        index=$i
        break
    fi
done

index=${index:- -1}
next_index=$(( (index + 1) % ${#wallpapers[@]} ))

ln -sf "${wallpapers[$next_index]}" "$SYMLINK"

swaymsg output "*" bg "$SYMLINK" fill
