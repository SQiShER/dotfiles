zstyle ':completion:*' completer _expand _complete
zstyle ':completion::expand:*' tag-order all-expansions
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit -u
bindkey '^[[Z' reverse-menu-complete # Allows Shift+TAB to move backwards through the menu

unsetopt LIST_BEEP
setopt LIST_TYPES
setopt GLOB_COMPLETE
setopt MENU_COMPLETE
setopt COMPLETE_IN_WORD