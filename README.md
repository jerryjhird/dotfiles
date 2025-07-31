# Sway Dotfiles

> [!TIP]
> if the wallpaper, mod+*+w or mod+*+0 arent working after install. try using chmod +x on all files in the .config/sway/scripts folder and ensure that your wallpaper(s) are placed in the correct dir [Info here](https://github.com/Jerryslang/dotfiles#Wallpapers)

this happens when the scripts arent marked as executable and the wallpaper symlink hasnt been created yet

![Screenshot](https://i.imgur.com/cJcNyCZ.png)

requirements:
[sway waybar rofi xwayland sddm fastfetch grim slurp, zenity mako]

" $mod represents the variable in the sway config file, its set to super by default"

## Included Scripts:

Wallpaper cycler (cycles through wallpapers in the {~/Pictures/Wallpapers} folder)    (must be .jpg or .jpeg)

Workspace Prompt (allows the use of custom names or numbers for workspaces using zenity to prompt for them) (unlimited workspaces)

## Standard Keybinds

$mod+D // opens $menu (wofi with custom flags)
$mod+Shift+D // opens wofi in run mode

$mod+W // Changes wallpaper to the next wallpaper in the Pictures/Wallpaper Folder

$mod+Return // Starts $term (foot)

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

## Wallpapers

wallpapers are handled by a custom script wich allows you to place any wallpaper you want at anytime inside of the ~/Pictures/Wallpapers folder and cycle through them using a keybind

this script has 2 modes for 2 different lists of wallpapers

### the first list

the first list cycles through wallpapers in the before mentioned wallpaper folder

as long as they start with "wp_" for there filenames

### the second list

the second list does the same thing but for flenames starting with "swp_"

(this first list can be cycled through using Mod+W)

(thie second list can be cycled through using Mod+Shift+W)

