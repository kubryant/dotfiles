# exports
export ZSH=~/.oh-my-zsh
export EDITOR=vim
export SHELL=/bin/zsh

# nvm
export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh
# nvm use v0.12.7
# Base16 Theme
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Oh-my-zsh settings
ZSH_THEME="bryant"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(gitfast git-extras npm brew encode64 httpie web-search)

source $ZSH/oh-my-zsh.sh

# bind keys
bindkey '\e[1~'   beginning-of-line
bindkey '\e[H'    beginning-of-line
bindkey '\eOH'    beginning-of-line
bindkey '\e[3~'   delete-char
bindkey '\e[4~'   end-of-line
bindkey '\e[F'    end-of-line
bindkey '\eOF'    end-of-line
bindkey '^R'      history-incremental-search-backward

# command alias
alias ll='ls -lah'

alias vms='VBoxManage list runningvms'

alias vimgm='vim $(git status --short | sed -ne "s/^ *M //p")'
alias vimgc='vim $(git status --short | sed -ne "s/^ *UU //p")'
alias ag='ag --color-path="1;36"'
alias loc='find . -name "*.js" | xargs wc -l'

alias gbd='gb -D $(gb) 2>/dev/null'
alias gstl='git stash list | cat'
alias gsts='git stash save'
alias gdf='git diff master --name-status | sed -ne "s/^[A|M].//p"'
alias gpo='git push --set-upstream origin $(git symbolic-ref HEAD 2> /dev/null | sed -ne "s/^refs\/heads\///p")'
alias greset='grhh && gclean; gcb hello && gbd; gcm && gl && gbd && gfa'
function f {
  find $(pwd) -name $1 2>/dev/null
}

# start
clear
