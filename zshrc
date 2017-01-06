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

## unhash stuff that gets automatically added to named dirs (user homes etc.)
## only explicit "hash" + "per item unhash" works, otherwise allusersadded = 0
## in hashnameddir.c will not be set to 1, and stuff will magically be rehashed
hash -df # fully hash => allusersadded = 1
for DIR in $(hash -d); do # fully clear keeping allusersadded = 1
  unhash -d ${DIR%=*} 
done;

for CFG in ~/.path ~/.alias ~/.perl5lib ~/.python2lib; do
    [ -f "$CFG" ] && . "$CFG" || true
done;

