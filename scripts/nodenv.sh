#!/usr/bin/env zsh
main(){
  # Install Rubyenv for managing the Ruby versions
  # First of all, check if Git is installed
  if [[ ! $(which git) ]]; then
    echo "Git is not installed."
    return
  fi
  ################################ NODENV INSTALLATION ################################
  # Check if nodenv is installed
  if [ -z $(which nodenv) ]; then
    # Install nodenv
    git clone https://github.com/nodenv/nodenv.git ~/.nodenv
    # Install a performance extension (specified in https://github.com/rbenv/rbenv)
    cd ~/.nodenv && src/configure && make -C src
  fi
}
main "$@"
