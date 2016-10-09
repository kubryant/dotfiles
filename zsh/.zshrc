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

# oh-my-zsh
ZSH_THEME="bryant"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="mm/dd/yyyy"
plugins=(gitfast git-extras npm brew encode64 httpie web-search)
source $ZSH/oh-my-zsh.sh

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fbr - checkout git branch (including remote branches)
function fbr {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" | fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fd - cd to selected directory
function fd {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf-tmux +m) &&
  cd "$dir"
}

# fda - including hidden directories
function fda {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf-tmux +m) && cd "$dir"
}

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
}

# start
clear
