#!/bin/sh

CATGIRL_DIR="$HOME/Pictures/Catgirls"
mkdir -p "$CATGIRL_DIR"

download_catgirl() {
  response=$(curl -s "https://nekos.moe/api/v1/random/image?nsfw=false")
  id=$(echo "$response" | jq -r '.images[0].id')
  url="https://nekos.moe/image/$id"
  filename="cg_${id}.jpg"
  filepath="$CATGIRL_DIR/$filename"

  if [ ! -f "$filepath" ]; then
    curl -s "$url" -o "$filepath"
  fi
  echo "catgirl has been summoned :3"
}

clear_cg_cache() {
  if [ -d "$CATGIRL_DIR" ]; then
    files=$(find "$CATGIRL_DIR" -type f -name 'cg_*')
    for file in $files; do
      rm "$file"
    done
  fi
}

open_feh() {
  feh "$CATGIRL_DIR"
}


case "$1" in
  clear_cache)
    clear_cg_cache
    ;;
  summon_catgirl)
    download_catgirl
    ;;
  open_feh)
    open_feh
    ;;
  *)
    echo "Usage: $0 {clear_cache|summon_catgirl|open_feh}"
    exit 1
    ;;
esac
