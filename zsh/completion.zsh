zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit -u

setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt MENU_COMPLETE
setopt GLOB_COMPLETE
setopt HASH_LIST_ALL
unsetopt LIST_BEEP

zstyle ':completion:*' menu select
