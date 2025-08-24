#!/bin/bash

if [ -z "$SWAYSOCK" ]; then
    echo "Sway is not running, to install these dotfiles you must be using Sway."
    exit 1
fi

mkdir -p "$HOME/.config"

rm -rf "/tmp/jerrydotfiles"
echo "cloning git repo"
git clone --depth=1 "https://github.com/jerryslang/dotfiles.git" "/tmp/jerrydotfiles" || {
    echo "❌ Failed to clone repo."
    exit 1
}

SOURCE_DIR="/tmp/jerrydotfiles/sway/.config"
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Source directory $SOURCE_DIR does not exist in repo."
    exit 1
fi

OVERWRITE_FILES=""
while IFS= read -r -d '' file; do
    REL_PATH="${file#$SOURCE_DIR/}"
    if [ -e "$HOME/.config/$REL_PATH" ]; then
        OVERWRITE_FILES="$OVERWRITE_FILES\n$REL_PATH"
    fi
done < <(find "$SOURCE_DIR" -type f -print0)

if [ -n "$OVERWRITE_FILES" ]; then
    echo "⚠️  The following files already exist and will be overwritten:"
    printf "%b\n" "$OVERWRITE_FILES"
    printf "Do you want to proceed? (y/n): "
    read confirm
    case "$confirm" in
        y|Y) ;;
        *) echo "Aborting installation."; exit 0 ;;
    esac
fi

rsync -av --progress "$SOURCE_DIR/" "$HOME/.config/"
rsync -av --progress "/tmp/jerrydotfiles/sway/Pictures/" "$HOME/Pictures/"

rm -rf "/tmp/jerrydotfiles"

chmod +x ~/.config/sway/scripts/*
ln -sf ~/Pictures/Wallpapers/wp_wallpaper1.jpg ~/Pictures/sym_wallpaper
swaymsg reload
echo "Installation complete."
