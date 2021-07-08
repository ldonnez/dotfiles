#********* SOURCES ***************************************************
#
#*********************************************************************
#
test -r "~/.dir_colors" && eval $(dircolors ~/.dir_colors)

# Z
source ~/.zsh/plugins/zsh-z.pugin.zsh

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

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
zstyle ':completion:*' menu select
setopt PROMPT_SUBST
PROMPT='┌%F{green}[%n] [%F{green}%m]:%f%F{blue}%B%~%b%f ${vcs_info_msg_0_}%f
└>'

#*********************************************************************
#
#********* KEYBINDINGS ***********************************************

bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^K" kill-line
bindkey "^P" up-line-or-history

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
