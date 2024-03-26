#!/usr/bin/bash

source ~/git/scripts/rofi_env.sh

msg="Uptime : `uptime -p | sed -e 's/up //g'`"

options=(
    "Lock"
    "Logout"
    "Suspend"
    "Hibernate"
    "Reboot"
    "Shutdown"
)

run_rofi() {
    for str in ${options[@]}; do echo $str; done | rofi_dmenu "[Action]" "$msg"
}

confirm_run () {
    selected="$(rofi_yesno)"
    if [[ "$selected" == "$rofi_yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    ${options[0]})
        bash $HOME/git/scripts/i3lock.sh
        ;;
    ${options[1]})
        confirm_run 'kill -9 -1'
        ;;
    ${options[2]})
        confirm_run 'amixer set Master mute' 'bash $HOME/git/scripts/i3lock.sh' 'systemctl suspend'
        ;;
    ${options[3]})
        confirm_run 'systemctl hibernate'
        ;;
    ${options[4]})
        confirm_run 'systemctl reboot'
        ;;
    ${options[5]})
        confirm_run 'systemctl poweroff'
        ;;
esac

