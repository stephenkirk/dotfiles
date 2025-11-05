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

## Notes

- iterm themes aren't auto-installed, you'll need to do that yourself (gasp)
- Some shortcuts are very specific to my workflow (see: the "Productivity Enhancement" Balatro alias)
- All text autocorrections and substitutions are disabled (smart quotes aren't that smart)

---

### Notable Features You Might Want to Steal

```lua
-- One-key audio device switching (Hammerspoon)
hs.hotkey.bind(super, "A", function()
    -- Toggle between speakers and AirPods because menus are for people with time to waste
end)
```

```fish
# Smart PR review list command
function to_review
    gh pr list -S "review-requested:@me" --json title,url,author --jq 'map("[\\"@\\(.author.login): \\(.title)\\"](\\(.url))") | .[]'
end
```

```bash
# Disable animations and speed up macOS
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g NSToolbarFullScreenAnimationDuration -float 0
defaults write com.apple.dock expose-animation-duration -float 0
```

```fish
# The most important productivity tool
function balatro
    "/Users/stephenkirk/Library/Application Support/Steam/steamapps/common/Balatro/run_lovely_macos.sh" $argv
end
```
