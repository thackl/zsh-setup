#!/usr/bin/env bash
OMZ=~/.oh-my-zsh
USR=dumps

hash zsh || { echo "Make sure zsh is installed and in PATH" 1>&2; exit; }

# download oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git $OMZ
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $OMZ/custom/plugins/zsh-syntax-highlighting

# deploy confs
[ -e ~/.zshrc ] && { cp ~/.zshrc ~/.zshrc.bak; }
cp zshrc ~/.zshrc
cp $USR.zsh $USR.zsh-theme $OMZ/custom/.
