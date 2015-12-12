#!/bin/bash
battery_icon=("\ue113" "\ue114" "\ue115" "\ue116" "\ue042")
network_icon=("\ue0f1" "\ue0f2" "\ue0f3" "\ue0af")
music_icon="\ue05c"

music()
{
    # Music
#    player_status=$(playerctl status)
#    if [ $player_status = "Playing" ]; then
#        player_artist=$(playerctl metadata artist)
#        player_title=$(playerctl metadata title)
#        playing="$player_title - $player_artist"

#        if [ "$current" != "$playing" ] ; then
#            current=$playing
#            scrolling=$current
#        elif [ ${#scrolling} -gt "24" ] ; then
#            scrolling=${scrolling:1}
#        else
#            scrolling=$current
#        fi

#        echo -e "music\t$music_icon ${scrolling:0:24}"
#    else
#        echo -e "music\toff"
#    fi

    echo -e ""
}

volume()
{
    # Volume
    volumes=$(\
        amixer get Master -M | \
        grep "Mono: Playback"\
    )
    vol=$(\
        echo $volumes | \
        sed "s/.*\[\([0-9]*\)%\].*/\1/"\
    )
    vol_status=$(\
        echo $volumes | cut -d ' ' -f 6
    )

    echo $vol_status

    if [ "$vol_status" == "[off]" ] ; then
        vol_status="Muted"
    else
        vol_status=""
    fi

    if [ -z $vol ] ; then
        echo -e "volume\toff"
    else
        echo -e "volume\t%{F$acolor_fg}\ue05d $vol% $vol_status%{F-}"
    fi
}

network()
{
    # Network
    wifi=wlp1s0

    iwconfig=$(iwconfig $int)
    ssid=$(
        echo $iwconfig | \
        sed "s/.*ESSID:\(\".*\"\).*/\1/" | \
        sed "s/.*\(off\/any\).*/\"\1\"/" | \
        sed "s/.*\"\(.*\)\".*/\1/"
    )

    quality=$( \
        echo $iwconfig | \
        sed "s/^.*Link Quality=\([0-9]*\)\/\([0-9]*\) .*$/(\1*100)\/\2/" | \
        bc
    )

    if [ $ssid == "off/any" ] ; then
        echo -e "net\tNo WiFi"
    elif [ $quality -lt 33 ] ; then
        echo -e "net\t${network_icon[0]}$ssid"
    elif [ $quality -lt 66 ] ; then
        echo -e "net\t${network_icon[1]}$ssid"
    else
        echo -e "net\t${network_icon[2]}$ssid"
    fi
}

battery()
{
    # Battery
    if $(test -e /sys/class/power_supply/BAT1) ; then
        bat_lvl=$(cat /sys/class/power_supply/BAT1/capacity)
        bat_state=$(cat /sys/class/power_supply/BAT1/status)

        if [ $bat_state == "Charging" ] ; then
            bat_status="${battery_icon[4]}Charging - "
        elif [ $bat_lvl -lt 10 ] ; then
            bat_status="${F$acolor_accent}${battery_icon[0]}${F-}"
        elif [ $bat_ -lt 33 ] ; then
            bat_status="${battery_icon[1]}"
        elif [ $bat_lvl -lt 66 ] ; then
            bat_status="${battery_icon[2]}"
        else
            bat_status="${battery_icon[3]}"
        fi

        echo -e "battery\t$bat_status$bat_lvl%"
    else
        echo -e "battery\toff"
    fi
}

clock()
{
    echo -e $(date +$"date\t%{F$acolor_fg}%-I:%M %p %{F$acolor_fg}(%A, %B %-d)%{F-}")
}
