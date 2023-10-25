# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Prompt setup
function git_branch() {
    if [ -d .git ] ; then
        printf "%s" "($(git branch 2> /dev/null | awk '/\*/{print $2}')) ";
    fi
}
PS1='\[\e[34m\]\u \[\e[0m\]in \[\e[32m\]\W \[\e[0m\]$(git_branch)> '

PATH="~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

# Aliases
alias reset-software="killall gnome-software & rm -rf ~/.cache/gnome-software/"
alias ll='ls -lah'
alias tree='tree --dirsfirst -F'

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "`fnm env`"

# fzf
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "`fnm env`"

# cargo
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"
