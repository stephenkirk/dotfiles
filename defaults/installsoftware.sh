# Install applications
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Tap
brew tap caskroom/cask
brew install brew-cask
brew tap homebrew/science


brew bundle --file= <<EOF
brew "r"
brew "ag"
brew "python3"
brew "git-extras"
brew "fzf"
brew "tldr"
brew "macvim"
brew "tree"
brew "tmux"
brew "reattach-to-user-namespace"
brew "thefuck"
brew "youtube-dl"
brew "zsh"
brew "z"
EOF

# Various software I need
brew cask install 1password
brew cask install alfred
brew cask install dropbox

brew cask install google-chrome
brew cask install firefox

brew cask install flux
brew cask install iterm2

brew cask install rstudio

brew cask install slack
brew cask install spectacle
brew cask install spotify
brew cask install sublime-text
brew cask install visual-studio-code
brew cask install karabiner-elements

# Emacs

brew tap d12frosted/emacs-plus
brew install emacs-plus
brew linkapps emacs-plus
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

