autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

bindkey -e

ZLE_RPROMPT_INDENT=0

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

# PS1='%F{blue}%~ %(?.%F{green}.%F{red})❭%f '

alias ls='eza --icons=always'
alias la='eza -lua --icons=always'
alias lt='eza --tree --icons=always'
alias vim='nvim'
alias grep='grep --color=auto'
alias zed='launch-zed -n'
alias ec='emacsclient -n'
alias em='emacsclient -n -c'
alias lg='lazygit'
alias t='tmux new-session -A -s "$(basename "$PWD")"'
alias c='clear'
alias y='yazi'
alias s='sesh connect $(sesh list | fzf)'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias claude="HTTP_PROXY=$(secret-tool lookup proxy url) $HOME/.claude/local/claude"

# starship
eval "$(starship init zsh)"

# bun completions
[ -s "/home/f278f1b2/.bun/_bun" ] && source "/home/f278f1b2/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
source <(fzf --zsh)

# fnm
FNM_PATH="/home/f278f1b2/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/f278f1b2/.local/share/fnm:$PATH"
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

