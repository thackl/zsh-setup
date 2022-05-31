#!/usr/bin/env bash
OMZ=~/.oh-my-zsh
SYN=$OMZ/custom/plugins/zsh-syntax-highlighting
USR=dumps

hash zsh || { echo "Make sure zsh is installed and in PATH" 1>&2; exit; }

# download oh-my-zsh
if [ ! -d "$OMZ" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $OMZ
fi

if [ ! -d "$SYN" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $SYN
fi

# deploy confs
[ -e ~/.zshrc ] && { cp ~/.zshrc ~/.zshrc.bak; }
cp zshrc ~/.zshrc
cp $USR.zsh $USR.zsh-theme $OMZ/custom/.
