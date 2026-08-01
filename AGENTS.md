# AGENTS.md

Personal macOS dotfiles. Source of truth lives in this repo; the live system is wired to it by symlinks.

## Layout

- `.config/` → symlinked into `~/.config/` (fish, zed, nvim, karabiner, amethyst, linearmouse).
- `.vimrc`, `.zshrc*`, `.tmux.conf`, `.gitconfig`, `.doom.d`, `.hammerspoon` → symlinked flat into `~`.
- `tools/` → on `PATH` directly as `~/dotfiles/tools`. Standalone scripts; each is its own entrypoint.
- `scripts/` → setup machinery, not symlinked: `symlink-setup.sh` (wiring), `macos-defaults.sh` (defaults writes), `vscode-sync.sh`.
- `Brewfile` (+ `Brewfile.personal`), `setup.sh` (orchestrates everything).
- Private config lives in a separate, non-public repo cloned to `~/dotfiles-private`. `symlink-setup.sh` wires it when present and skips it cleanly when absent. Claude skills live there, not here.

## Conventions

- **Edit the repo file, not the symlink target.** A live config under `~` is a symlink back here; editing through it edits this repo, which is fine; but reason about it as "I'm editing the repo."
- **New config file = new `create_symlink` line** in `scripts/symlink-setup.sh`. Adding a file here does nothing until it's wired.
- `create_symlink` is `ln -nsf` — idempotent and re-run safe. Re-running `symlink-setup.sh` is the normal way to apply changes; it won't clobber repo content, only re-point links.
- Use `replace_symlink` when the target may already exist as a *real directory*. `ln -nsf` does not replace a directory — it silently creates the link *inside* it. `replace_symlink` moves the old one to `<target>.pre-private` first.
- Machine split: personal vs work via `~/.machine-personal` sentinel (gates `Brewfile.personal`) and `*.personal` / `*.work` config variants.
- `CLAUDE.md` is a symlink to `AGENTS.md`. Edit `AGENTS.md`. `tools/bootstrap-agents-md` reproduces this pairing in any other repo.

## Cookbook

- Add a dotfile: drop it in repo → add `create_symlink` line → `source scripts/symlink-setup.sh`.
- Add a tool: drop executable in `tools/` (`chmod 755`, shebang, no `.sh` suffix, `$HOME` not `~` in script bodies) → already on `PATH`.
- Bootstrap a fresh machine: `./setup.sh` (Homebrew → `brew bundle` → symlinks → macOS defaults → vim dirs).
- Scaffold AGENTS.md elsewhere: `tools/bootstrap-agents-md [DIR]`.

## Gotchas

- Don't symlink a directory into a target that must hold other content: symlink children, not the parent. This still applies to `~/.claude` itself (Claude Code's own state lives there). It no longer applies to `~/.claude/skills`, because `~/dotfiles-private` now owns every entry in it.
- Secrets never enter this repo — they live in `~/dotfiles-private`. Keep it that way.
- `fish_user_paths` is a *universal* variable. Editing the Paths block in `config.fish` does not remove old entries; run `scripts/fish-paths-reset.fish` to rebuild it.
- `.config/karabiner/automatic_backups/*.json` is gitignored (churn); don't commit it.
- macOS writes `.DS_Store` everywhere; gitignored — don't fight it.
