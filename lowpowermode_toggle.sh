#!/bin/bash
# Low Power Mode Auto-Toggle Script with Config Support

CONFIG_FILE="/usr/local/etc/lowpowermode.conf"
LOGFILE="/var/log/lowpowermode_toggle.log"

# Load config
if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"
else
    echo "$(date) - Config file missing at $CONFIG_FILE" >> "$LOGFILE"
    exit 1
fi

# Ensure defaults if config is missing keys
ENABLE_THRESHOLD=${ENABLE_THRESHOLD:-20}
DISABLE_ON_AC=${DISABLE_ON_AC:-1}
DISABLE_THRESHOLD=${DISABLE_THRESHOLD:-40}

# Check if Low Power Mode is supported
if ! pmset -g | grep -q "lowpowermode"; then
    echo "$(date) - Low Power Mode not supported on this macOS version" >> "$LOGFILE"
    exit 0
fi

# Get battery percentage
PERCENT=$(pmset -g batt | grep -Eo "[0-9]+%" | head -n 1 | tr -d '%')
IS_AC=0
if pmset -g batt | grep -q "AC Power"; then
    IS_AC=1
fi

# Current low power mode state
CURRENT_STATE=$(pmset -g | awk '/lowpowermode/ {print $2}' | tr -d '[:space:]')
CURRENT_STATE=${CURRENT_STATE:-0}

if [ "$IS_AC" -eq 1 ]; then
    if [ "$DISABLE_ON_AC" -eq 1 ]; then
        if [ "$CURRENT_STATE" -eq 1 ]; then
            echo "$(date) - On AC, disabling Low Power Mode" >> "$LOGFILE"
            pmset -a lowpowermode 0
        else
            echo "$(date) - On AC, Low Power Mode already off" >> "$LOGFILE"
        fi
    fi
else
    # On battery
    if [ "$CURRENT_STATE" -eq 0 ] && [ "$PERCENT" -le "$ENABLE_THRESHOLD" ]; then
        echo "$(date) - Battery ${PERCENT}%, enabling Low Power Mode" >> "$LOGFILE"
        pmset -a lowpowermode 1
    elif [ "$DISABLE_ON_AC" -eq 0 ] && [ "$CURRENT_STATE" -eq 1 ] && [ "$PERCENT" -ge "$DISABLE_THRESHOLD" ]; then
        echo "$(date) - Battery ${PERCENT}%, disabling Low Power Mode" >> "$LOGFILE"
        pmset -a lowpowermode 0
    else
        echo "$(date) - Battery ${PERCENT}%, no change" >> "$LOGFILE"
    fi
fi
