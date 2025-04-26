autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

bindkey -e

# History

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_alldups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

PS1='%F{blue}%~ %(?.%F{green}.%F{red})❭%f '

alias ls="eza --icons=always"
alias la='eza -lua --icons=always'
alias grep='grep --color=auto'
alias zed='zeditor -n'
alias ec='emacsclient -n'
alias em='emacsclient -n -c'
alias hx='helix'
alias lg='lazygit'
alias t='tmux new-session -A -s default'
alias h='helix .'
alias c='clear'
alias y='yazi'
alias s='sesh connect $(sesh list | fzf)'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# bun completions
[ -s "/home/f278f1b2/.bun/_bun" ] && source "/home/f278f1b2/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
source <(fzf --zsh)

