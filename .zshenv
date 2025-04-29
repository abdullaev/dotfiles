typeset -U path PATH
path=(~/.local/bin $path)

export FZF_DEFAULT_OPTS="\
--prompt='❭ ' \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4"

export GOPATH="$HOME/go"
export GOROOT="/usr/lib/go"

export EDITOR="hx"
export VISUAL="hx"

PATH="$PATH:$HOME/.cargo/bin"

PATH="$PATH:$HOME/.config/emacs/bin"
PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
export PATH

