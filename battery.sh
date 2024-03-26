#!/usr/bin/env bash

# Battery Info
battery="`acpi -b | cut -d',' -f1 | cut -d':' -f1`"
status="`acpi -b | cut -d',' -f1 | cut -d':' -f2 | tr -d ' '`"
percentage="`acpi -b | cut -d',' -f2 | tr -d ' ',\%`"
time="`acpi -b | cut -d',' -f3`"

if [[ -z "$time" ]]; then
    time=' Fully Charged'
fi

msg="${battery}: ${percentage}%,${time}"

active=""
urgent=""
if [[ $status = *"Charging"* ]]; then
    active="-a 1"
elif [[ $status = *"Full"* ]]; then
    active="-u 1"
else
    urgent="-u 1"
fi

options=(
    "Remaining"
    "Status"
    "Settings"
)

rofi_cmd() {
    rofi -dmenu -mesg "$msg" ${active} ${urgent} -markup-rows
}

run_rofi() {
    for str in ${options[@]}; do echo $str; done | rofi_cmd
}

chosen="$(run_rofi)"

case ${chosen} in
    ${options[0]})
        notify-send -u low "Remaining : ${percentage}%"
        ;;
    ${options[1]})
        notify-send -u low "Status : $status"
        ;;
    ${options[2]})
        xfce4-power-manager-settings
        ;;
esac
