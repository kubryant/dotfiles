if [ $UID -eq 0 ]; then CARETCOLOR="yellow"; else CARETCOLOR="red"; fi

local return_code="%(?..%{$fg[yellow]%}%? ↵%{$reset_color%})"

PROMPT='%{${fg_no_bold[cyan]}%}%n %{$reset_color%}%{${fg[blue]}%}%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%} '

RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
