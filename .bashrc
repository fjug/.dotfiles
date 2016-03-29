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

alias myers7='ssh -Y jug@myers-pc-7.mpi-cbg.de'
alias cdlabbook='cd ~/Dropbox/WorkingData/MPI/LabBook/'
alias cdgit='cd ~/Repositories/GIT/'

alias dropbox='/Users/jug/Repositories/GIT/Dropbox-Uploader/dropbox_uploader.sh'

# Install my bash completion scripts
. ~/.dotfiles/bash_completions/cwd.sh

# My own istallations go first...
export PATH=~/bin:/usr/local/texlive/2013/bin/x86_64-darwin:/usr/local/bin:/Users/jug/Qt5.2.0/5.2.0/clang_64/bin:$PATH

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

# NEST setup (to be able to create modules)
# export NEST_INSTALL_DIR=/usr/local
# export DYLD_LIBRARY_PATH=$NEST_INSTALL_DIR/lib/nest
# export PYTHONPATH=/Users/fjug/ETH/Arbeitsthemen/Neuroinformatics/NeuroGIT/InteractiveFFI/src
# export MACOSX_DEPLOYMENT_TARGET=10.6

# C/C++ compiler std setup
export CXXFLAGS="-O3 -march=core2 -mtune=native -ffast-math" 
export CFLAGS="-O3 -march=core2 -mtune=native -ffast-math"
export LDFLAGS="-L/opt/local/lib"

# VIGRA (for Kausler)
export VIGRA_NUMPY_CORE_LIBRARY='/Users/jug/local/vigra/vigranumpy/lib'

# JAVA HOME
# export JAVA_6_HOME=$(/usr/libexec/java_home -v1.6)
export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)

# alias java6='export JAVA_HOME=$JAVA_6_HOME'
alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'

# default java8
export JAVA_HOME=$JAVA_8_HOME

# for Jan's sbmrm
export Gurobi_ROOT_DIR="/Library/gurobi605/mac64"

# MotherMachine batch stuff
export MM_HOME='/Users/jug/local/MotherMachine'
export PATH=$MM_HOME:$PATH
export KNIME_HOME=/Applications/KNIME\ 2.11.2

# Gurobi
export PATH=/Library/gurobi605/mac64/bin:$PATH
export GUROBI_HOME=/Library/gurobi605/mac64
export LD_LIBRARY_PATH=/Library/gurobi605/mac64/lib:$LD_LIBRARY_PATH

# Corinna's Stuff
export CB_HUNGARIAN_LIB=/Users/jug/Repositories/GIT/MLT/MLT_PreProcessing/HungarianMatching_Code/build/Debug
export CB_HUNGARIAN_INC=/Users/jug/Repositories/GIT/MLT/MLT_PreProcessing/HungarianMatching_Code/inc
export PATH=$PATH:/Users/jug/Repositories/GIT/MLT/MLT_PreProcessing/MLT_Processing/bin/Debug

# CUDA
export PATH=/Developer/NVIDIA/CUDA-6.5/bin:$PATH
export DYLD_LIBRARY_PATH=/Developer/NVIDIA/CUDA-6.5/lib:$DYLD_LIBRARY_PATH

# homebrew github token
export HOMEBREW_GITHUB_API_TOKEN=3659bdb51539015fbfd812a794ec1e497a0f136a

# GIT auto complete
if [ -f /opt/local/etc/bash_completion ]; then
   . /opt/local/etc/bash_completion
fi
. ~/.dotfiles/.git-prompt.sh
alias prompt-git="export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;35m\]\$(__git_ps1 \" (%s)\")\[\033[00m\]\$ '"
alias prompt-nogit="export PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '"
prompt-git

# Fiji startup using Java8
alias fiji7='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --java-home /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/'
alias fiji8='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --java-home /Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/'
alias fiji=fiji7

# MyRepos (mr)
export PATH=~/local/myrepos/:$PATH

# Tab and window renaming
function tabname {
	printf "\e]1;$1\a"
}
function winname {
	printf "\e]2;$1\a"
}
function fixname {
	unset PROMPT_COMMAND
}
function getgitbranch {
	if [ "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" != "" ]; then 
	 	echo "($(git rev-parse --abbrev-ref HEAD 2>/dev/null))";
	fi;
}
function flexname {
	local NEW_PROMPT_COMMAND='tabname "$(basename $(pwd)) $(getgitbranch)"'
	PROMPT_COMMAND="update_terminal_cwd;$NEW_PROMPT_COMMAND"
}
flexname

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

export PROMPT_COMMAND="$PROMPT_COMMAND;swd"

# The stuff that was in .profiles
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
VIRTUAL_ENV_DISABLE_PROMPT=1 source /Users/jug/Library/Enthought/Canopy_64bit/User/bin/activate

# ILASTIK STUFF
# export BUILDEM_DIR="/Users/jug/local/ilastik"
# export CLASSPATH=$BUILDEM_DIR/Frameworks/Python.framework/Versions/2.7/lib/jep:$CLASSPATH
# alias ilastikenv="source $BUILDEM_DIR/bin/setenv_ilastik_gui.sh"
# source $BUILDEM_DIR/bin/setenv_ilastik_gui.sh
# export PATH="/Users/jug/local/miniconda/bin:$PATH"

# AT THE END: make PATH of any spotlight started app be the same as my bash PATH
launchctl setenv PATH $PATH 

