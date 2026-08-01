#!/usr/bin/env fish
#
# Rebuild fish_user_paths from scratch.
#
# fish_user_paths is a UNIVERSAL variable: it lives in fish's own persisted
# variable store, not in config.fish. `set -Ua` appends to it, so editing or
# even deleting a line in config.fish never removes the entry it created — the
# stale path survives every new shell, forever, until erased explicitly.
#
# That is how a long-dead ~/bin and its children outlived the directories they
# pointed at. Run this after changing the Paths block in config.fish.
#
# Only public, generic paths belong here. Machine- or host-specific entries are
# added by private config and are deliberately not listed.

# Includes entries that no dotfile creates — nix and tally were added by their
# own installers writing straight into the universal store. Dropping them here
# would silently remove them from PATH with nothing to restore them.
set -l wanted \
    $HOME/dotfiles/tools \
    /opt/homebrew/bin \
    /nix/var/nix/profiles/default/bin \
    $HOME/.tally/bin \
    $HOME/.config/emacs/bin \
    $HOME/Library/Python/3.8/bin \
    $HOME/go \
    $HOME/.local/bin

echo "Before:"
for p in $fish_user_paths
    echo "  $p"
end

set -U fish_user_paths

for p in $wanted
    if test -d $p
        set -Ua fish_user_paths $p
    else
        echo "skipping (not a directory): $p"
    end
end

echo "After:"
for p in $fish_user_paths
    echo "  $p"
end
