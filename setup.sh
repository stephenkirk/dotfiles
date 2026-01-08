#!/bin/sh

echo "Setting up Homebrew..."

# Install homebrew (if we don't have it)
if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install dependencies from brewfile
brew update
brew tap homebrew/bundle
brew bundle

# Install personal packages if this is a personal machine
if [ -f "$HOME/.machine-personal" ]; then
    echo "Personal machine detected, installing personal packages..."
    brew bundle --file=Brewfile.personal
fi

# add symlinks
source ./scripts/symlink-setup.sh
source ./scripts/macos-defaults.sh
source ./scripts/vscode-sync.sh

# vim folder structure
mkdir ~/.vim
mkdir ~/.vim/backup
mkdir ~/.vim/swap
mkdir ~/.vim/undodir
