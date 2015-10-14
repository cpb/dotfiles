# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bira"

DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(autojump brew bundler gem git vagrant) #rbenv)

source $ZSH/oh-my-zsh.sh

# disable autocorrect
unsetopt correct_all

alias ll='ls -lh'
alias l='ls -lah'
alias b='bundle exec'
alias bi='bundle install --binstubs=.bin'

# use most as pager if available
if which most > /dev/null; then
  export PAGER=most
fi

export EDITOR=vim

# ctrl+left/right
bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word

# history search up and down
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

if [[ -z $TMUX ]]; then
  # homebrew only
  [[ `uname` == "Darwin" ]] && export PATH=/usr/local/bin:$PATH

  # nodejs / npm
  [[ -d "/usr/local/share/npm/bin" ]] && export PATH=/usr/local/share/npm/bin:$PATH

  PATH=$PATH:$HOME/android-sdk-macosx/tools

  # rbenv
  # PATH="$HOME/.rbenv/bin:$PATH"

  PATH="$PATH:$HOME/.rvm/bin"
  PATH="/usr/local/apache-maven-3.2.3/bin:$PATH"
  PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"
fi
# eval "$(rbenv init -)"
eval "$(boot2docker shellinit)"

export JAVA_HOME=$(/usr/libexec/java_home)
export MAVEN_OPTS="-Xms512m -Xmx4096m -XX:MaxPermSize=246M"
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
. ~/.nvm/nvm.sh
