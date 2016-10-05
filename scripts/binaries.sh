#!/usr/bin/env bash

echo "Going to install binaries."
# This script aims to install some needed binaries
# First, install brew for installing new packages
if [ ! $(which brew) ]    # Check if is already installed
then
  echo "Installing brew..."
  $(which ruby) -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update
show_status "Updating homebrew" "$?"

# The console threw a warning about Xcode CLI. Install it
xcode-select --install

set +e

echo "Installing coreutils, findutils, bash v4 and grep (dupe)"

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
show_status "Installing GNU coreutils" "$?"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
show_status "Installing findutils" "$?"

# Install Bash 4
brew install bash
show_status "Installing Bash" "$?"

# Install more recent versions of some OS X tools
brew tap homebrew/dupes
brew tap homebrew/versions
brew install homebrew/dupes/grep
show_status "Installing dupes' grep" "$?"

# Install the gnu-sed in order to use opt-parse found in https://github.com/nk412/optparse for the
# scripts that could come next.
brew install gnu-sed --with-default-names
show_status "Installing gnu-sed" "$?"

set -e

# Install other useful binaries
binaries=(
  ack
  tree                # output directory and file structure in the console
  the_silver_searcher # 'ag' commandline tool (a better grep)
  git                 # git
  hub                 # git+hub (from Github)
  fasd                # Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v, https://github.com/clvv/fasd
  # postgres            # Postgres
  # phantomenv          # PhantomJS version manager (rbenv for phantomjs) # better to just enabled on its own
  jenv                # java version manager (rbenv for java) [javas must be manually added]
  qt                  # qt lib
  imagemagick         # watch out for graphicsmagick possible conflicts with executables, http://www.graphicsmagick.org/utilities.html
  pkgconfig           # or pkg-config? is an utility that reads metadata in order to correctly install components at compile time (gcc)
  # graphicsmagick      # imagemagick alternative, provides some of the same executables
  # docker              # The docker client.
  # docker-machine      # Also available as a cask, but this seems more adequate as it is just a binary
  # webkit2png
  # rename
  # zopfli
  # ffmpeg
  # python
  # mongo
  # sshfs
  # trash
  # node
)

# Install the binaries
set +e # If already installed, non-zero status error is reported, skip that
brew install ${binaries[@]}
show_status "Installing brew binaries" "$?"
set -e # revert back to errors aborting the entire script
# Installing DVM through cURL. It looks like brew recipe is not working well.
curl -sL https://download.getcarina.com/dvm/latest/install.sh | sh
# Remove outdated versions from the cellar
brew cleanup

exit 0
