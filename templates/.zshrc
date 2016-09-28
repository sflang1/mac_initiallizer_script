# Zplug configuration
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# Zplug themes
zplug "themes/robbyrussell", from:oh-my-zsh

# Zplug plugins
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh
zplug "plugins/nanoc", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/node", from:oh-my-zsh
zplug "plugins/rails", from:oh-my-zsh
zplug "plugins/ruby", from:oh-my-zsh
zplug "plugins/zeus", from:oh-my-zsh
zplug "zsh-users/zsh-autosuggestions", nice:15
zplug "zsh-users/zsh-syntax-highlighting", nice:15

# Install missing plugins
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

# Load the plugins in the terminal
zplug load --verbose

# Rbenv configuration
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Nodenv configuration
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Phantomenv configuration
export PATH="$HOME/.phantomenv/bin:$PATH"
eval "$(phantomenv init -)"
