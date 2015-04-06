# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%B%(?..%{$fg[red]%}↵%?%{$reset_color%})%b"

# local curr_time="%{$terminfo[bold]$fg[red]%} %D{[%I:%M:%S]}%{$reset_color%}"
local user_host='%{$fg[cyan]%}%n@%m%{$fg[white]%}:'
local current_dir='%{$fg[white]%}%37<..<%B%{$fg[magenta]%}%~%<<%u'

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
#ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
local git_branch='$(git_prompt_info)'

#local curr_time="%{$fg[red]%}%B⌚ %b%{$fg[red]%}%D{%H:%M:%S}"
local curr_time="%{$fg[green]%}%D{%H:%M:%S}"

#%{$reset_color%
#PROMPT="${BG[235]}${user_host}:${current_dir} ${git_branch}
PROMPT="${user_host}${current_dir}%{$reset_color%}
"
[[ `id -u` = "0" ]] && PROMPT="${PROMPT}%{$fg[red]%}"
PROMPT="${PROMPT}$%b "
[[ `id -u` = "0" ]] && PROMPT="${PROMPT}%{$reset_color%}"

RPROMPT="%{$(echotc UP 1)%} ${return_code} ${git_branch} ${curr_time}""%{$(echotc DO 1)%}%{$reset_color%}"


# MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"
MODE_INDICATOR="%{$fg[magenta]%}[N]%{$reset_color%}"
I_MODE_INDICATOR="%{$fg[magenta]%}[I]%{$reset_color%}"
