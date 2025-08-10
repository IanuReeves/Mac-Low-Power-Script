# Mac Low Power Script
This is a simple script made to combat some of the many issues found in Mac's "Low Power Mode" setting.
These are the current functions of the script:

- Turn Low Power Mode On/Off Automatically when battery reaches specified % thresholds
- Toggle for deactivating Low Power Mode when connected to AC power

## Install

Copy this code into your terminal:

````
sudo bash -c ' mkdir -p /usr/local/bin /usr/local/etc curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power Script/main/lowpowermode_toggle.sh -o /usr/local/bin/lowpowermode_toggle.sh chmod +x /usr/local/bin/lowpowermode_toggle.sh curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/lowpowermode.conf -o /usr/local/etc/lowpowermode.conf curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/com.lowpowermode.toggle.plist -o /Library/LaunchDaemons/com.lowpowermode.toggle.plist chmod 644 /Library/LaunchDaemons/com.lowpowermode.toggle.plist launchctl unload /Library/LaunchDaemons/com.lowpowermode.toggle.plist 2>/dev/null || true launchctl load /Library/LaunchDaemons/com.lowpowermode.toggle.plist '
````
And voila! Low power mode should automatically activate when power is low!
# 
For Manual installation, Download Git Repo, and place the three files in the Scripts folder in the following locations:
- `/usr/local/bin/lowpowermode_toggle.sh`
- `/usr/local/etc/lowpowermode.conf`
- `/Library/LaunchDaemons/com.lowpowermode.toggle.plist`

## Configuration

Config can be found in `/usr/local/etc/lowpowermode.conf` after installation. Defaults are 20% and 80% limits, with AC Power toggle set to True (1).

*Update interval has a large impact on the script's battery consumption, albeit negligible.*
```
# ======================================
# Low Power Mode Config
# ======================================

# Battery percentage threshold to ENABLE Low Power Mode
ENABLE_THRESHOLD=20

# Whether connecting to AC power should IMMEDIATELY disable Low Power Mode
# 1 = Yes, 0 = No
DISABLE_ON_AC=1

# Battery percentage threshold to DISABLE Low Power Mode
# (Only used if DISABLE_ON_AC=0)
DISABLE_THRESHOLD=80

# ======================================
# Advanced Config
# ======================================

# How often (in seconds) the script runs when scheduled with launchd
UPDATE_INTERVAL=60
```
## Issues
If MacOS 'blocks' the script from running in the background, please open Privacy and Security in Settings, and allow the program to be used. I didn't come across this issue in any of my tests, however if the script still doesn't work, attempt to re-enable the background process in the Login Items and Extensions page in Settings

## Transparency
This script does **NOT** access the internet or collect analytics. All code can be viewed, modified, and distributed freely in accordance with the GPL 3.0 License.
