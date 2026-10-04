#!/bin/sh

echo "Setting up Homebrew..."

if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew tap homebrew/bundle
brew bundle

if [ -f "$HOME/.machine-personal" ]; then
    echo "Personal machine detected, installing personal packages..."
    brew bundle --file=Brewfile.personal
fi

source ./scripts/symlink-setup.sh
source ./scripts/macos-defaults.sh
source ./scripts/vscode-sync.sh

mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undodir
