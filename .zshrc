#*********************************************************************
#
#********* SETTINGS **************************************************

autoload -Uz add-zsh-hook

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt SHARE_HISTORY        # Share history across terminals and  write immediately
setopt HIST_IGNORE_ALL_DUPS # Removes older duplicate entries when saving new ones
setopt HIST_REDUCE_BLANKS   # Remove extra spaces from commands
setopt HIST_IGNORE_SPACE    # Ignore commands starting with a space
setopt HIST_NO_STORE        # Don't save history/fc commands
setopt EXTENDED_HISTORY     # Save timestamps alongside history

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
# runs once at shell startup instead of every prompt render
if [ -n "${TMUX}" ]; then
  eval "$(tmux show-environment -s)"
fi

#*********************************************************************
#
#********* PROMPT ****************************************************

setopt PROMPT_SUBST
PROMPT='┌%F{green}[%n] [%F{green}%m]:%f$(python_venv_prompt)%F{blue}%B%~%b%f$(git_prompt)%f
└>'

python_venv_prompt() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    # Extracts just the folder name of the venv and styles it in yellow
    echo "%F{yellow}($(basename "$VIRTUAL_ENV"))%f "
  fi
}

git_prompt() {
  local branch git_status

  # Not inside a Git repository, or HEAD is unavailable.
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
    branch=$(git rev-parse --short HEAD 2>/dev/null) ||
    return

  # Empty means clean, non-empty means dirty.
  git_status=$(git status --porcelain 2>/dev/null)

  if [[ -n "$git_status" ]]; then
    print -n " %F{yellow}$branch%f %F{red}✗%f"
  else
    print -n " %F{yellow}$branch%f %F{green}✔ %f"
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

# Neovim as EDITOR and PAGER for man and git
if command -v nvim &>/dev/null; then
  export EDITOR=nvim
  export MANPAGER='nvim +Man!'
  export GIT_EDITOR='nvim'
  export GIT_PAGER='nvim -R'
fi

# PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.npm/bin"
  "$HOME/.yarn/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "$HOME/.opencode/bin"
  "$HOME/.cabal/bin"
  "$HOME/.atuin/bin"
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  $path
)

# Remove duplicates
typeset -U path PATH

# NPM
export NPM_CONFIG_PREFIX=$HOME/.npm

# GPG
GPG_CONFIG_FILE="~/.gnupg/gpg-agent.conf"

# HOMEBREW
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#*********************************************************************
#
#********* COMPLETIONS ***********************************************

# Load local completion files
fpath=(
  "$HOME/.local/share/zsh/site-functions/"
  $fpath
)

# Load autocompletions
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Navigate suggestions with completion menu
zstyle ':completion:*' menu select

# Terraform
if [[ ! -e /usr/local/bin/terraform ]]; then
  complete -o nospace -C /usr/local/bin/terraform terraform
fi

#*********************************************************************
#
#********* PLUGINS ***************************************************

# Z
if [[ ! -e ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh ]]; then
  git clone https://github.com/agkozak/zsh-z ~/.zsh/plugins/zsh-z
fi
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh

# FZF TAB
if command -v fzf &>/dev/null; then
  if [[ ! -e ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
    git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab
  fi

  source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
  zstyle ':fzf-tab:*' use-fzf-default-opts yes
fi

#*********************************************************************
#
#********* ATUIN *****************************************************

if command -v atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

#*********************************************************************
#
#********* MISE ******************************************************

if [[ -x ~/.local/bin/mise ]]; then
  eval "$(~/.local/bin/mise activate zsh)"
fi
