# #!/usr/bin/env bash

main(){
  # The first step is to install zsh.
  brew install zsh zsh-completions

  # Install zplug, the manager of plugins we will use.
  brew install zplug

  # Update the zsh console manually to run zsh
  chsh -s $(which zsh)

  # Insert line by line configurations to the zsh, if not existing
  # insert_line_into_file "plugins=(git bundler colorized brew zeus gem rails ruby npm node nano nanoc history-substring-search)" ~/.zshrc
  insert_line_into_file "export ZPLUG_HOME=/usr/local/opt/zplug" ~/.zshrc
  insert_line_into_file "source \$ZPLUG_HOME/init.zsh" ~/.zshrc
  insert_line_into_file "# Zplug plugins" ~/.zshrc
  insert_line_into_file "zplug \"plugins/git\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/bundler\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/colorized\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/brew\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/zeus\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/gem\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/rails\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/ruby\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/npm\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/node\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/nano\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/nanoc\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"plugins/history-substring-search\",     from: oh-my-zsh" ~/.zshrc
  insert_line_into_file "zplug \"zsh-users/zsh-syntax-highlighting\", nice: 10" ~/.zshrc
  insert_line_into_file "zplug install" ~/.zshrc

  # Source the changes in ~/.zshrc
  source ~/.zshrc
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}

main "$@"
