#!/bin/bash

# Ensure the VS Code settings directory exists
mkdir -p ~/Library/Application\ Support/Code/User

ln -sf ~/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

echo "Set up symlinks for VS Code settings and keybindings."

