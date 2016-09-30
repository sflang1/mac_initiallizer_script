#!/usr/bin/env zsh
main(){
  # Install Rubyenv for managing the Ruby versions
  # First of all, check if Git is installed
  if [[ ! $(which git) ]]; then
    echo "Git is not installed."
    return
  fi


  ################################ RBENV INSTALLATION ################################
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
  fi

  ################################ PHANTOMENV INSTALLATION ############################
  # Check if phantomenv is installed
  if [ -z $(which phantomenv) ]; then
    # Install phantomenv
    git clone -b v0.0.10 https://github.com/boxen/phantomenv.git ~/.phantomenv
  fi

  ################################ PGVM INSTALLATION ##################################
  # Check if pgvm is installed
  if [ -z $(which pgvm) ]; then
    # Install pgvm
    curl -s -L https://raw.github.com/guedes/pgvm/master/bin/pgvm-self-install | bash
  fi
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}


main "$@"
