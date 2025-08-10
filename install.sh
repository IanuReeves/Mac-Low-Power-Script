sudo bash -c

' mkdir -p /usr/local/bin /usr/local/etc

curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power Script/main/Contents/lowpowermode_toggle.sh -o /usr/local/bin/lowpowermode_toggle.sh
 chmod +x /usr/local/bin/lowpowermode_toggle.sh
 
 curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/Contents/lowpowermode.conf -o /usr/local/etc/lowpowermode.conf
 
 curl -fsSL https://raw.githubusercontent.com/IanuReeves/Mac-Low-Power-Script/main/Contents/com.lowpowermode.toggle.plist -o /Library/LaunchDaemons/com.lowpowermode.toggle.plist
 chmod 644 /Library/LaunchDaemons/com.lowpowermode.toggle.plist
 
 
 launchctl unload /Library/LaunchDaemons/com.lowpowermode.toggle.plist 2>/dev/null || true launchctl load /Library/LaunchDaemons/com.lowpowermode.toggle.plist '
