#!/bin/bash

COMMAND="$1"

case "$COMMAND" in
  playpause)
    if playerctl play-pause; then
      notify-send "Media Player" "Toggled play/pause"
    fi
    ;;
  pause)
    if playerctl pause; then
      notify-send "Media Player" "Paused playback"
    fi
    ;;
  next)
    if playerctl next; then
      notify-send "Media Player" "Skipped to next track"
    fi
    ;;
  previous)
    if playerctl previous; then
      notify-send "Media Player" "Skipped to previous track"
    fi
    ;;
  *)
    echo "Usage: $0 {playpause|pause|next|previous}"
    exit 1
    ;;
esac
