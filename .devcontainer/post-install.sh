#!/bin/sh

# Install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add zsh-autosuggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Add .zshrc for theme, plugin, and path configs
cp /workspace/.devcontainer/.zshrc $HOME/.zshrc

# Install golang IDE Tooling
go install golang.org/x/tools/gopls@latest #Language server from Google
go install github.com/cweill/gotests/gotests@v1.6.0 #Generate unit tests
go install github.com/fatih/gomodifytags@v1.16.0 #Modify tags on structs 
go install github.com/josharian/impl@v1.1.0 #Stubs for interfaces
go install github.com/haya14busa/goplay/cmd/goplay@v1.0.0 #Go playground
go install github.com/go-delve/delve/cmd/dlv@latest #Go debugger
go install honnef.co/go/tools/cmd/staticcheck@latest #Linter

# Install project specific development dependencies
go install github.com/a-h/templ/cmd/templ@latest
go install github.com/cosmtrek/air@latest
