#!/bin/bash

# Define power options
options="Poweroff\nReboot\nSuspend\nLogout"

# Use dmenu to select an option
choice=$(echo -e "$options" | dmenu -i)

# Execute the selected option
case $choice in
    "Poweroff")
        doas poweroff
        ;;
    "Reboot")
        doas reboot
        ;;
    "Suspend")
        doas zzz
        ;;
    "Logout")
        pkill -u $USER
        ;;
esac
