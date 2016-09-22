#!/usr/bin/env zsh
main(){
  # Install Rubyenv for managing the Ruby versions
  # First of all, check if Git is installed
  if [[ ! $(which git) ]]; then
    echo "Git is not installed."
    return
  fi


  ################################ RBENV INSTALLATION #################################
  # Rbenv not installed
  if [ -z $(which rbenv) ]; then
    # Install rbenv
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    # Install a performance extension (specified in https://github.com/rbenv/rbenv)
    cd ~/.rbenv && src/configure && make -C src
    # Ruby build installation, for using the command rbenv install
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi

  ################################ NODENV INSTALLATION ################################
  # Check if nodenv is installed
  if [ -z $(which nodenv) ]; then
    # Install nodenv
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    # Install a performance extension (specified in https://github.com/rbenv/rbenv)
    cd ~/.nodenv && src/configure && make -C src
    # Node build installation, for using the command rbenv install
    git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
  fi

  ################################ PHANTOMENV INSTALLATION ############################
  # Check if phantomenv is installed
  if [ -z $(which phantomenv) ]; then
    # Install phantomenv
    git clone -b v0.0.10 https://github.com/boxen/phantomenv.git ~/.phantomenv
  fi

  # First of all, move all the templates in this script to a directory called dotfiles
  mkdir ~/dotfiles
  cp templates/* ~/dotfiles     # Copy the contents to the newly created directory
  git init ~/dotfiles           # Initiallize a git repo in this directory
  # As stated in this guide (https://codingkilledthecat.wordpress.com/2012/08/08/git-dotfiles-and-hardlinks/),
  # it's better to link the files from inside the repo outside of it.
  cd ~
  # Do a symlink between every file in the dotfiles directory and the home directory
  for f in dotfiles/*
    ln -s $f ~/$(basename $f)
  do
    # Create a symlink between this file and the file in
  done

  source ~/.zshrc
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}


main "$@"
