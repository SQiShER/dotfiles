for config (~/.zsh/*.zsh) source $config
if [ -d ~/.zsh.local ] ; then
    for config (~/.zsh.local/*.zsh) source $config
fi
