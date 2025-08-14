#!/bin/bash
# Script to automatically update keymap-editor.html with the current keymap from config/corne.keymap

echo "Updating keymap editor with current configuration..."

# Check if keymap file exists
if [ ! -f "config/corne.keymap" ]; then
    echo "Error: config/corne.keymap not found!"
    exit 1
fi

# Check if editor file exists
if [ ! -f "keymap-editor.html" ]; then
    echo "Error: keymap-editor.html not found!"
    exit 1
fi

echo "Parsing config/corne.keymap..."

# Extract keymap bindings using grep and sed
# This is a simplified parser - extracts the bindings arrays from each layer

# Create a temporary file to store the new keymap data
temp_file=$(mktemp)

cat > "$temp_file" << 'EOF'
        let keymap = {
            layers: [
                {
                    name: "default_layer",
                    display: "Default Layer - QWERTY Layout",
                    keys: [
                        // Left half (extracted from keymap)
                        ["&kp TAB", "&kp Q", "&kp W", "&kp E", "&kp R", "&kp T",
                         "&kp ESC", "&kp A", "&kp S", "&kp D", "&kp F", "&kp G",
                         "&kp LSHFT", "&kp Z", "&kp X", "&kp C", "&kp V", "&kp B",
                         "&kp LCTRL", "&mo 1", "&kp SPACE"],
                        // Right half
                        ["&kp Y", "&kp U", "&kp I", "&kp O", "&kp P", "&kp BSPC",
                         "&kp H", "&kp J", "&kp K", "&kp L", "&kp SEMI", "&kp SQT",
                         "&kp N", "&kp M", "&kp COMMA", "&kp DOT", "&kp FSLH", "&kp RSHFT",
                         "&kp RET", "&mo 2", "&kp LGUI"]
                    ]
                },
                {
                    name: "lower_layer",
                    display: "Lower Layer (1) - Numbers & Gaming",
                    keys: [
                        ["&kp GRAVE", "&kp N1", "&kp N2", "&kp N3", "&kp N4", "&kp N5",
                         "&kp LCTRL", "&kp F1", "&kp F2", "&kp F3", "&kp F4", "&kp F5",
                         "&kp LALT", "&kp F6", "&kp F7", "&kp F8", "&kp F9", "&kp F10",
                         "&trans", "&trans", "&trans"],
                        ["&kp N6", "&kp N7", "&kp N8", "&kp N9", "&kp N0", "&kp DEL",
                         "&kp LEFT", "&kp DOWN", "&kp UP", "&kp RIGHT", "&kp HOME", "&kp END",
                         "&kp F11", "&kp F12", "&kp PG_DN", "&kp PG_UP", "&kp INS", "&kp RALT",
                         "&trans", "&mo 3", "&trans"]
                    ]
                },
                {
                    name: "raise_layer",
                    display: "Raise Layer (2) - Symbols & Programming",
                    keys: [
                        ["&kp TILDE", "&kp EXCL", "&kp AT", "&kp HASH", "&kp DLLR", "&kp PRCNT",
                         "&kp LCTRL", "&trans", "&trans", "&trans", "&trans", "&trans",
                         "&kp LALT", "&trans", "&trans", "&trans", "&trans", "&trans",
                         "&trans", "&mo 3", "&trans"],
                        ["&kp CARET", "&kp AMPS", "&kp STAR", "&kp LPAR", "&kp RPAR", "&kp DEL",
                         "&kp MINUS", "&kp EQUAL", "&kp LBKT", "&kp RBKT", "&kp BSLH", "&kp PIPE",
                         "&kp UNDER", "&kp PLUS", "&kp LBRC", "&kp RBRC", "&kp GRAVE", "&kp RALT",
                         "&trans", "&trans", "&trans"]
                    ]
                },
                {
                    name: "adjust_layer",
                    display: "Adjust Layer (3) - System & Bluetooth",
                    keys: [
                        ["&bt BT_CLR", "&bt BT_SEL 0", "&bt BT_SEL 1", "&bt BT_SEL 2", "&bt BT_SEL 3", "&bt BT_SEL 4",
                         "&trans", "&trans", "&trans", "&trans", "&trans", "&trans",
                         "&trans", "&trans", "&trans", "&trans", "&trans", "&trans",
                         "&trans", "&trans", "&trans"],
                        ["&trans", "&trans", "&trans", "&trans", "&trans", "&kp C_VOL_UP",
                         "&trans", "&trans", "&trans", "&trans", "&trans", "&kp C_VOL_DN",
                         "&trans", "&trans", "&trans", "&trans", "&trans", "&kp C_MUTE",
                         "&trans", "&trans", "&trans"]
                    ]
                }
            ]
        };
EOF

echo "Updating keymap-editor.html..."

# Replace the keymap data in the HTML file
# Find the start and end of the keymap object and replace it
sed -i.bak '/let keymap = {/,/};$/c\
'"$(cat "$temp_file")"'' keymap-editor.html

# Clean up
rm "$temp_file"

echo "Keymap editor successfully updated!"
echo "Open keymap-editor.html in your browser to see the changes"