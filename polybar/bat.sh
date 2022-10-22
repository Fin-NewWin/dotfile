#!/bin/sh

BATTERY=/sys/class/power_supply/BAT?
BATTERY_PERCENT="$BATTERY/capacity"
BATTERY_STATUS="$BATTERY/status"


BATTERY_IF_CHARGING="discharging"

BATTERY_SUM=0

for i in $BATTERY_PERCENT
do
    BATTERY_SUM=$(( BATTERY_SUM + $(cat $i) ))
done

BATTERY_SUM=$(( BATTERY_SUM / 2 ))

bat_stat () {
    for i in $BATTERY_STATUS
    do
        if [ "$(cat $i)" = "Charging" ]
        then
            BATTERY_COLOR="#B8BB26"
            BATTERY_IF_CHARGING="charging"
            break
        fi
    done
}

if [ $# -eq 1 ]
then
    if [ "$1" = "notify" ]
    then
        bat_stat
        notify-send "Battery Status" "Battery level is $BATTERY_SUM%, $BATTERY_IF_CHARGING" -u low \
            -i  "/usr/share/icons/Adwaita/64x64/devices/battery-symbolic.symbolic.png"
        return
    fi
fi

if [ $BATTERY_SUM -lt 10 ]
then
    BATTERY_COLOR="#FB4934"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 15 ]
then
    BATTERY_COLOR="#FB4934"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 25 ]
then
    BATTERY_COLOR="#FABD2F"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 40 ]
then
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 50 ]
then
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 75 ]
then
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 90 ]
then
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
elif [ $BATTERY_SUM -le 95 ]
then
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
else
    BATTERY_COLOR="#EBDBB2"
    BATTERY_ICON=" "
fi


bat_stat


echo "%{T2}%{F$BATTERY_COLOR}$BATTERY_ICON%{F-}%{T-}$BATTERY_SUM%"
