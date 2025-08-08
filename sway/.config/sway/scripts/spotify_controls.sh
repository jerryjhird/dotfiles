#!/bin/bash

# this script takes advantage of the discord api allowing me to fetch spotify tokens from discords spotify oauth app instead of you needing to setup your own

set -e

DISCORD_TOKEN="$1"
COMMAND="$2"

# Fetch connections from Discord API
connections_json=$(curl -s -H "Authorization: $DISCORD_TOKEN" \
  "https://discord.com/api/v9/users/@me/connections")

# Extract Spotify access token
SPOTIFY_TOKEN=$(echo "$connections_json" | jq -r '.[] | select(.type=="spotify") | .access_token')

if [ -z "$SPOTIFY_TOKEN" ] || [ "$SPOTIFY_TOKEN" == "null" ]; then
  echo "Spotify access token not found in your Discord connections."
  exit 1
fi

case "$COMMAND" in
  playpause)
    playing=$(curl -s -X GET "https://api.spotify.com/v1/me/player" -H "Authorization: Bearer $SPOTIFY_TOKEN" | jq -r '.is_playing')

    if [ "$playing" == "true" ]; then
      curl -s -X PUT "https://api.spotify.com/v1/me/player/pause" -H "Authorization: Bearer $SPOTIFY_TOKEN" > /dev/null
      notify-send "Spotify" "Pausing Track"
    else
      curl -s -X PUT "https://api.spotify.com/v1/me/player/play" -H "Authorization: Bearer $SPOTIFY_TOKEN" > /dev/null
      notify-send "Spotify" "Playing Track"
    fi
    ;;
  pause)
    curl -s -X PUT "https://api.spotify.com/v1/me/player/pause" -H "Authorization: Bearer $SPOTIFY_TOKEN" > /dev/null
    notify-send "Spotify" "Pausing Track"
    ;;
  next)
    curl -s -X POST "https://api.spotify.com/v1/me/player/next" -H "Authorization: Bearer $SPOTIFY_TOKEN" > /dev/null
    notify-send "Spotify" "Skipped Track"
    ;;
  previous)
    curl -s -X POST "https://api.spotify.com/v1/me/player/previous" -H "Authorization: Bearer $SPOTIFY_TOKEN" > /dev/null
    echo "Skipped to previous Track"
    ;;
  status)
    curl -s -X GET "https://api.spotify.com/v1/me/player/currently-playing" -H "Authorization: Bearer $SPOTIFY_TOKEN" | jq
    ;;
  *)
    usage
    ;;
esac
