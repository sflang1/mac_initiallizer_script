#!/usr/bin/env bash

# The first step is to install zsh.
brew install zsh zsh-completions

# Install zplug, the manager of plugins we will use.
curl -sL zplug.sh/installer | zsh

# Add the zsh-syntax-highlighting plugin
echo "zplug\"zsh-users/zsh-syntax-highlighting\", nice:10" >> ~/.zshrc

# Add some plugins to the .zshrc file
gsed -i 's/plugins=(git)/plugins=(git bundler colorized brew zeus gem rails ruby npm node nano nanoc history-substring-search)/' ~/.zshrc

# Update the zsh console manually to run zsh
chsh -s $(which zsh)
