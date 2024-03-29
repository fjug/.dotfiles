export PS1="\u@\h:\w$ "
export DOTFILES="$HOME/.dotfiles"

# use vi commands for advanced editing (hit ESC to enter command mode)
set -o vi

alias ll='ls -l'
alias la='ls -la'

alias go='cwd'
alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias today='date "+%Y-%m-%d %H:%M (%A)"'
alias preview='open -a /Applications/Preview.app'

alias cdgit='cd ~/GIT/'

# Install my bash completion scripts
. $DOTFILES/bash_completions/cwd.sh

# My own istallations go first...
export PATH=~/bin:$HOME/miniconda3/bin:$PATH

# Set color scheme...
export CLICOLOR=1
# export LSCOLORS=ExFxCxDxBxegedabagacad
export LSCOLORS=dxfxcxdxbxegedabagacad

# Set color codes for echo and print...
export BLACK=$(tput setab 0)
export RED=$(tput setab 1)
export GREEN=$(tput setab 2)
export YELLOW=$(tput setab 3)
export BLUE=$(tput setab 4)
export MAGENTA=$(tput setab 5)
export CYAN=$(tput setab 6)
export WHITE=$(tput setab 7)
export black=$(tput setaf 0)
export red=$(tput setaf 1)
export green=$(tput setaf 2)
export yellow=$(tput setaf 3)
export blue=$(tput setaf 4)
export magenta=$(tput setaf 5)
export cyan=$(tput setaf 6)
export white=$(tput setaf 7)
export bold=$(tput bold)
export dim=$(tput dim)
export NC=$(tput sgr0)
export nocolor=$NC

# GIT auto complete
if [ -f /opt/local/etc/bash_completion ]; then
   . /opt/local/etc/bash_completion
fi
. $DOTFILES/.git-prompt.sh
alias prompt-git="export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]\$(__git_ps1 \" (%s)\")\[\033[00m\]\$ '"
alias prompt-nogit="export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"
prompt-git

# Save and recall working directories + automation at each prompt
# ---------------------------------------------------------------
function swd {
	if [ $# -eq 0 ]; then
		pwd > ~/.dotfiles/cwd/.cwd
	else
		pwd > ~/.dotfiles/cwd/.cwd$1
	fi
}
function cwd {
	if [ $# -eq 0 ]; then
		cd $(cat ~/.dotfiles/cwd/.cwd)
	else
		cd $(cat ~/.dotfiles/cwd/.cwd$1)
	fi
}
function dwd {
	if [ $# -ne 0 ]; then
		rm ~/.dotfiles/cwd/.cwd$1
	fi
}
function lwd {
	TMPCWD=$( pwd )
	cd ~/.dotfiles/cwd/
	for file in .cwd*; do (printf "$blue%-20s$nocolor" "${file:4}" && printf "$yellow%s$nocolor\n" "$(cat $file)") done
	cd $TMPCWD
}
function lwd_names {
	TMPCWD=$( pwd )
	cd ~/.dotfiles/cwd/
	for file in .cwd*; do (printf "%s " "${file:4}") done
	cd $TMPCWD
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

