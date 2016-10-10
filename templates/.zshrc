# Zplug configuration.
# Zplug is installed in this directory whenever its installed through curl, instead of brew.
export ZPLUG_HOME=~/.zplug
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

# Installing Oh-my-zsh lib
zplug "lib/*", from:oh-my-zsh

# Install missing plugins
if ! zplug check --verbose; then
  local confirmation=$1
  vared -p 'Do you wish to install these packages? [y/n]?' -c confirmation
  case $confirmation in
    [Yy]* )
      echo; zplug install
      ;;
    esac
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

# Jenv configuration
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# pgvm configuration
source ~/.pgvm/pgvm_env

# DVM configuration
source ~/.dvm/dvm.sh
[[ -r $DVM_DIR/bash_completion ]] && . $DVM_DIR/bash_completion

# History substring search configuration
zmodload zsh/terminfo
# For Mac OSX 10.9
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Share the terminal history. SAVEHIST is the number of lines to save, so set it really high.
export SAVEHIST=200000
export HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history
