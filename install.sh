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

###########
# tmux setup
###########

if [ ${os} == "mac" ]; then
  brew install tmux
elif [ ${os} == "linux" ]; then
  sudo apt install tmux
fi
cp .tmux.conf ~/.tmux.conf

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
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
  sudo dpkg -i ripgrep_11.0.2_amd64.deb
fi

###########
# zsh setup
###########

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc
cp .oh-my-zsh/themes/* ~/.oh-my-zsh/themes/

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc

############
## Vim setup
############

cp .vimrc ~/.vimrc

mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl --remote_name https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
cd -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

if [ ${os} == "mac" ]; then
  brew install cmake macvim
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer
  cd -
elif [ ${os} == "linux" ]; then
  sudo apt install build-essential cmake python3-dev
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --clang-completer
  cd -
fi

cp -r .vim/UltiSnips ~/.vim
