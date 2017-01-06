# Path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# themes [$ZSH/themes and $ZSH_CUSTOM]
ZSH_THEME="dumps"
# custom stuff [$ZSH/custom]
# ZSH_CUSTOM=$ZSH/custom

# formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# from $ZSH/plugins/ and $ZSH_CUSTOM/plugins/
plugins=(git colored-man-pages command-not-found zsh-syntax-highlighting zsh-history-substring-search)

## also loads $ZSH_CUSTOM/*.zsh
source $ZSH/oh-my-zsh.sh


## fix overcrowed hashed named directory
# unhash stuff that gets automatically added to named dirs (user homes etc.)
# only explicit "hash" + "per item unhash" works, otherwise allusersadded = 0
# in hashnameddir.c will not be set to 1, and stuff will magically be rehashed
hash -df # fully hash => allusersadded = 1
for DIR in $(hash -d); do # fully clear keeping allusersadded = 1
  unhash -d ${DIR%=*}
done;

## fix super slow zsh on sshfs mounted drives with git
# Problem is git plugin. Use git info only on non remote drives
# - Remote pwd :: https://coderwall.com/p/g2b3yg/disable-version-control-info-in-zsh-prompt-on-sshfs-mount
# - git_prompt_info :: http://marc-abramowitz.com/archives/2012/04/10/fix-for-oh-my-zsh-git-svn-prompt-slowness/
# overwrite git_prompt_info() in oh-my-zsh/lib/git.zsh to only execute on non-remote drive
function git_prompt_info() {
    local ref
    ## thackl
    if [[ `stat -f -L -c %T $PWD` == *fuseblk* ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX"git-na"$ZSH_THEME_GIT_PROMPT_SUFFIX"
        return 0;
    fi

    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
            ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}


## load some local configs
for CFG in ~/.path ~/.alias ~/.perl5lib ~/.python2lib; do
    [ -f "$CFG" ] && . "$CFG" || true
done;
