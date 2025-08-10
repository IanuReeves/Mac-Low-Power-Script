# Mac Low Power Script
This is a simple script made to combat some of the many issues found in Mac's "Low Power Mode" setting.
These are the current functions of the script:

- Turn Low Power Mode On/Off Automatically when battery reaches specified % thresholds
- Toggle for deactivating Low Power Mode when connected to AC power

## Installation

Copy this code into your terminal:
````
curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/install.sh | sudo bash
````
And voila! Low power mode should automatically activate when power is low!
#
If you want to manually install, either:

1. Install the install.sh file from the Main Branch, and run it in terminal
2. Download the files in the Contents folder, and place them in the following locations:
- `/usr/local/bin/lowpowermode_toggle.sh`
- `/usr/local/etc/lowpowermode.conf`
- `/Library/LaunchDaemons/com.lowpowermode.toggle.plist`

## Removing/Uninstalling the Script

*I used the script to destroy the script*

Uninstall by pasting this command into terminal:
````
curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/uninstall.sh | sudo bash
````

Or Manually remove it by deleting the Files found in the file paths mentioned in **Manual Install**, and restart your system.

## Configuration

Config can be found in `/usr/local/etc/lowpowermode.conf` after installation. Defaults are 20% and 80% limits, with AC Power toggle set to True (1).

*Note: Update interval has a large impact on the script's battery consumption, albeit negligible.*
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
*"Why Can't I Edit the Config File?"*
- A fix will probably be pushed soon, but for now, best bet is to either run your application in sudo, or move the file to Desktop (CMD+C to copy, OPT+CMD+V to Move), and accept your Mac's request to make changes. Once that happens, you can modify it freely. Just make sure to put it back in the usr/local/etc folder.

*"Help! MacOS blocked the Script"*
- Although I didn't come across this issue during my testing, if MacOS 'blocks' the script from running in the background, it's simply due to MacOS's safeguards on unidentified developers. Try opening Privacy and Security in Settings, and allow the program to be used. If the script still doesn't work, attempt to re-enable the background process in the Login Items and Extensions page in Settings.

*"Why did a bunch of random folders show up in my User Folder?"*
- Not sure if this issue's still replicatable, but this means your internet blocked or couldn't find the request to Github after the request to run install.sh was in progress. Either that, or this repo somehow went private, and is returning 404 errors somehow. Feel free to create an issue if you have further info.

## Transparency
This script does **NOT** access the internet or collect analytics. All code can be viewed, modified, and distributed freely in accordance with the GPL 3.0 License.
