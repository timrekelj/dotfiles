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

# CARGO
unset rc
. "$HOME/.cargo/env"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
