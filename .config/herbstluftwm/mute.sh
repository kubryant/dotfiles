check=$(amixer get Master | grep off)
if [ -z "$check" ] ; then
    echo "mute"
    amixer set Master mute
else
    echo "unmute"
    amixer set Master unmute
fi
