#!/bin/bash

# Configuration
ALL_PRAYER_TIMES="$PRAYER_DATA_DIR/allPreyTime.txt"
API_URL="https://api.aladhan.com/v1/timingsByAddress?address=cairo,egypt"
DATE_FORMAT="%F" # YYYY-MM-DD
TIME_FORMAT="%H:%M"

# Ensure data directory exists
mkdir -p "$PRAYER_DATA_DIR"

# Function to fetch and update prayer times
update_prayer_times() {
  echo "Updating prayer times..."
  local response=$(curl -s --location --request GET 'https://api.aladhan.com/v1/timingsByAddress?address=cairo%2C+egypt')

  # Extract prayer times using jq
  local timings=$(echo "$response" | jq -r '.data.timings')

  # Write to file with current date as first line
  echo "$(date +"$DATE_FORMAT")" >"$ALL_PRAYER_TIMES"
  echo "$timings" | jq -r '.Fajr, .Dhuhr, .Asr, .Maghrib, .Isha' >>"$ALL_PRAYER_TIMES"
}

# Function to get next prayer time
get_next_prayer() {
  # Check if we need to update prayer times
  local file_date=$(head -n 1 "$ALL_PRAYER_TIMES" 2>/dev/null)
  local current_date=$(date +"$DATE_FORMAT")

  if [[ "$file_date" != "$current_date" ]] || [[ ! -f "$ALL_PRAYER_TIMES" ]]; then
    update_prayer_times
  fi

  # Get current time in minutes since midnight
  local current_time=$(date +"$TIME_FORMAT")
  local current_minutes=$(date -d "$current_time" +"$TIME_FORMAT" | awk -F: '{print $1*60 + $2}')

  # Read prayer times
  local prayers=("Fajr" "Dhuhr" "Asr" "Maghrib" "Isha")
  local times=($(tail -n +2 "$ALL_PRAYER_TIMES"))

  # Find next prayer
  for i in "${!times[@]}"; do
    local prayer_time="${times[$i]}"
    local prayer_minutes=$(date -d "$prayer_time" +"$TIME_FORMAT" | awk -F: '{print $1*60 + $2}')

    # echo asd $current_minutes $current_time $prayer_minutes $prayer_time
    if [[ $current_minutes -lt $prayer_minutes ]]; then
      echo "${prayers[$i]}:$prayer_time"
      return 0
    fi
  done

  # If no prayer left today, return first prayer of next day
  echo "Fajr:${times[0]}"
}
# Convert HH:MM (24h) to 12h format with optional AM/PM
# Usage: convert_time "HH:MM" [ampm]
#   ampm: 1=show (default), 0=hide
convert_time() {
  local time="$1"
  local show_ampm="${2:-1}" # Default: show AM/PM

  awk -F: -v amp="$show_ampm" '{
    h = $1 % 12;
    h = h ? h : 12;  # Handle 0 (midnight) → 12
    printf "%d:%02d", h, $2;
    if (amp) printf " %s", ($1 >= 12 ? "PM" : "AM");
    print "";  # Add newline
  }' <<<"$time"
}

# Function to calculate time difference
calculate_remaining() {
  local next_prayer=$1
  local prayer_name=$(echo "$next_prayer" | cut -d: -f1)
  local prayer_time=$(echo "$next_prayer" | cut -d: -f2-3)

  local current_sec=$(date +%s)
  local prayer_sec=$(date -d "$prayer_time" +%s 2>/dev/null)

  # Handle case where prayer time is tomorrow
  if [[ $prayer_sec -lt $current_sec ]]; then
    prayer_sec=$((prayer_sec + 86400)) # Add 24 hours
  fi

  local diff_sec=$((prayer_sec - current_sec))
  local hours=$((diff_sec / 3600))
  local minutes=$(((diff_sec % 3600) / 60))

  printf "%s - [%s] => %02d:%02d)%s" "$(convert_time $prayer_time 0)" "$(convert_time $(date +"$TIME_FORMAT"))" "$hours" "$minutes" "$prayer_name"
}

# Main execution
main() {
  # Get next prayer time
  local next_prayer=$(get_next_prayer)

  # Calculate and display remaining time
  calculate_remaining "$next_prayer"
}

while true; do
  # Run main function and capture output
  output=$(main)

  echo "$output" >/home/alinajib/preyData/status_time.txt
  sleep 2
done &
