#!/usr/bin/env bash
# Same as install.sh but skips some parts that I usually don't need when I'm
# downloading my dotfiles onto a remote machine.

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
  abort "Could not determine OS."
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

# Miscellaneous installations
if [ ${os} == "mac" ]; then
  brew install mosh
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install mosh
fi

###########
# fzf setup
###########

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

###############
# ripgrep setup
###############

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

RUNZSH=no bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp .zshrc ~/.zshrc
cp .oh-my-zsh/themes/* ~/.oh-my-zsh/themes/

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

##############
# bashrc setup
##############

# We set up bash in case we don't have permission to install zsh on the machine.
cp .bashrc ~/.bashrc

curl --output ~/.git.bash-plugin.sh https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/plugins/git/git.plugin.sh
printf "\nalias gds='git diff --staged'\n" >> ~/.git.bash-plugin.sh
printf "\nsource ~/.git.bash-plugin.sh\n" >> ~/.bashrc

printf "alias dk='docker'\n" >> ~/.bashrc
printf "alias dkc='docker-compose'\n" >> ~/.bashrc
printf "alias ta='tmux attach'\n" >> ~/.bashrc

curl --output ~/.ssh-find-agent.sh https://raw.githubusercontent.com/wwalker/ssh-find-agent/master/ssh-find-agent.sh
printf ". ~/.ssh-find-agent.sh\nssh_find_agent -a || eval \$(ssh-agent) > /dev/null\n" >> ~/.bashrc

############
## Vim setup
############

# Update vim to get useful support like clipboard and clientserver
if [ ${os} == "mac" ]; then
  brew install vim
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install vim-gtk
fi

cp .vimrc-remote ~/.vimrc

mkdir -p ~/.vim/colors
cd ~/.vim/colors
curl --remote-name https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim
cd -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

###########
# tmux setup
###########

if [ ${os} == "mac" ]; then
  brew install tmux
elif [ ${os} == "linux" ]; then
  sudo apt --assume-yes install tmux
fi
cp .tmux.conf ~/.tmux.conf

###########
# git setup
###########

git config --global user.name "Tom Tseng"
git config --global user.email "tom.hm.tseng@gmail.com"
git config --global core.editor "vim"
