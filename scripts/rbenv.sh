#!/usr/bin/env bash
main(){
  # Install Rubyenv for managing the Ruby versions
  # First of all, check if Git is installed
  # Verify Git is installed:
  if [ ! $(which git) ]; then
    echo "Git is not installed, can't continue."
    exit 1
  fi

  if [ -z "${RBENV_ROOT}" ]; then
    RBENV_ROOT="$HOME/.rbenv"
  fi

  # Install rbenv:
  if [ ! -d "$RBENV_ROOT" ] ; then
    git clone https://github.com/sstephenson/rbenv.git $RBENV_ROOT
  else
    cd $RBENV_ROOT
    if [ ! -d '.git' ]; then
      git init
      git remote add origin https://github.com/sstephenson/rbenv.git
    fi
    git pull origin master
  fi

  # Install plugins:
  PLUGINS=(
    sstephenson/rbenv-vars
    sstephenson/ruby-build
    sstephenson/rbenv-default-gems
    sstephenson/rbenv-gem-rehash
    fesplugas/rbenv-installer
    fesplugas/rbenv-bootstrap
    rkh/rbenv-update
    rkh/rbenv-whatis
    rkh/rbenv-use
  )

  for plugin in ${PLUGINS[@]} ; do

    KEY=${plugin%%/*}
    VALUE=${plugin#*/}

    RBENV_PLUGIN_ROOT="${RBENV_ROOT}/plugins/$VALUE"
    if [ ! -d "$RBENV_PLUGIN_ROOT" ] ; then
      git clone https://github.com/$KEY/$VALUE.git $RBENV_PLUGIN_ROOT
    else
      cd $RBENV_PLUGIN_ROOT
      echo "Pulling $VALUE updates."
      git pull
    fi

  done

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
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}


main "$@"
