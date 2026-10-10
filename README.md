# dotfiles

Personal macOS setup. The repo is the source of truth; the live system points at it via symlinks.

## Highlights

- **Key repeat below the System Settings floor**: `KeyRepeat 1` (15 ms; the slider stops at 2), `InitialKeyRepeat 15` (225 ms). Press-and-hold accent picker disabled, so held keys repeat.
- **Caps Lock**: tap = Esc, hold = Ctrl.
- **Esc**: tap = Caps Lock, hold = Hyper (Cmd+Ctrl+Opt+Shift).
- **Hyper hotkeys** (Hammerspoon): `A` cycle audio output, `D` dark mode, `N` Night Shift, `R` reload config, `H` list hotkeys.
- **No animations**: window resize, Mission Control, full-screen toolbar, Dock autohide, Mail send/reply.
- **No text "help"**: autocorrect, auto-capitalisation, smart quotes/dashes, period substitution, text completion all off.
- **Finder**: column view, hidden files and all extensions shown, search scoped to current folder, `~/Library` unhidden.
- **No Gatekeeper "are you sure" dialog, no crash reporter dialog.**
- **Fish** with vi key bindings, fzf, zoxide.
- **`prs`**: PR lists as paste-ready Markdown links (`inbox`, `waiting`, `approved`, `merged [N]`).

Full list of defaults: [`scripts/macos-defaults.sh`](scripts/macos-defaults.sh).

## Layout

```
.config/          → ~/.config/   fish, zed, nvim, karabiner, amethyst, linearmouse
.vimrc .zshrc …   → ~/           flat dotfiles; also .doom.d, .hammerspoon, .tmux.conf, .gitconfig
tools/            on PATH as-is; standalone scripts
scripts/
  symlink-setup.sh     wires everything (idempotent, re-run to apply)
  macos-defaults.sh    defaults writes
  vscode-sync.sh       VS Code settings
  fish-paths-reset.fish  rebuilds universal fish_user_paths
Brewfile          apps and CLI tools; Brewfile.personal gated on ~/.machine-personal
setup.sh          Homebrew → brew bundle → symlinks → defaults → vim dirs
```

Secrets, machine-specific paths and Claude config live in a separate private repo at `~/dotfiles-private`. `symlink-setup.sh` wires it if present and skips it otherwise; this repo works standalone, minus credentials.

## Editors

- **Zed**: primary.
- **Doom Emacs**: used for magit.
- **Vim/Neovim**, **VS Code**: configs maintained, used occasionally.

## Tools

| | |
|---|---|
| `prs` | PR lists as Markdown links |
| `bootstrap-agents-md` | create `AGENTS.md` in a repo and symlink `CLAUDE.md` to it |
| `clean-claude-history` | strip Claude session links / co-author trailers from a branch range |
| `compress-recording` | shrink screen recordings, optional speed-up |
| `yt-whisper` | transcribe a YouTube video (optionally a time range) to text |
| `folder-to-llm` | concatenate source files in a directory (by extension) for pasting into an LLM |
| `md-to-pdf`, `md-to-pdf-html` | Markdown → PDF via pandoc (LaTeX or wkhtmltopdf) |
| `flactomp3`, `flactomp3dir` | FLAC → MP3 |
| `serve` | HTTP server for the current dir, reachable on the LAN |
| `skill-usage` | count Claude skill mentions across session logs |
| `rubocop-pr` | rubocop only the Ruby files changed on this branch |
| `sts` | Slay the Spire launcher, sets display config per monitor |
| `balatro` | Balatro launcher with the Lovely mod loader |

## Install

```bash
git clone https://github.com/stephenkirk/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
```

`macos-defaults.sh` asks for sudo and restarts the Dock. Some keys target older macOS releases and are no-ops on current ones.
