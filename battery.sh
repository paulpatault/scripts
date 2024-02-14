#!/usr/bin/env bash

# Battery Info
battery="`acpi -b | cut -d',' -f1 | cut -d':' -f1`"
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"
time="`acpi -b | cut -d',' -f3`"

if [[ -z "$time" ]]; then
    time=' Fully Charged'
fi

mesg="${battery}: ${percentage}%,${time}"

active=""
urgent=""
if [[ $status = *"Charging"* ]]; then
    active="-a 1"
elif [[ $status = *"Full"* ]]; then
    active="-u 1"
else
    urgent="-u 1"
fi

# Options
option_1="Remaining"
option_2="Status"
option_3="Settings"

rofi_cmd() {
    rofi -dmenu \
        -mesg "$mesg" ${active} ${urgent} \
        -markup-rows
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
        notify-send -u low "Remaining : ${percentage}%"
        ;;
    $option_2)
        notify-send -u low "Status : $status"
        ;;
    $option_3)
        xfce4-power-manager-settings
        ;;
esac
