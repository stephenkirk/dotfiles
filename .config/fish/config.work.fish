# Work machine configuration
# Loaded when ~/.machine-work exists

# mise for version management
if test -f ~/.local/bin/mise
    ~/.local/bin/mise activate fish | source
end
