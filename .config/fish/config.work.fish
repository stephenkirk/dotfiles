# Work machine configuration
# Loaded when ~/.machine-work exists

# mise for version management
if test -f ~/.local/bin/mise
    ~/.local/bin/mise activate fish | source
end

# qlty
set -gx QLTY_INSTALL "$HOME/.qlty"
fish_add_path $QLTY_INSTALL/bin
