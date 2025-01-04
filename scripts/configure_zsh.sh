#!/bin/bash
set -e

# Install ZSH and set as default shell
sudo apt-get install -y zsh
chsh -s $(which zsh) vagrant

# Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sudo apt-get install -y git
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # Set a user-friendly ZSH theme and plugins
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
  sed -i 's/plugins=(git)/plugins=(git docker vagrant python golang)/g' ~/.zshrc
fi
