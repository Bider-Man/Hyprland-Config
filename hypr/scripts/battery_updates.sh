import psutil
import json

def get_battery_percentage():
    """Fetch the battery percentage."""
    battery = psutil.sensors_battery()
    return battery.percent

def calculate_gradient_color(percentage):
    """Calculate color based on percentage (green to red gradient)."""
    red = int(255 * (1 - (percentage / 100)))
    green = int(255 * (percentage / 100))
    return f"#{red:02x}{green:02x}00"

def main():
    battery_percentage = get_battery_percentage()
    color = calculate_gradient_color(battery_percentage)

    # Output the percentage and color in JSON format for Waybar
    print(json.dumps({
        "text": f"{battery_percentage}%",
        "class": "battery",
        "color": color,
        "percentage": battery_percentage
    }))

if __name__ == "__main__":
    main()
