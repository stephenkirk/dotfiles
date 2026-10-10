#!/usr/bin/env fish
# Run after editing the Paths block in .config/fish/config.fish.
# fish_user_paths persists across shells; removing a config line leaves its path.
# This resets the list to existing public paths. Private config adds its own paths.

# Keep Nix and tally paths: their installers added them outside config.fish.
set -l wanted \
    $HOME/dotfiles/tools \
    /opt/homebrew/bin \
    /nix/var/nix/profiles/default/bin \
    $HOME/.tally/bin \
    $HOME/.config/emacs/bin \
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
