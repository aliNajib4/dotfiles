
#!/bin/bash

# Function to change volume and notify
change_volume() {
    case $1 in
        inc)
            pactl set-sink-volume @DEFAULT_SINK@ +5%
            ;;
        dec)
            pactl set-sink-volume @DEFAULT_SINK@ -5%
            ;;
        toggle)
            pactl set-sink-mute @DEFAULT_SINK@ toggle
            ;;
    esac

    # Get current volume and mute status
    volume=$(pamixer --get-volume)
    mute=$(pamixer --get-mute)

    # Send notification
    if [ "$mute" = "true" ]; then
        notify-send "Muted"
    fi

    # Update slstatus (if running)
    pkill -USR1 slstatus
}

# Handle arguments
case $1 in
    inc)
        change_volume inc
        ;;
    dec)
        change_volume dec
        ;;
    toggle)
        change_volume toggle 
        ;;
    *)
        echo "Usage: $0 {inc|dec|toggle}"
        exit 1
        ;;
esac
