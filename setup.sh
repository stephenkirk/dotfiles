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

# add symlinks
source ./symlink.sh
source ./scripts/macos-defaults.sh
source ~/vscode-sync.sh
