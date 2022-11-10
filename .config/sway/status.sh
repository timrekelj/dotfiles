# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

network_status=$(nmcli c | awk 'NR==2 {printf "%s: %s\n",$3,$1}')

if [ "$(nmcli c | awk 'NR==2 {print $3}')" != "wifi" ] &&
    [ "$(nmcli c | awk 'NR==2 {print $3}')" != "ethernet" ]; then
    network_status=$(echo "disconnected")
fi


# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Returns the battery statusFull", "Discharging", or "Charging".
battery_status=$(upower --show-info $(upower --enumerate |\
grep 'BAT') |\
egrep "state|percentage" |\
awk '{print $2}')

echo 🐧  "|" $network_status "|" $uptime_formatted "|" $battery_status "|" $date_formatted
