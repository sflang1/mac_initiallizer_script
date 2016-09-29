#!/usr/bin/env bash

# Created by Sebastián Landínez, based on https://github.com/gato-omega/my-dots
set -eu   # Make that the errors in every script stop the execution of the general script.


# First of all, install brew and some other required installers (core-utils also for the realpath, etc.)
sh scripts/binaries.sh
# Put some defaults related to the environment
export dirname=$(dirname $(realpath $0))
export lib="$dirname/lib"
export SHELL_LIBRARY_PATH="$dirname/lib"
sh scripts/defaults.sh
# I think the first should be install ZSH and the plugin managers, in this case, we'll use
# zPlug, can be found in: https://github.com/zplug/zplug
sh scripts/install_zsh.sh
# Add the ssh-key to the system
sh scripts/ssh_add.sh
# Install some apps through Brew. This includes chrome, skype, atom, etc.
sh scripts/apps.sh
# Do some configurations for security checks
# sh scripts/security.sh
# Setting the Ruby environment
sh scripts/rbenv.sh
# Create the dotfiles directory and run the necessary tasks
zsh scripts/dotfiles_configuration.sh

# Install a ruby default version (Mac has his own, in any case)
# rbenv install 2.3.1
# # Set this version as global
# rbenv global 2.3.1
# # Install bundler
# gem install bundler
# # Install rails
# gem install rails

read -p "Most of the scripts run require a restart of the system. Do you wish to restart now? [y/n] " confirmation
case $confirmation in
  [Yy]* )
    sudo shutdown -r now
    ;;
  [Nn]* )
    echo "Remember to restart your PC!."
    ;;
esac
