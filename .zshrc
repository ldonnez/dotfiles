#********* SOURCES ***************************************************
#
#*********************************************************************

# Z
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh

# FZF TAB
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

# RBENV
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# WSL2
if [[ -a ~/.wslrc ]]; then
  source ~/.wslrc
fi

# TMUX
function update_environment_from_tmux() {
  if [ -n "${TMUX}" ]; then
    eval "$(tmux show-environment -s)"
  fi
}

add-zsh-hook precmd update_environment_from_tmux

#*********************************************************************
#
#********* HISTORY ***************************************************

HISTFILE=$HOME/.history
SAVEHIST=1000
setopt share_history
setopt inc_append_history
setopt append_history
setopt hist_ignore_dups
setopt histignorealldups
setopt histreduceblanks
setopt histignorespace
setopt hist_no_store
setopt extended_history
setopt histignorespace

#*********************************************************************
#
#********* PROMPT ****************************************************

bindkey -e
zstyle ':completion:*' menu select
setopt PROMPT_SUBST
PROMPT='┌%F{green}[%n] [%F{green}%m]:%f%F{blue}%B%~%b%f$(git_prompt)%f
└>'

git_prompt() {
  local BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')

  if [ ! -z $BRANCH ]; then
    echo -n "%F{yellow}$BRANCH%f"

    if [ ! -z "$(git status --short)" ]; then
      echo " %F{red}✗%f"
    else
      echo " %F{green}✔%f"
    fi
  fi
}

if [ $(uname) = "Darwin" ]; then
  ulimit -n 10240
fi

#*********************************************************************
#
#********* FZF *******************************************************

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# COLORS
local nord0_term="-1"
local nord1_term="0"
local nord3_term="8"
local nord5_term="7"
local nord6_term="15"
local nord7_term="14"
local nord8_term="6"
local nord9_term="4"
local nord10_term="12"
local nord11_term="1"
local nord12_term="11"
local nord13_term="3"
local nord14_term="2"
local nord15_term="5"

export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS"\
" --color=bg+:$nord1_term,bg:$nord0_term,spinner:$nord9_term,hl:$nord3_term"\
" --color=fg:$nord5_term,header:$nord8_term,info:$nord10_term,pointer:$nord9_term"\
" --color=marker:$nord9_term,fg+:$nord6_term,prompt:$nord9_term,hl+:$nord9_term"

function fzf_gitbranches() {
  git for-each-ref --sort='authordate:iso8601' --format='%(authordate:relative)%09%(refname:short)' refs/heads | fzf --tac --bind 'enter:execute(echo {} | rev | cut -f1 | rev | xargs git checkout)+abort,tab:execute-silent(echo {} | rev | cut -f1 | rev | pbcopy)+abort'
  zle reset-prompt
  zle redisplay
}
zle -N fzf_gitbranches
bindkey "^y" fzf_gitbranches

if [ $(uname) = "Darwin" ]; then
  function fzf_applications() {
    open -a $(ls /Applications | sed s/.app//g | fzf).app
  }
  zle -N fzf_applications
  bindkey "^o" fzf_applications
fi

#*********************************************************************
#
#********* NVM *******************************************************

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  nvm $@
}

export DEFAULT_NODE_VER="$( (< "$NVM_DIR/alias/default" || < ~/.nvmrc) 2> /dev/null)"
while [ -s "$NVM_DIR/alias/$DEFAULT_NODE_VER" ] && [ ! -z "$DEFAULT_NODE_VER" ]; do
  export DEFAULT_NODE_VER="$(<"$NVM_DIR/alias/$DEFAULT_NODE_VER")"
done

if [ ! -z "$DEFAULT_NODE_VER" ]; then
  export PATH="$NVM_DIR/versions/node/v${DEFAULT_NODE_VER#v}/bin:$PATH"
fi

#*********************************************************************
#
#********* ALIASES ***************************************************

alias reload="source ~/.zshrc"
alias vi="nvim"
alias be="bundle exec"
alias ghetto='ruby -e "print File.open('"'/usr/share/dict/words'"').read.lines.reject{|w| w.length < 3 || 10 < w.length}.sample(4).map{|w| w.strip! && w.downcase}.join('"'-'"')"'
alias radio1='mplayer http://icecast.vrtcdn.be/radio1-high.mp3 '

if [ $(uname) = "Darwin" ]; then
  alias sleepnow="pmset sleepnow"
fi

# GIT ALIASES
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias gus='git reset HEAD'
alias gm="git merge"
alias g='git'
alias get='git'
alias gst='git status'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gdv='git diff -w "$@" | nvim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcm='git commit -v -m'
alias gci='git commit --interactive'
alias gb='git branch'
alias gba='git branch -a'

# DOCKER
alias dkexec='docker exec -it'
alias dkrmi='docker rmi'
alias dkrm='docker rm'
alias dkps='docker ps'
alias dki='docker images'

#*********************************************************************
#
#********* EXPORTS ***************************************************

# SHELL
export SHELL=/bin/zsh

# TERM
export TERM=xterm-256color

# EDITOR
export EDITOR=nvim

# LOCALE
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# BIN PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:$PATH

# NPM
export PATH="$PATH:$HOME/.npm/bin"

# GO
export GO111MODULE=on
export GOPATH="$HOME/SynologyDrive/development/go"
export PATH=$PATH:$GOPATH/bin

# RUBY
export PATH="$HOME/.rbenv/bin:$PATH"

# PHP
export PATH=/usr/local/php/bin:$PATH
export PATH="$PATH:$HOME/.composer/vendor/bin"

# RUST
export PATH="$PATH:$HOME/.cargo/bin"

# GPG
GPG_CONFIG_FILE="~/.gnupg/gpg-agent.conf"

# GIT
export REVIEW_BASE=develop

# HOMEBREW
export HOMEBREW_NO_AUTO_UPDATE=1

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#*********************************************************************
#
#********* AUTOLOADS *************************************************

# LOAD AUTOCOMPLETIONS
autoload -U compinit && compinit

alias luamake=/Users/lenny/.config/nvim/cache/lua-language-server/3rd/luamake/luamake
