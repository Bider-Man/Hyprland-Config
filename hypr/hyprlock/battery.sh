#!/bin/bash
battery_status=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "N/A")
charging_status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
echo "Battery: $battery_status% ($charging_status)"
