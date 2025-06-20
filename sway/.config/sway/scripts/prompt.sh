#!/bin/bash

mode="$1"

workspace=$(zenity --entry --title="Custom Workspace" --text="Enter Custom Workspace Name:")

if [[ -z "$workspace" ]]; then
    exit 0
fi

case "$mode" in
    switch)
        swaymsg workspace "$workspace"
        ;;
    move_to)
        swaymsg move container to workspace "$workspace"
        ;;
esac
