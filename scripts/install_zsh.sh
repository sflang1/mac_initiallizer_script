# #!/usr/bin/env bash

main(){
  # The first step is to install zsh.
  brew install zsh zsh-completions

  # Install zplug, the manager of plugins we will use. Just install if it is not installed
  if [[ ! -a  ~/.zplug ]]; then
    curl -sL zplug.sh/installer | zsh
  else
    echo "Zplug already installed"
  fi

  # Update the zsh console manually to run zsh
  chsh -s $(which zsh)

  # Insert line by line configurations to the zsh, if not existing
  insert_line_into_file "plugins=(git bundler colorized brew zeus gem rails ruby npm node nano nanoc history-substring-search)" ~/.zshrc
  insert_line_into_file "# Zplug plugins" ~/.zshrc
  insert_line_into_file "source ~/.zplug/init.zsh" ~/.zshrc
  insert_line_into_file "zplug \"zsh-users/zsh-syntax-highlighting\", nice: 10" ~/.zshrc

  # Source the changes in ~/.zshrc
  source ~/.zshrc
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}

main "$@"
