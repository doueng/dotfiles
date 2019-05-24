#!/bin/sh

# Adjust keyboard typematic delay and rate
xset r rate 200 50

# Start Xorg server at this DPI
xrandr --dpi 227

# Merge and load config from .Xresources
xrdb -merge ~/.Xresources

# wallpaper
feh --bg-fill ~/.config/wall.png

compton &
# hide mouse pointer
unclutter --timeout 1 --ignore-scrolling &
emacs --bg-daemon 2> /dev/null
sxhkd &
dunst &

# Start dwm
exec dwm
