# Personal machine configuration
# Loaded when ~/.machine-personal exists

# pipx path (personal username)
set PATH $PATH ~/.local/bin

set -Ua fish_user_paths $HOME/.dotnet/dotnet
set -Ua fish_user_paths $HOME/.dotnet/tools

# Game launchers
function balatro
    "/Users/stephenkirk/Library/Application Support/Steam/steamapps/common/Balatro/run_lovely_macos.sh" $argv
end
