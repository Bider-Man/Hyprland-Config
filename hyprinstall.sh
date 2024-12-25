# Create and handle Rofi configuration
echo "Setting up Rofi configuration..."

# Ensure the Rofi configuration directory exists
mkdir -p "$HOME/.config/rofi"

# Check if a local Rofi directory exists and copy its contents
if [ -d "./hypr/rofi" ]; then
  echo "Copying Rofi configuration from ./hypr/rofi to ~/.config/rofi..."
  cp -r ./hypr/rofi/* "$HOME/.config/rofi/"
else
  echo "No local Rofi configuration directory found. Dumping default Rofi configuration..."
  rofi -dump-config > "$HOME/.config/rofi/config.rasi"
fi
