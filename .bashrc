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
PS1='\[\e[36m\]\u \[\e[0m\]in \[\e[32m\]\W \[\e[0m\]$(git_branch)> '

# Aliases
alias reset-software="killall gnome-software & rm -rf ~/.cache/gnome-software/"
alias ll='ls -lah'
alias tree='tree --dirsfirst -F'

alias gaa='git add .'
alias gap='git add -p'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gs='git status'
alias gpl='git pull origin'
alias gph='git push origin'
alias glog='git log --graph --decorate --all'

alias c='clear'

alias eb='nvim ~/.bashrc'
alias sb='source ~/.bashrc'

# Flatpak
PATH="~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "`fnm env`"

# fzf
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash

# cargo
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"

# odinlang
export PATH="$HOME/Programs/Odin/:$PATH"
