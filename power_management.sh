#!/usr/bin/env bash

# Theme Elements
mesg="Uptime : `uptime -p | sed -e 's/up //g'`"

# Options
option_1="Lock"
option_2="Logout"
option_3="Suspend"
option_4="Hibernate"
option_5="Reboot"
option_6="Shutdown"
yes='Yes'
no='No'

# Rofi CMD
rofi_cmd() {
    rofi -theme-str "listview {columns: 1; lines: 6;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "[Action]" \
        -mesg "$mesg" \
        -markup-rows
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?'
}

# Ask for confirmation
confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

# Confirm and execute
confirm_run () {
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
        bash $HOME/git/scripts/i3lock.sh
        ;;
    $option_2)
        confirm_run 'kill -9 -1'
        ;;
    $option_3)
        confirm_run 'amixer set Master mute' 'bash $HOME/git/scripts/i3lock.sh' 'systemctl suspend'
        ;;
    $option_4)
        confirm_run 'systemctl hibernate'
        ;;
    $option_5)
        confirm_run 'systemctl reboot'
        ;;
    $option_6)
        confirm_run 'systemctl poweroff'
        ;;
esac

