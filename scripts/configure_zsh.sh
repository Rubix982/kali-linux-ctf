#!/bin/bash
set -e

# Install ZSH and make it the default shell for the vagrant user
sudo apt-get update
sudo apt-get install -y zsh curl git

# Set ZSH as the default shell for 'vagrant'
chsh -s "$(which zsh)" vagrant

# Oh My Zsh installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ZSH Theme: Agnoster for a clean, informative prompt
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc

# Installing Powerlevel10k for a modern theme (Optional)
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k for enhanced visuals..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k
    sed -i 's/ZSH_THEME="agnoster"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
fi

# Fonts for Powerlevel10k (Meslo Nerd Fonts)
if [ ! -d "$HOME/.fonts" ]; then
    echo "Installing Nerd Fonts (MesloLGS NF)..."
    mkdir -p ~/.fonts
    wget -qO ~/.fonts/MesloLGS_NF_Regular.ttf \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
    unzip -o ~/.fonts/MesloLGS_NF_Regular.ttf -d ~/.fonts
    fc-cache -fv
fi

# Plugins to enhance the ZSH experience
ZSH_PLUGINS=(
    git
    docker
    vagrant
    python
    golang
    zsh-autosuggestions       # Suggest commands as you type
    zsh-syntax-highlighting   # Syntax highlighting in the terminal
    zsh-completions           # Extra autocomplete options
)

# Installing additional plugins
declare -A plugin_repos=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
)

for plugin in "${!plugin_repos[@]}"; do
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin" ]; then
        echo "Installing $plugin..."
        git clone "${plugin_repos[$plugin]}" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"
    fi
done

# Adding plugins to .zshrc
PLUGIN_STRING=$(printf " %s" "${ZSH_PLUGINS[@]}")
sed -i "s/plugins=(git)/plugins=(${PLUGIN_STRING})/g" ~/.zshrc

# Apply changes
echo "Reloading ZSH configuration..."
exec zsh
