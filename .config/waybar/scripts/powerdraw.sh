#!/bin/bash

powerDraw="N/A"

if [ -f /sys/class/power_supply/BAT0/power_now ]; then
  power_now=$(cat /sys/class/power_supply/BAT0/power_now)
  powerDraw="⚡ $((power_now / 1000000))W"
fi

cat << EOF
{ "text": "$powerDraw", "tooltip": "Power Draw: $powerDraw" }
EOF
