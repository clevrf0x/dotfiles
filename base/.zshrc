# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Custom config
## Environment variables
EDITOR=nvim
export PATH="$HOME/sdk/flutter/bin:$HOME/go/bin:$PATH"

## Alias
alias c='clear'
alias cf='clear && pfetch'
alias hx='helix'
alias tmux='tmux -u'

alias ls='eza'
alias l='eza -l'
alias ll='eza -la'
alias la='eza -la'

alias du='dust'
alias cat='bat'
alias grep='rg'

# Shell integrations
eval "$(fzf --zsh)"

# Load oh my posh prompt
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/catppuccin.json)"

# Start Zellij Sessions
# ZJ_SESSIONS=$(zellij list-sessions --no-formatting | sed 's/\x1B\[[0-9;]*[JKmsu]//g')
# NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)
#
# if [ "${NO_SESSIONS}" -ge 2 ]; then
#     SESSION=$(echo "${ZJ_SESSIONS}" | cut -d' ' -f1 | sk)
#     if [ -n "${SESSION}" ]; then
#         zellij attach "${SESSION}"
#     else
#         zellij attach -c
#     fi
# else
#     zellij attach -c
# fi
#
## Auto run scripts
# Colorscripts
pfetch
