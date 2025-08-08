#!/bin/bash

TOKEN="$1"
COMMAND="$2"

if [[ -z "$TOKEN" || -z "$COMMAND" ]]; then
  echo "Usage: $0 <OAuth_Token> {playpause|pause|next|previous|status}"
  exit 1
fi

case "$COMMAND" in
  playpause)
    notify-send "Spotify" "Playing Track"
    curl -X PUT "https://api.spotify.com/v1/me/player/play" -H "Authorization: Bearer $TOKEN"
    ;;
  pause)
    notify-send "Spotify" "Paused Track"
    curl -X PUT "https://api.spotify.com/v1/me/player/pause" -H "Authorization: Bearer $TOKEN"
    ;;
  next)
    notify-send "Spotify" "Skipped Track"
    curl -X POST "https://api.spotify.com/v1/me/player/next" -H "Authorization: Bearer $TOKEN"
    ;;
  previous)
    notify-send "Spotify" "Jumping To Previous Track"
    curl -X POST "https://api.spotify.com/v1/me/player/previous" -H "Authorization: Bearer $TOKEN"
    ;;
  status)
    curl -s -X GET "https://api.spotify.com/v1/me/player/currently-playing" -H "Authorization: Bearer $TOKEN"
    ;;
  *)
    echo "Usage: $0 <OAuth_Token> {playpause|pause|next|previous|status}"
    exit 1
    ;;
esac
