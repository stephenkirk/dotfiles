#!/bin/bash

# Set some useful OS X defaults.

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

osascript -e 'tell application "System Preferences" to quit'

# Set the perfect key repeat rate and ensure we don't get those stupid accent characters when holding keys
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write com.apple.Dock autohide-delay -float 0 # Disable Dock autohide delay
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.dock show-process-indicators -bool true # Show indicator lights for open applications in the Dock
defaults write com.apple.dock persistent-apps -array    # Delete all apps from dock
killall Dock 

defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true 
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5
# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
# Require password immediately after sleep or screen saver.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock

chflags nohidden ~/Library

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Always open everything in Finder's column view. This is important.
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
defaults write com.apple.Finder FXPreferredViewStyle clmv
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Allow text-selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Expand print panel by default
# I have no idea which one of these actually changes things, so I'm throwing them all in here
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode2 -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Set search scope.
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope SCcf

# Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# disable animation for showing and hiding sheets, resizing preference windows, zooming windows
defaults write -g NSWindowResizeTime -float 0.001

# disable delay for showing a toolbar or menu bar in full screen
defaults write -g NSToolbarFullScreenAnimationDuration -float 0

# disable delay for showing and hiding Mission Control, command+numbers
defaults write com.apple.dock expose-animation-duration -float 0

# disable animations for mail.app
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true

defaults write NSGlobalDomain NSWindowResizeTime .001

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false  # Disable period substitution
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # Disable smart quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # Disable smart dashes
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # Disable auto-correct
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false      # Disable text-completion

# Stop iTunes from responding to the keyboard media keys.
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null
