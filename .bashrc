# .bashrc

# start tmux on every login
if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

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
PS1='\[\e[34m\]\u \[\e[0m\]in \[\e[30m\]\W \[\e[0m\]$(git_branch)> '

# Aliases
alias reset-software="killall gnome-software & rm -rf ~/.cache/gnome-software/"
alias ll='ls -lah'
alias tree='tree --dirsfirst -F'

# Flatpak
PATH="~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

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

# odinlang
export PATH="$HOME/Documents/programs/Odin/:$PATH"

# flutter
export PATH="$HOME/Documents/programs/flutter/bin/:$PATH"

# Load Angular CLI autocompletion.
source <(ng completion script)

# glsl_analyzer
export PATH="$HOME/Documents/programs/glsl_analyzer/bin/:$PATH"
