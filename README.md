# My Dotfiles

## What's this?

My personal macOS setup. For those who no longer find spiritual enlightenment in the 47-click System Preferences pilgrimage after each reinstall.

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
- **Fish Shell**: With vi mode and aliases etc
- **Zed**: The new daily driver
- **Vim/Neovim**: I mean I probably could live with vanilla vim/neovim but I keep the config around
- **VS Code**: I hate it, but I use it
- **Doom Emacs**: For when you want your text editor to be an operating system - mostly used as glorified git client with magit

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

## What Exactly Happens?

1. Installs Homebrew
2. Installs a ton of stuff from Brewfile:
   - All the dev tools (git, python, rust, go, etc.)
   - CLI utilities that make terminal life bearable
   - Apps like VSCode, iTerm2, and more
3. Configures macOS with sensible defaults
4. Symlinks configs so everything just works™

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
