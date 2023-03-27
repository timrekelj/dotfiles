# .bashrc

# Start tmux automatically
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#     tmux attach -t default || tmux new -s default
# fi

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
PS1='\[\e[32m\]\u \[\e[0m\]in \[\e[33m\]\W \[\e[0m\]$(git_branch)> '

PATH="~/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:$PATH"

# Aliases
alias reset-software="killall gnome-software & rm -rf ~/.cache/gnome-software/"
alias src_rc='source ~/.bashrc'
alias ll='ls -lah'
alias c='clear'
alias tree='tree --dirsfirst -F'

# Git aliases
alias gb='git branch'
alias gadd='git add .'
alias gc='git commit -m'
alias gpull='git pull origin'
alias gpush='git push origin'

# fnm
export PATH="/home/timrekelj/.local/share/fnm:$PATH"
eval "`fnm env`"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
