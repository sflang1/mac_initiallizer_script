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
  # OLD INSTALLATION PROCESS. DEPRECATED FOR RBENV INSTALLER
  # if [ -z $(which rbenv) ]; then
  #   # Install rbenv
  #   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  #   # Install a performance extension (specified in https://github.com/rbenv/rbenv)
  #   cd ~/.rbenv && src/configure && make -C src
  #   # Ruby build installation, for using the command rbenv install
  #   git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  # fi
  # Run Rbenv installer.
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}


main "$@"
