ZSH=$HOME/.oh-my-zsh
NVM=$HOME/.nvm
RVM=$HOME/.rvm

ZSH_THEME="bureau"

source ~/.aliases

CASE_SENSITIVE="true"

plugins=(git git-extras brew mvn sublime encode64 docker vagrant ruby colored-man urltools terminalapp)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$RVM/bin

alias jsonpretty="ruby -r json -e 'jj JSON.parse gets'"

source $NVM/nvm.sh
