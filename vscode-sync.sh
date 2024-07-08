#!/bin/bash

# Ensure the VS Code settings directory exists
mkdir -p ~/Library/Application\ Support/Code/User

ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

# Install extensions
extensions=(
    "ms-python.python"
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "asvetliakov.vscode-neovim"
)

for extension in "${extensions[@]}"
do
    code --install-extension "$extension"
done

echo "VS Code settings, keybindings, and extensions have been synchronized."

