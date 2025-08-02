#!/bin/bash

# Config
SYMLINK="$HOME/Pictures/sym_wallpaper"
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Parse args
UNSAFE=false
if [[ "$1" == "--unsafe" ]]; then
  UNSAFE=true
fi

# Function to check if filename starts with wp_
starts_with_wp() {
  filename=$(basename "$1")
  [[ "$filename" == wp_* ]]
}

# Resolve symlink target if it exists
if [ -L "$SYMLINK" ]; then
  target_path=$(readlink -f "$SYMLINK")
else
  target_path=""
fi

selected_image=""

if $UNSAFE; then
  # Just use symlink target no matter what
  if [ -n "$target_path" ] && [ -f "$target_path" ]; then
    selected_image="$target_path"
  else
    echo "Error: Symlink target does not exist or is not a file."
    exit 1
  fi
else
  # Safe mode: check if target starts with wp_
  if [ -n "$target_path" ] && starts_with_wp "$target_path" && [ -f "$target_path" ]; then
    selected_image="$target_path"
  else
    # Find first image starting with wp_ in wallpaper dir
    first_wp_image=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f -name "wp_*" | sort | head -n 1)
    if [ -n "$first_wp_image" ]; then
      selected_image="$first_wp_image"
    else
      echo "Error: No images starting with 'wp_' found in $WALLPAPER_DIR"
      exit 1
    fi
  fi
fi

# Run swaylock with selected image as background
swaylock -i "$selected_image"
