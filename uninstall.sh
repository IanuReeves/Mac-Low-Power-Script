#!/bin/bash

PLIST="/Library/LaunchDaemons/com.lowpowermode.toggle.plist"

echo "Unloading LaunchDaemon..."
if launchctl bootout system "$PLIST" 2>/dev/null; then
    echo "Newer OS: Unloaded using bootout."
elif launchctl unload -w "$PLIST" 2>/dev/null; then
    echo "Older OS: Unloaded using unload"
else
    echo "Could not unload — was the script loaded in the first place?"
fi

echo "Removing script files (Shouldn't take long)..."
sudo rm -f "$PLIST"
sudo rm -f /usr/local/bin/lowpowermode_toggle.sh
sudo rm -f /usr/local/etc/lowpowermode.conf

echo "Uninstall complete. You may close the Terminal"
