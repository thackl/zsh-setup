# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# local curr_time="%{$terminfo[bold]$fg[red]%} %D{[%I:%M:%S]}%{$reset_color%}"
local curr_time="%{$fg[cyan]%} %D{[%H:%M:%S]}%{$reset_color%}"
local user_host='%{$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$fg[blue]%} %~%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

function _vi_status() {
  echo "${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/$I_MODE_INDICATOR}"
# if {echo $fpath | grep -q "plugins/vi-mode"}; then
#   echo "$(vi_mode_prompt_info)"
# fi
}

PROMPT="╭─${user_host} ${curr_time} ${current_dir} ${rvm_ruby}
╰─%B"
[[ `id -u` = "0" ]] && PROMPT="${PROMPT}%{$fg[red]%}"
PROMPT="${PROMPT}$%b "
[[ `id -u` = "0" ]] && PROMPT="${PROMPT}%{$reset_color%}"

RPROMPT="%{$(echotc UP 1)%}${git_branch}${return_code}"'$(_vi_status)'"%{$(echotc DO 1)%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

# MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"
MODE_INDICATOR="%{$fg[magenta]%}[N]%{$reset_color%}"
I_MODE_INDICATOR="%{$fg[magenta]%}[I]%{$reset_color%}"