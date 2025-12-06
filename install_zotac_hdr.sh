#!/bin/bash

# Define paths and URLs
TARGET_DIR="$HOME/.config/gamescope/scripts"
TARGET_FILE="zotac.zone.oled.lua"
SOURCE_URL="https://github.com/ValveSoftware/gamescope/raw/513c8dd65f86e884940b3164c270a20d5b59af4c/scripts/00-gamescope/displays/zotac.zone.oled.lua"

# Visual separator
echo "-----------------------------------------------------"
echo "  🎮 Zotac Zone HDR & 144hz Profile Installer (Bazzite/Atomic)"
echo "-----------------------------------------------------"

# 1. Create the directory if it doesn't exist
echo "📂 Creating configuration directory..."
mkdir -p "$TARGET_DIR"

# 2. Download the file
echo "⬇️  Downloading HDR profile from Valve's repository..."
if wget -q -O "$TARGET_DIR/$TARGET_FILE" "$SOURCE_URL"; then
    echo "   ✅ Download successful."
else
    echo "   ❌ Error: Failed to download the file. Check your internet connection."
    exit 1
fi

# 3. Apply the SED patch
echo "🛠️  Patching white point coordinates..."
# sed -i modifies the file in place
sed -i 's/x = 0.3095, y = 0.3095/x = 0.3070, y = 0.3235/' "$TARGET_DIR/$TARGET_FILE"

# 4. Verify the patch
if grep -q "x = 0.3070, y = 0.3235" "$TARGET_DIR/$TARGET_FILE"; then
    echo "   ✅ Patch applied successfully."
else
    echo "   ❌ Error: Patch failed. The source file might have changed structure."
    exit 1
fi

echo "-----------------------------------------------------"
echo "✨ Success! Profile installed to:"
echo "   $TARGET_DIR/$TARGET_FILE"
echo "-----------------------------------------------------"
echo "ℹ️  Note: You may need to restart Gamescope or reboot"
echo "   your device for the changes to take effect."
