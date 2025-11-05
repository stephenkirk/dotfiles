# My Dotfiles

## What's this?

My personal macOS setup. For those who no longer find spiritual enlightenment in the 47-click System Preferences pilgrimage after each reinstall.

## How This Works

The symlink architecture that makes this all work:

```
~/dotfiles/
├── .config/              # Modern configs → symlinked to ~/.config/
│   ├── fish/            # Primary shell (vi mode, fzf, zoxide)
│   │                    # Zsh config also kept for compatibility
│   ├── zed/             # Daily driver editor
│   ├── karabiner/       # Keyboard customization
│   ├── amethyst/        # Window management
│   └── linearmouse/     # Mouse settings
├── .vimrc, .zshrc, etc  # Classic dotfiles → symlinked to ~/
├── .hammerspoon/        # Hotkey automation
├── tools/               # Productivity scripts → symlinked to ~/bin/tools (in PATH)
│                        # Audio conversion, doc generation, game launchers, etc
├── scripts/
│   ├── symlink-setup.sh    # Wires everything up
│   ├── macos-defaults.sh   # System preferences automation
│   └── vscode-sync.sh      # Keeps VS Code settings in sync
├── Brewfile             # Every app and CLI tool
└── setup.sh             # Orchestrates it all
```

### Private Dotfiles Pattern
Sensitive configs (API keys, work stuff, private scripts) live in `~/Documents/dotfiles_private/` and get symlinked to `~/dotfiles_private` and `~/bin`. Fork this? Make your own.

## Example Features

### System Configuration That Makes Sense
- **macOS Defaults**: Disables animations in favor of speed and responsiveness
- **Key Repeat**: Set to ludicrous speed for zooming around in vim
- **Finder**: Forces column view because efficiency matters
- **No More Accents**: Disabled the accent menu that pops up when you hold a key

### Tools That Enhance Productivity
- **Hammerspoon**: Hotkeys for essentials like:
  - `super+A`: Toggling between AirPods and laptop speakers (because auto switching is finicky at best)
  - `super+D`: Toggle dark mode
- **Amethyst**: Window management for keyboard-focused workflows
- **Karabiner/LinearMouse**: Input device customizations for maximum comfort (mouse acceleration, caps lock doubles as ESC/ctrl)

### Dev Environment That Prioritizes Sanity
- **Fish Shell**: Primary shell with vi mode, better defaults than Zsh (which is kept for compatibility)
- **Zed**: The daily driver
- **VS Code**: Kept around because sometimes you need it
- **Vim/Neovim**: Vanilla is probably fine but the config lives on
- **Doom Emacs**: Glorified magit launcher, aka the best git client

## Installation

1. Clone this thing:
   ```bash
   git clone https://github.com/stephenkirk/dotfiles.git ~/dotfiles
   ```

2. Run the script:
   ```bash
   cd ~/dotfiles
   ./setup.sh
   ```

3. Go make coffee. Or tea. Or grab a beer. This will take a bit.

## The Brewfile

Peruse the Brewfile if you're curious about what I use daily. It's a mess, but it's *my* mess.

## Customization

Fork it. Break it. Fix it. It's yours now.

## Highlights

**Caps Lock as Hyper Key**
Karabiner maps caps lock to ESC (tap) and SUPER/Hyper (hold), giving you a whole new modifier key. Hammerspoon then uses SUPER for system-wide hotkeys:
- `SUPER+H`: Show all available hotkeys
- `SUPER+A`: Toggle between AirPods and speakers
- `SUPER+D`: Toggle dark mode

**Smart PR Review List**
Get PRs awaiting your review as Markdown links, ready to paste:
```fish
function to_review
    gh pr list -S "review-requested:@me" --json title,url,author \
      --jq 'map("[\\"@\\(.author.login): \\(.title)\\"](\\(.url))") | .[]'
end
```

**Kill All the Animations**
macOS is faster when it's not busy being pretty:
```bash
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write com.apple.dock expose-animation-duration -float 0
```
See `scripts/macos-defaults.sh` for the full list.
