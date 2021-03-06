#!/bin/sh

echo "Setting up Homebrew..."

# Install homebrew (if we don't have it)
if test ! $(which brew); then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install dependencies from brewfile
brew update
brew tap homebrew/bundle
brew bundle

# add symlinks
source ./symlink.sh
