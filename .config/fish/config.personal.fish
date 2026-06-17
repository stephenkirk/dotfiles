# Personal machine configuration
# Loaded when ~/.machine-personal exists

# pipx path (personal username)
set PATH $PATH ~/.local/bin

# Added by tally installer
fish_add_path $HOME/.tally/bin

# Game launchers
function balatro
    "/Users/stephenkirk/Library/Application Support/Steam/steamapps/common/Balatro/run_lovely_macos.sh" $argv
end

