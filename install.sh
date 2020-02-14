#!/usr/bin/env bash

abort() {
  local msg=${1}
  echo ${msg}
  echo "Aborting."
  exit 1
}

if [ "$(uname)" == "Darwin" ]; then
  os="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then # Linux
  os="linux"
else
  abort "Could not determine OS. Aborting."
fi

#######################
# Package manager setup
#######################

if [ ${os} == "mac" ]; then
  # Install brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes update
  sudo apt --assume-yes upgrade
fi

###########
# fzf setup
###########

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

###########
# ripgrep setup
###########

if [ ${os} == "mac" ]; then
  brew install ripgrep
elif [ ${os} == "linux" ]; then
  curl --location --remote-name https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
  sudo dpkg --install ripgrep_11.0.2_amd64.deb
  rm ripgrep_11.0.2_amd64.deb
fi

###########
# zsh setup
###########

if [ ${os} == "mac" ]; then
  brew install zsh zsh-completions
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install zsh
fi
chsh -s $(which zsh)

bash -c "$(RUNZSH=no curl --fail --silent --show-error --location https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc
cp .oh-my-zsh/themes/* ~/.oh-my-zsh/themes/

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

############
## Vim setup
############

# Update vim to get useful support like clipboard and clientserver
if [ ${os} == "mac" ]; then
  brew install vim
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install vim-gtk
fi

cp .vimrc ~/.vimrc

mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl --remote-name https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
cd -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ ${os} == "mac" ]; then
  brew install cmake macvim
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer
  cd -
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install build-essential cmake python3-dev
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --clang-completer
  cd -
fi

cp -r .vim/UltiSnips ~/.vim

###########
# tmux setup
###########

if [ ${os} == "mac" ]; then
  brew install tmux
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install tmux
fi
cp .tmux.conf ~/.tmux.conf
