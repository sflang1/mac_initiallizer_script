#!/usr/bin/env bash

# Created by Sebastián Landínez, based on https://github.com/gato-omega/my-dots
set -eu   # Make that the errors in every script stop the execution of the general script.

# Put some defaults related to the environment
# sh scripts/defaults.sh
# First of all, install brew and some other required installers
sh scripts/binaries.sh
# I think the first should be install ZSH and the plugin managers, in this case, we'll use
# zPlug, can be found in: https://github.com/zplug/zplug
sh scripts/install_zsh.sh
# Install some apps through Brew. This includes chrome, skype, atom, etc.
sh scripts/apps.sh
# Do some configurations for security checks
# sh scripts/security.sh
# Setting the Ruby environment
sh scripts/rbenv.sh
