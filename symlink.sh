# Lazy dotfile syncing until I can get something going that might not accidentally blow up my computer

ln -s ~/dotfiles/.* ~/
rm -rf ~/.git # Remove accidental git folder committing

# symlink vs code since it uses some really weird path
ln -s "~/dotfiles/vscode_settings.json" "~/Library/Application Support/Code/User/settings.json"
