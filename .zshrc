# Path to your oh-my-zsh installation.
export ZSH=/Users/jug/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(z git brew history history-substring-search colored-man-pages colorize cp dirpersist vi-mode vundle gradle mercurial mvn pip python osx textmate themes)

# User configuration

export PATH="/Developer/NVIDIA/CUDA-6.5/bin:/Library/gurobi702/mac64/bin:/Users/jug/bin:/usr/local/texlive/2013/bin/x86_64-darwin:/usr/local/bin:/Users/jug/Qt5.2.0/5.2.0/clang_64/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Library/TeX/texbin"

# Canopy python
# export PATH=/Users/jug/Library/Enthought/Canopy_64bit/User/bin:$PATH

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim='/usr/local/bin/vim'

# Fiji startup using Java8
alias fiji7='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --java-home /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/'
alias fiji8='/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx --java-home /Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/'
alias fiji=fiji8

# Convenient history searched reverse and forward
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

# JAVA HOME
# export JAVA_6_HOME=$(/usr/libexec/java_home -v1.6)
export JAVA_7_HOME=$(/usr/libexec/java_home -v1.7)
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)

# alias java6='export JAVA_HOME=$JAVA_6_HOME'
alias java7='export JAVA_HOME=$JAVA_7_HOME'
alias java8='export JAVA_HOME=$JAVA_8_HOME'

# default java8
export JAVA_HOME=$JAVA_8_HOME

# Gurobi
export PATH=/Library/gurobi702/mac64/bin:$PATH
export GUROBI_HOME=/Library/gurobi702/mac64
export LD_LIBRARY_PATH=/Library/gurobi702/mac64/lib:$LD_LIBRARY_PATH

# MoMA
export MM_HOME=/Users/jug/local/MotherMachine

# LaTeX-diff
function git-latexdiff {    
    if [[ $# != 2 ]];    
    then      
        printf "\tusage: git-latexdiff <file> <back-revision>  \n";    
    elif [[ $2 -lt 0 ]];     
    then     
        printf "\t<Back-revision> must be positive\n";   
    else      
        dire=$(dirname $PWD/$1);      
        based=$(git rev-parse --show-toplevel);      
        git show HEAD~$2:$(echo $dire| sed 's!'$(echo $based)'/!!')/$1 > $1_diff.tmp;      
        latexdiff $1 $1_diff.tmp > $1_diff.tex;      
        pdflatex $1_diff.tex;     
        okular $1_diff.pdf;      
        rm $1_diff*;   
    fi; 
}
