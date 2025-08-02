# aliases
if [ -f "$HOME/.config/env.d/aliasrc" ]; then
  source "$HOME/.config/env.d/aliasrc"
fi

# env variables
if [ -f "$HOME/.config/env.d/varsrc" ]; then
  source "$HOME/.config/env.d/varsrc"
fi

fastfetch --config neofetch
