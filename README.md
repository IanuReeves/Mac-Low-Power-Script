# Mac-Low-Power-Script
Simplistic Automation for Low Power Mode on Mac.

## Installation Steps

There are two ways to install this script, either Automatically or through manually installing each file in its respective directories.

### Automatic Install

````
```
sudo bash -c 'mkdir -p /usr/local/bin /usr/local/etc && cat > /usr/local/bin/lowpowermode_toggle.sh <<'"'"'EOF'"'"' #!/bin/bash CONFIG_FILE="/usr/local/etc/lowpowermode.conf" ENABLE_THRESHOLD=$(grep ENABLE_THRESHOLD "$CONFIG_FILE" | cut -d= -f2) DISABLE_ON_AC=$(grep DISABLE_ON_AC "$CONFIG_FILE" | cut -d= -f2) DISABLE_THRESHOLD=$(grep DISABLE_THRESHOLD "$CONFIG_FILE" | cut -d= -f2) power_source=$(pmset -g batt | head -n 1 | grep -o "AC Power") battery_level=$(pmset -g batt | grep -Eo "[0-9]+%" | tr -d "%") if [[ -z "$power_source" && $battery_level -le $ENABLE_THRESHOLD ]]; then pmset -a lowpowermode 1 elif [[ -n "$power_source" && "$DISABLE_ON_AC" == "true" ]]; then pmset -a lowpowermode 0 elif [[ -z "$power_source" && $battery_level -ge $DISABLE_THRESHOLD ]]; then pmset -a lowpowermode 0 fi EOF chmod +x /usr/local/bin/lowpowermode_toggle.sh cat > /usr/local/etc/lowpowermode.conf <<EOF ENABLE_THRESHOLD=20 DISABLE_ON_AC=true DISABLE_THRESHOLD=40 EOF cat > /Library/LaunchDaemons/com.lowpowermode.toggle.plist <<EOF <?xml version="1.0" encoding="UTF-8"?> <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"> <plist version="1.0"> <dict> <key>Label</key> <string>com.lowpowermode.toggle</string> <key>ProgramArguments</key> <array> <string>/usr/local/bin/lowpowermode_toggle.sh</string> </array> <key>StartInterval</key> <integer>60</integer> <key>RunAtLoad</key> <true/> </dict> </plist> EOF chmod 644 /Library/LaunchDaemons/com.lowpowermode.toggle.plist launchctl load /Library/LaunchDaemons/com.lowpowermode.toggle.plist'
```
````



