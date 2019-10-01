# ******************************************************************************
# autoload
# ******************************************************************************

# auto complement
autoload -Uz compinit && compinit
# color
autoload -Uz colors && colors
# git
autoload -Uz vcs_info

# ******************************************************************************
# prompt
# ******************************************************************************

PROMPT='%{${fg[cyan]}%}%n@%m%{${reset_color}%}${vcs_info_msg_0_} %~
%# '

# color display
zstyle ':completion:*' list-colors "${LS_COLORS}"
# select with cursor
zstyle ':completion:*:default' menu select=1
# git
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd() {
    vcs_info
    [ -n "$vcs_info_msg_0_" ] && vcs_info_msg_0_=" $vcs_info_msg_0_"
}

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=10000

# ******************************************************************************
# options
# ******************************************************************************

setopt ignore_eof
setopt hist_ignore_all_dups
setopt share_history
setopt auto_menu
setopt auto_cd
setopt auto_list
setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_param_slash
setopt interactive_comments
setopt list_types
setopt list_packed
setopt mark_dirs
setopt prompt_subst
setopt print_exit_value
setopt prompt_subst

# ******************************************************************************
# path
# ******************************************************************************

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"
export MANPATH

# ******************************************************************************
# alias
# ******************************************************************************

cdls() {
  \cd "$@" && ls
}

alias cd='cdls'
alias ...='cd ../..'
alias ....='cd ../../..'
alias dirs='dirs -v'

alias ls='ls --color=auto'
alias la='ls -al'
alias ll='ls -al'
alias tree='tree -CN'
alias df='df -h'

alias pa='php artisan'

# git
alias g='git'
alias gs='git status'
alias gl='git log'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias mygit='git config --local user.name "takadadiv" && git config --local user.email "takadadiv@gmail.com"'

# docker
alias d='docker'
alias dc='docker container'
alias di='docker image'
alias dn='docker network'
alias dv='docker volume'
alias dcp='docker-compose'
alias dcpe='docker-compose exec'
alias ds='docker-sync'
alias dss='docker-sync-stack'
alias dpuml='docker container run -d -p 8080:8080 plantuml/plantuml-server:jetty'
alias dphp='docker-compose exec php'
alias dmysql='docker-compose exec mysql mysql -u laravel -D laravel -psecret'

# ******************************************************************************
# zplug
# ******************************************************************************

ZPLUG_HOME=/usr/local/opt/zplug
source "$ZPLUG_HOME/init.zsh"

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# install plugin
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ******************************************************************************
# others
# ******************************************************************************

# direnv
eval "$(direnv hook zsh)"

# gcp
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
