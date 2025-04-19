#!/bin/bash

notify-send $line -i ~/photos/SsTcO55LJDBsI.webp

# Function to get remaining minutes
get_remaining_minutes() {
  # Get current time and next prayer time
  current_sec=$(date +%s)
  prayer_sec=$(date -d "$(cat /home/alinajib/preyData/nextPreyTime.txt)" +%s)

  # Calculate difference in seconds
  diff_sec=$((prayer_sec - current_sec))

  # Handle midnight crossover
  [[ $diff_sec -lt 0 ]] && diff_sec=$((diff_sec + 86400))

  # Convert to HH:MM
  hours=$((diff_sec / 3600))
  minutes=$(((diff_sec % 3600) / 60))

  printf "%02d:%02d" "$hours" "$minutes"
}

# Main function
check_prayer_time() {
  remaining=$(get_remaining_minutes)

  if [[ $remaining -le 0 ]]; then
    # Recalculate next prayer if time expired
    /home/alinajib/script/next_prayer_time.sh >/dev/null
    notify-send asd2
    remaining=$(get_remaining_minutes)
  fi

  echo "$remaining"
}

# Execute
check_prayer_time
