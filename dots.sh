#!/usr/bin/env bash

# Created by Sebastián Landínez, based on https://github.com/gato-omega/my-dots
set -eu   # Make that the errors in every script stop the execution of the general script.

# First of all, install brew and some other required installers
sh scripts/binaries.sh
# I think the first should be install ZSH and the plugin managers, in this case, we'll use
