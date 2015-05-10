#!/bin/sh

# load Xresources
xrdb -load ~/.Xresources &

# load background
feh --bg-scale ~/.wallpaper/paper-planes.jpg

# prevent mouse click while typing
syndaemon -d -k -t -i 1

# others
compton -b --config ~/.compton
redshift -c ~/.config/redshift.conf &

# load WM
exec herbstluftwm --locked
