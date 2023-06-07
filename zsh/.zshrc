# set nvim as default editor
export EDITOR=nvim

# setup for fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# alias
alias ls='ls --color=auto'
alias vim='nvim'

# eww bins
export PATH=${XDG_CONFIG_HOME:-$HOME/.config}/eww/bin:$PATH

# Zap
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
[ -f "$HOME/.config/zsh/plugins.zsh" ] && source "$HOME/.config/zsh/plugins.zsh"
