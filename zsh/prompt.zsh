autoload -Uz add-zsh-hook

setopt PROMPT_SUBST

local PROMPT_LINE1="%B%n%b@localhost %B%~%b"
local PROMPT_LINE2="> %F{green}$%f "
local RPROMPT_LINE1="%*"
local RPROMPT_LINE2=""

get_visible_length() {
    # http://stackoverflow.com/a/10564427
    local zero='%([BSUbfksu]|([FB]|){*})'
    print ${#${(S%%)1//$~zero}}
}

# TRAPWINCH() {
#     LEFT_PROMPT_LINE1_WIDTH=$(get_visible_length $PROMPT_LINE1)
#     RIGHT_PROMPT_LINE1_WIDTH=$(get_visible_length $RPROMPT_LINE1)
#     LINE1_SPACING=$((COLUMNS - LEFT_PROMPT_LINE1_WIDTH - RIGHT_PROMPT_LINE1_WIDTH - 1))
#     PROMPT=$'\n'"$PROMPT_LINE1${(l:$LINE1_SPACING:)}$RPROMPT_LINE1"$'\n'"$PROMPT_LINE2"
#     zle reset-prompt
# }

custom_ps1() {
    local LEFT_PROMPT_LINE1_WIDTH=$(get_visible_length $PROMPT_LINE1)
    local RIGHT_PROMPT_LINE1_WIDTH=$(get_visible_length $RPROMPT_LINE1)
    local LINE1_SPACING=$((COLUMNS - LEFT_PROMPT_LINE1_WIDTH - RIGHT_PROMPT_LINE1_WIDTH - 1))
    PROMPT=$'\n'"$PROMPT_LINE1${(l:$LINE1_SPACING:)}$RPROMPT_LINE1"$'\n'"$PROMPT_LINE2"
    RPROMPT=$RPROMPT_LINE2
}

is_git_repository() {
    [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1
}

has_uncommitted_files() {
    [ $(git status --short 2>/dev/null | wc -l | awk '{print $1}') -gt 0 ]
}

has_untracked_files() {
    [ $(git ls-files --others --exclude-standard | wc -l | awk '{print $1}') -gt 0 ]
}

has_unpushed_commits() {
    [ $(git cherry -v | grep -e '^-' | wc -l | awk '{print $1}') -gt 0 ]
}

git_plugin() {
    if is_git_repository; then
        if has_uncommitted_files; then
            psvar[2]='●'
        else
            psvar[2]=''
        fi
        if has_untracked_files; then
            psvar[3]='●'
        else
            psvar[3]=''
        fi
        if has_unpushed_commits; then
            psvar[4]='▴'
        else
            psvar[4]=''
        fi
        local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null) ||
        local branch_name="(detached state)"
        psvar[1]=$branch_name
        RPROMPT_LINE2='[%B%F{green}±%f%1v%b %F{red}%3v%f%F{yellow}%2v%f%F{blue}%4v%f]'
    else
        RPROMPT_LINE2=''
    fi
}

add-zsh-hook precmd git_plugin
add-zsh-hook precmd custom_ps1
