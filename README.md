# Sway Dotfiles

> [!TIP]
> if the wallpaper, mod+*+w or mod+*+0 arent working after install. try using chmod +x on all files in the .config/sway/scripts folder and ensure that your wallpaper(s) are placed in the correct dir [Info here](https://github.com/Jerryslang/dotfiles#Wallpapers)

this happens when the scripts arent marked as executable and the wallpaper symlink hasnt been created yet

![Screenshot](https://i.imgur.com/cJcNyCZ.png)

requirements:
[sway waybar rofi xwayland sddm fastfetch grim slurp zenity mako jq]

" $mod represents the variable in the sway config file, its set to super by default"

## Included Scripts:

Wallpaper cycler (cycles through wallpapers in the {~/Pictures/Wallpapers} folder) (must be .jpg or .jpeg)

Workspace Prompt (allows the use of custom names or numbers for workspaces using zenity to prompt for them) (unlimited workspaces)

Catgirl Downloader (downloads catgirls)

Spotify Controls (control spotify using keybinds)

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

$mod+SHIFT+R // Reloads Sway Config

$mod+{ARROW_DIRECTION} // Selects application to the specified direction of current selected application

$mod+SHIFT+{ARROW_DIRECTION} // Moves current selected application to the specified direction

$mod+ALT+{ARROW_DIRECTION} // resizes Window in arrow key direction

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


(the first list can be cycled through using Mod+W)

(the second list can be cycled through using Mod+Shift+W)

### Swaylock

wallpapers for swaylock are handled the same as the desktop with 2 lists seperated by keybinds

`mod+l` for using list 1 wallpapers

`mod+shift+l` for using list 2 wallpapers

it will use whatever desktop is being used on sway at the moment but will only use list 2 wallpapers if you have used the `mod+shift+l` keybind

### Catgirl Downloader

a catgirl downloader script for downloading catgirl images (inspired by nyarch (also uses the same backend))

`mod+c` opens feh image viewer in the catgirl folder (use arrow keys to switch images)

`mod+Shift+c` downloads another catgirl image adding to the collection that is shown in the `mod+c` image viewer

### Spotify Intergration

to setup spotify get a valid oauth token for your account and replace `your_spotify_token` on the first line of .config/sway/config with your token

(notes: 
  
  do not include `Bearer {token}` only include the token part
  
  oauth tokens could expire meaning you will have to re-add your new token to the config

)

Controls:

Mod+Minus // switch to previous track

Nod+Equal // switch to next track
