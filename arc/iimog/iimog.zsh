THIS=$(readlink -f ${ZDOTDIR-~}"/.zshrc")
CONFDIR="$( cd "$( dirname "$THIS" )" && pwd )"
export CONFDIR

zstyle ":completion:*:commands" rehash 1
setopt nobeep                  # i hate beeps
setopt noautomenu              # don't cycle completion
setopt autocd                  # change to dirs without cd
#setopt autopushd               # automatically append dirs to the push/pop list
setopt pushdignoredups         # and don't duplicate them
setopt cdablevars              # avoid the need for an explicit $
#setopt nocheckjobs             # don't warn me about bg processes when exiting
#setopt nohup                   # and don't kill them, either
#setopt listpacked              # compact completion lists
setopt nolisttypes             # show types in completion
#setopt dvorak                  # with spelling correction, assume dvorak kb
setopt extendedglob            # weird & wacky pattern matching - yay zsh!
#setopt completeinword          # not just at the end
setopt alwaystoend             # when complete from middle, move cursor
setopt correct                 # spelling correction
#setopt nopromptcr              # don't add \n which overwrites cmds with no \n
setopt histverify              # when using ! cmds, confirm first
setopt interactivecomments     # escape commands so i can use them later
setopt printexitvalue          # alert me if something's failed

# history related stuff.
export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=~/.zsh_history
setopt hist_ignore_dups        # ignore same commands run twice+
setopt appendhistory           # don't overwrite history
setopt share_history

# If running interactively, then:
if [[ -o interactive ]]; then
        autoload -U compinit
        compinit
        setopt PROMPT_SUBST


        if [[ -f `which vim` ]]; then
                export EDITOR="vim"
        elif [[ -f `which joe` ]]; then
                export EDITOR="joe"
        elif [[ -f `which nano` ]]; then
                export EDITOR="nano"
        else
                unset EDITOR
        fi

        export SVN_EDITOR=$EDITOR

        bindkey '^r' history-incremental-search-backward
        bindkey "^[[5~" up-line-or-history
        bindkey "^[[6~" down-line-or-history
        bindkey "^[[H" beginning-of-line
        bindkey "^[[1~" beginning-of-line
        bindkey "^[[F"  end-of-line
        bindkey "^[[4~" end-of-line
        bindkey ' ' magic-space    # also do history expansion on space
        bindkey '^I' complete-word # complete on tab, leave expansion to _expand
        bindkey "^[[3~" delete-char
	bindkey '^a' beginning-of-line
	bindkey '^e' end-of-line
	bindkey '^u' backward-kill-line
	bindkey '^k' kill-line
	bindkey "^[OH" beginning-of-line
	bindkey "^[OF" end-of-line
fi


autoload -U colors && colors

[[ -d "$HOME/bin" ]] && PATH="$PATH:$HOME/bin"
[[ -d "$HOME/build/bin" ]] && PATH="$PATH:$HOME/build/bin"
PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin
export PATH


#schadet nie...
[[ -x /usr/bin/setxkbmap ]] && setxkbmap de


test -s ~/.alias && . ~/.alias || true

if [ -f ~/.perl5.sh ]; then
	. ~/.perl5.sh
fi

export PATH=$HOME/bin:$PATH

# BC settings (especially scale)
export BC_ENV_ARGS=~/.bcrc

# Use more appealing colors
eval `dircolors $HOME/.dircolors`


[[ -f "$HOME/.zsh_local" ]] && . $HOME/.zsh_local

# [ -f "$CONFDIR/start-agent" ] && source $CONFDIR/start-agent

if [ -f "${HOME}/.gpg-agent-info" ]; then
	source  "${HOME}/.gpg-agent-info"
        export GPG_AGENT_INFO
        export SSH_AUTH_SOCK
fi

if [ -S "$SSH_AUTH_SOCK" ]; then
	echo ""
else
	eval $( gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")
fi

# Allow to list archive contents via less and use syntax highlighting
export LESS="-R"
eval $(lesspipe)

# enable history-substring-search
# bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
