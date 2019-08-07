# ******************************************************************************
# オートロードと実行
# ******************************************************************************

# 補完
autoload -Uz compinit && compinit
# カラー変更
autoload -Uz colors && colors
# git情報
autoload -Uz vcs_info

# ******************************************************************************
# プロンプト
# ******************************************************************************

PROMPT='%{${fg[cyan]}%}%n@%m%{${reset_color}%}${vcs_info_msg_0_} %~
%# '

# 補完候補をカラー表示
zstyle ':completion:*' list-colors "${LS_COLORS}"
# 選択候補をカーソル選択できるようにする
zstyle ':completion:*:default' menu select=1
# git情報
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd() {
    vcs_info
    [ -n "$vcs_info_msg_0_" ] && vcs_info_msg_0_=" $vcs_info_msg_0_"
}

# ヒストリー
HISTFILE=~/.zsh_history      # ヒストリーファイルの場所
HISTSIZE=10000               # ヒストリー保存する数
SAVEHIST=10000               # ヒストリーファイルに保存する数

# ******************************************************************************
# オプション
# ******************************************************************************

setopt ignore_eof            # ctrl+dでzshを終了させない
setopt hist_ignore_all_dups  # 同コマンドは履歴に残さない
setopt share_history         # 履歴を他のzshと共有
setopt auto_menu             # タブで補完候補を表示
setopt auto_cd               # ディレクトリ名でcd
setopt auto_list             # 補完候補を一覧表示
setopt auto_pushd            # cd時、自動でpushd
setopt pushd_ignore_dups     # 同じディレクトリはスタックしない
setopt auto_param_slash      # ディレクトリ名の補完で末尾に/を付加
setopt interactive_comments  # コマンドラインで#以降をコメントとみなす
setopt list_types            # 候補にファイル種別を表示
setopt list_packed           # 補完結果を詰めて表示
setopt mark_dirs             # ファイル名展開時、ディレクトリは末尾に/を付加
setopt prompt_subst          # プロンプト定義内で変数置換やコマンド置換する
setopt print_exit_value      # 戻り値が0以外の場合終了コードを表示
setopt prompt_subst          # PROMPT変数の変数参照を展開

# ******************************************************************************
# PATH
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
# エイリアス
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

alias dpuml='docker run -d -p 8080:8080 plantuml/plantuml-server:jetty'
alias dphp='docker-compose exec php'
alias dmysql='docker-compose exec mysql mysql -u laravel -D laravel -psecret'

# ******************************************************************************
# Zplug
# ******************************************************************************

ZPLUG_HOME=/usr/local/opt/zplug
source "$ZPLUG_HOME/init.zsh"

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

# プラグインインストール
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# ******************************************************************************
# その他
# ******************************************************************************

# direnv
eval "$(direnv hook zsh)"

# GCP
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
