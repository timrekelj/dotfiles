#!/usr/bin/bash

[[ "$SWAYSOCK" ]] && {
    TIMEOUT=600

    BACKGROUND_COLLECTION=~/Pictures/Wallpapers/LockScreens/
    BACKGROUND=$( ls $BACKGROUND_COLLECTION | shuf -n 1)
    case "$1" in
        lock-now)
            BG='&'
            [[ "$2" == "wait" ]] && BG=''
            swaylock -f --image "$BACKGROUND_COLLECTION/$BACKGROUND" $BG
            ;;

        lock-off)
            pkill swayidle
            swayidle -w \
                timeout $TIMEOUT  "swaymsg 'output * dpms off'" \
                resume            "swaymsg 'output * dpms on'" \
                before-sleep      "mylock lock-now wait; mylock enable-lock" &
            rofi -width 20 -e "screen lock disabled"
            ;;

        enable-lock|*)
            pkill swayidle
            swayidle -w \
                timeout $TIMEOUT                "swaymsg 'output * dpms off'"  resume "swaymsg 'output * dpms on'" \
                timeout $(( TIMEOUT * 2 ))      "swaymsg 'output * dpms on'; mylock lock-now" \
                timeout $(( TIMEOUT * 3 ))      "swaymsg 'output * dpms off'" resume "swaymsg 'output * dpms on'" \
                timeout $(( TIMEOUT * 4 ))      "sudo systemctl suspend" \
                before-sleep                    "mylock lock-now wait" &
            ;;
    esac

    #ps -ef |grep '[s]wayidle'
    exit $?
}

