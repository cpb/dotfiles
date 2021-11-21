# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bira"

DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(autojump brew bundler gem git vagrant knife nvm)

source $ZSH/oh-my-zsh.sh

# disable autocorrect
unsetopt correct_all

# homebrew only
[[ `uname` == "Darwin" ]] && export PATH=/usr/local/bin:$PATH

# nodejs / npm
[[ -d "/usr/local/share/npm/bin" ]] && export PATH=/usr/local/share/npm/bin:$PATH

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

export ACKRC=".ackrc"
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

export PATH=$HOME/.rbenv/bin:$PATH
export PATH=./bin:$PATH

eval "$(rbenv init -)"

function passphrase() {
  sort --random-sort ~/.dotfiles/eff_large_wordlist.txt | head -n 7
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias s="b bin/rails s"
alias c="b bin/rails c"
alias t="b bin/rails test"

export DEFAULT_PARENT_BRANCH='master'

function parent_branch() {
  echo "${DEFAULT_PARENT_BRANCH:-$(guess_parent_branch)}"
}

function guess_parent_branch() {
  git show-branch -a \
    | grep '\*' \
    | grep -v `git rev-parse --abbrev-ref HEAD` \
    | head -n1 \
    | sed 's/.*\[\(.*\)\].*/\1/' \
    | sed 's/[\^~].*//'
}

function tests_path() {
  [ -d "test" ] && echo "test" || echo "spec"
}

function changed_test_files() {
  git diff --name-only $(parent_branch) $(tests_path) | grep -E "_(test|spec).rb" | xargs
}

function tc() {
  t $(changed_test_files) $@
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

function bfg() {
  java -jar ~/bfg.jar $@
}

[ -s "$HOME/.work_credentials" ] && \. $HOME/.work_credentials

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.cargo/bin:$PATH"
