#! /usr/bin/env bash
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
    # Add the rbenv to the .zshrc file
    insert_line_into_file '# Rbenv configuration\nexport PATH="$HOME/.rbenv/bin:$PATH"' ~/.zshrc
    insert_line_into_file '~/.rbenv/bin/rbenv init' ~/.zshrc
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
    # Add the nodenv to the .zshrc file
    insert_line_into_file '#Nodenv configuration\nexport PATH="$HOME/.nodenv/bin:$PATH"' ~/.zshrc
    insert_line_into_file "eval \"$(nodenv init -)\"" ~/.zshrc
    # Node build installation, for using the command rbenv install
    git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
  fi

  ################################ PHANTOMENV INSTALLATION ############################
  # Check if phantomenv is installed
  if [ -z $(which phantomenv) ]; then
    # Install phantomenv
    git clone -b v0.0.10 https://github.com/boxen/phantomenv.git ~/.phantomenv
    # Add the phantomenv to the .zshrc file
    insert_line_into_file '#phantomenv configuration\nexport PATH="$HOME/.phantomenv/bin:$PATH"' ~/.zshrc
    insert_line_into_file "eval \"$(phantomenv init -)\"" ~/.zshrc
  fi

  source ~/.zshrc

  # Install a ruby default version (Mac has his own, in any case)
  rbenv install 2.3.1
  # Set this version as global
  rbenv global 2.3.1
  # Install bundler
  gem install bundler
  # Install rails
  gem install rails
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo -e "$line" >> "$file"
}


main "$@"
