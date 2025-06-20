# SwayFX Dotfiles

> [!TIP]
> if the wallpaper, mod+w or mod+0 / mod+shift+0 arent working after install use Mod+Shift+C

### also contains a zsh config

![Screenshot](https://i.imgur.com/dTmIZn3.jpeg)

requirements:
[swayfx waybar rofi xwayland sddm pipewire pipewire-pulseaudio pipewire-alsa fastfetch grim slurp, zenity]

oh-my-zsh-requirements:
[zsh-autosuggestions powerlevel10k]

" $mod represents the variable in the sway config file, its set to super by default"

## Included Scripts:

Wallpaper cycler (cycles through wallpapers in the {~/Pictures/Wallpapers} folder)    (must be .jpg or .jpeg)

Workspace Prompt (allows the use of custom names or numbers for workspaces using zenity to prompt for them) (unlimited workspaces)

## Zsh Links

powerlevel10k https://github.com/romkatv/powerlevel10k

oh-my-zsh https://ohmyz.sh/#install

zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions/

## Standard Keybinds

$mod+D // Rofi start menu

$mod+W // Changes wallpaper to the next wallpaper in the Pictures/Wallpaper Folder

$mod+Return // Starts Terminal (foot)

$mod+Q // Quits Selected Application

$mod+SHIFT+E // Quits Sway

$mod+F // Fullscreens current selected application

$mod+PRINT // Screenshots whole screen

$mod+SHIFT+PRINT // Screenshots region of the screen

$mod+SHIFT+C // Reloads Sway Config and makes the scripts in the scripts folder executable and runs the wallpaper switcher (basically a fix keybind)

$mod+{ARROW_DIRECTION} // Selects application to the specified direction of current selected application

$mod+SHIFT+{ARROW_DIRECTION} // Moves current selected application to the specified direction

## Workspace Keybinds

" {NUMBER} represents any number from 1 to 9"

$mod+{Number} // Switches to workspace {number}

$mod+SHIFT+{Number} // moves container to workspace {Number}

$mod+0 // create / switch to workspace with custom name

$mod+SHIFT+0 // move window to workspace with custom name

## Mode keybinds

### Resize Mode: $mod+Alt+1

Left Arrow: shrinks window by 10px in width

Down Arrow: grows window by 10px in height

Up Arrow: shrinks window by 10px in height

Right Arrow: grows window by 10px in width

Esc: exits mode

### Application Mode: $mod+Alt+2
1: opens $term (foot)

2: opens firefox

3: opens $menu (rofi with custom flags)

4: opens codium inside ~/.zshrc

5: opens codium inside ~/.config/sway

Esc: exits mode

