#!/usr/bin/bash

# $1: prompt
# $2: message
rofi_dmenu() {
    args=(
      -theme-str 'listview {columns: 1; lines: 6;}'
      -theme-str 'textbox-prompt-colon {str: "";}'
      -dmenu
      -p $1
      -markup-rows
    )
    if [ -n "$2" ]; then
        args+=(-mesg "$2")
    fi
    rofi "${args[@]}"
}

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

rofi_yes='Yes'
rofi_no='No'

rofi_yesno() {
    printf "$rofi_yes\n$rofi_no" | confirm_cmd
}
