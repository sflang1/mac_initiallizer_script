#!/usr/bin/env zsh
main()
{
  # First of all, move all the templates in this script to a directory called dotfiles
  if [[ ! -d ~/dotfiles ]]; then
    mkdir ~/dotfiles
  fi
  for f in $script_exec_dir/../templates/.[^.]*
  do
    # Copy idempotently the files from the templates directory to the dotfiles
    if [[ ! -e ~/dotfiles/$(basename $f) ]]; then
      cp $(basename $f) ~/dotfiles
    fi
  done
  cp $script_exec_dir/../templates/.[^.]* ~/dotfiles     # Copy the contents to the newly created directory
  cd ~/dotfiles           # Initiallize a git repo in this directory
  if [[ ! -d ~/dotfiles/.git ]]; then
    git init
  fi
  # As stated in this guide (https://codingkilledthecat.wordpress.com/2012/08/08/git-dotfiles-and-hardlinks/),
  # it's better to link the files from inside the repo outside of it.
  cd ~
  # Do a symlink between every file in the dotfiles directory and the home directory
  for f in ~/dotfiles/.[^.]*
  do
    # If the file doesn't exists, do the symlink.
    if [[ ! -e ~/$(basename $f) ]]; then
      # Create a symlink between this file and the file in the HOME directory
      ln -s $f ~/$(basename $f)
    fi
  done
  # For some reason, a git repo is created at ~ directory. Remove it:
  rm ~/.git
  source ~/.zshrc
  # Some files created are created without permissions required. Add this line to modify this permissions
  compaudit | xargs chmod g-w

  # Node build installation, for using the command nodenv install
  git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
}

script_exec_dir=$(dirname $0)
main "$@"
