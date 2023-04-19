# set nvim as default editor
export EDITOR=nvim

# alias
alias ls='ls --color=auto'
alias vim='nvim'

# Zap
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
[ -f "$HOME/.config/zsh/plugins.zsh" ] && source "$HOME/.config/zsh/plugins.zsh"
