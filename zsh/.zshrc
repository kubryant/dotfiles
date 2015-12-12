# exports
export ZSH=~/.oh-my-zsh
export EDITOR=vim
export SHELL=/bin/zsh

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

alias vim='/usr/local/Cellar/vim/7.4.884/bin/vim'
alias vimgit='vim $(git status --porcelain | sed -ne "s/^ M //p")'

function zFind {
  find $(pwd) -name $1
}

# start
clear
