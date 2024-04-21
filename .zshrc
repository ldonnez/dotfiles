#*********************************************************************
#
#********* SETTINGS **************************************************

autoload -Uz add-zsh-hook

# History
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

# Make sure regular keybindings persist in foreign terminal sessions (tmux & neovims term)
bindkey -e

# Too many open files!
if [ $(uname) = "Darwin" ]; then
  ulimit -n 10240
fi

#*********************************************************************
#
#********* TMUX ******************************************************

# sync envvariables to tmux see 'set -g update-environment' option in ~/.tmux.conf
function update_environment_from_tmux() {
  if [ -n "${TMUX}" ]; then
    eval "$(tmux show-environment -s)"
  fi
}

add-zsh-hook precmd update_environment_from_tmux

#*********************************************************************
#
#********* PROMPT ****************************************************

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

#*********************************************************************
#
#********* FZF *******************************************************

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS=" \
  --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
  --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
  --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

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

# POSTGRES
alias psql="psql -U postgres -h localhost -p 5432"
alias createdb="createdb -U postgres -h localhost -p 5432"
alias dropdb="dropdb -U postgres -h localhost -p 5432"
alias pg_dump="pg_dump -U postgres -h localhost -p 5432"
alias pg_restore="pg_restore -U postgres -h localhost -p 5432"

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
export NPM_CONFIG_PREFIX=$HOME/.npm
export PATH=$HOME/.npm/bin:$PATH

# YARN
export PATH=$HOME/.yarn/bin:$PATH

# GO
export PATH=$HOME/go/bin:$PATH

# PHP
export PATH=/usr/local/php/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH

# RUST
export PATH=$HOME/.cargo/bin:$PATH

# GPG
GPG_CONFIG_FILE="~/.gnupg/gpg-agent.conf"

# GIT
export REVIEW_BASE=develop

# HOMEBREW
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

if [[ $(uname -m) == 'arm64' ]] && [[ $(uname) = "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# LIBPQ
if [ $(uname) = "Darwin" ]; then
  export PATH="/usr/local/opt/libpq/bin:$PATH"
fi

# ANDROID
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# HASKELL
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
export PATH=$HOME/.cabal/bin:$PATH

#*********************************************************************
#
#********* COMPLETIONS ***********************************************

# Load autocompletions
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Navigate suggestions with completion menu
zstyle ':completion:*' menu select

# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

#*********************************************************************
#
#********* PLUGINS ***************************************************

# Z
if [[ ! -a ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh ]]; then
  git clone https://github.com/agkozak/zsh-z ~/.zsh/plugins/zsh-z
fi
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh

# FZF TAB
if [[ ! -a ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab
fi
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

alias luamake=/Users/lenny/.local/share/nvim/site/pack/packer/start/lua-language-server/3rd/luamake/luamake

#*********************************************************************
#
#********* ASDF ******************************************************

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

