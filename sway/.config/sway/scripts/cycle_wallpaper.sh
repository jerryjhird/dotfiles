#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SYMLINK="$HOME/Pictures/sym_wallpaper"

prefix="wp_"

# If '--unsafe' is passed, switch to 'swp_'
if [[ "$1" == "--unsafe" ]]; then
    prefix="swp_"
fi

mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \
    \( -iname "${prefix}*.jpg" -o -iname "${prefix}*.png" -o -iname "${prefix}*.jpeg" \) | sort)

if [[ ${#wallpapers[@]} -eq 0 ]]; then
    echo "No wallpapers found with prefix '${prefix}'"
    exit 1
fi

current=$(readlink "$SYMLINK") # get the current symlink target and determine current index
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
