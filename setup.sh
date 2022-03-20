# Install brew if not installed
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Install 'thefuck' since zshrc otherwise coughs up an error later...
brew install thefuck

# manually clone all the sub-git-repos needed...
git clone https://github.com/ohmyzsh/ohmyzsh.git .oh-my-zsh
cd .vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git
git clone https://github.com/preservim/nerdcommenter.git
git clone https://github.com/vim-airline/vim-airline.git
git clone https://github.com/tpope/vim-sensible.git

# put self-modded files in place...
ln -s ~/.dotfiles/modded_files/bira_conda.zsh-theme ~/.dotfiles/.oh-my-zsh/themes/bira_conda.zsh-theme

# soft link all we need to $HOME
cd
ln -s .dotfiles/.bashrc .bashrc
ln -s .dotfiles/.bash_login .bash_login
ln -s .dotfiles/.zshrc .zshrc
ln -s .dotfiles/.oh-my-zsh .oh-my-zsh
ln -s .dotfiles/.vim .vim
ln -s .dotfiles/.vimrc .vimrc
ln -s .dotfiles/.inputrc .inputrc
ln -s .dotfiles/.gitconfig .gitconfig
