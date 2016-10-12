#!/usr/bin/env zsh
main()
{
  # Create the dotfiles directory.
  if [[ ! -d ~/dotfiles ]]; then
    mkdir ~/dotfiles
  fi

  # Choosing a source for the dotfiles.
  local confirmation=''
  vared -p 'Do you want to obtain the dotfiles from a repository from your own? ' confirmation
  local url=''
  if [[ ! -d ~/tmp_dotfiles ]]; then
    mkdir ~/tmp_dotfiles
  fi
  cd ~/tmp_dotfiles
  case $confirmation in
    [Yy]*)
      local exit_code=1
      vared -p 'Introduce the URL of the repository: ' -c url
      while [[ exit_code != 0 ]]
      do
        git clone $url
        exit_code=$?
        if [[ exit_code == 0 ]]; then
          # Successful git clone.
          echo "Files downloaded successfully."
          cd $(echo $(ls))  # Enter the directory
          export source_directory=$(realpath .)
        else
          echo "The git clone command was not successful with the URL provided. Please, check the URL or the permissions"
          vared -p 'Introduce the URL of the repository: ' -c url
        fi
      done
      ;;
    [Nn]*)
      echo 'Using the default dotfiles from https://github.com/codescrum/dotfiles/'
      git clone https://github.com/codescrum/dotfiles/
      echo "Files downloaded successfully"
      cd $(echo $(ls))
      export source_directory=$(realpath .)
      ;;
  esac

  # Copy idempotently the files from the source directory to the dotfiles
  for f in $source_directory/.[^.]*
  do
    if [[ ! -e ~/dotfiles/$(basename $f) ]]; then
      cp $(basename $f) ~/dotfiles
    fi
  done

  # Remove the temporary file that we've created
  rm -rf ~/tmp_dotfiles

  # Symlinking and creating the repository in this place.
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
  if [[ ! -d $(nodenv root)/plugins/node-build ]]; then
    git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
  fi

  # Add default gems to the rbenv configuration
  default_gems=(
    bundler
    pry
  )
  for gem_name in $default_gems[@]
  do
    echo $gem_name >> $(rbenv root)/default-gems
  done
}

script_exec_dir=$(dirname $0)
main "$@"
