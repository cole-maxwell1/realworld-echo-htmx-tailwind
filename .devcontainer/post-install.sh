#!/bin/sh

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Add .zshrc for theme, plugin, and path configs
cp /workspace/.devcontainer/.zshrc $HOME/.zshrc

# Setup .env
cp /workspace/.sample.env /workspace/.env

# Install project modules
go mod download

# Install NPM dependencies
npm install /workspace
