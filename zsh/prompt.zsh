autoload -Uz add-zsh-hook

setopt PROMPT_SUBST

DEFAULT_RPROMPT=$'[%*]'
PROMPT=$'\n%B%n%b@localhost %B%~%b\n> %F{green}$%f '
RPROMPT=$DEFAULT_RPROMPT

is_git_repository() {
    [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

git_plugin() {
    if is_git_repository; then
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null) ||
        local branch_name="(detached state)" 
        psvar[1]=$branch_name
        RPROMPT="%B%F{green}±%f%1v%b $DEFAULT_RPROMPT"
    else
        RPROMPT=$DEFAULT_RPROMPT
    fi
}

add-zsh-hook precmd git_plugin