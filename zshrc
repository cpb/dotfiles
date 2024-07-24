# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bira"

DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
  dotenv
  brew
  bundler
  gem
  git
  nvm
)

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

function passphrase() {
  sort --random-sort ~/.dotfiles/eff_large_wordlist.txt | head -n 7
}

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

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

export PATH="$HOME/.cargo/bin:$PATH"

function wiki() {
  MESSAGE="${@}"
  git -C ./wiki add . &&
    git -C ./wiki commit -m "${MESSAGE}" &&
    git -C ./wiki push origin master
}

function update-remote() {
  gfa && git co ${BASE_BRANCH:-main} && ggpull && git co - && git rebase ${BASE_BRANCH:-main} && ggpush -f
}

function update() {
  gfa && git co ${BASE_BRANCH:-main} && ggpull && git co - && git rebase ${BASE_BRANCH:-main}
}

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export PATH="/opt/homebrew/bin:$PATH"

eval "$(rbenv init -)"

export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

}

alias pf="ggpush -f"
alias pk="ggpush"
alias ci="gitmoji -c"
alias p="git add -p"
alias a="git commit --amend"

alias githash="git --no-pager log -1 --format=\"%H\""

