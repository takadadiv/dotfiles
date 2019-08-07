#!/bin/bash

set -eu

echo 'シンボリックリンク作成'
for file in .??*; do
    [ "$file" = '.git' ] && continue
    [ "$file" = '.gitignore' ] && continue
    [ "$file" = '.DS_Store' ] && continue
    ln -snvf "$PWD/$file" "$HOME/$file"
done

echo
echo 'Homebrewインストール'

if ! which brew > /dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo 'インストール済みでした'
fi

echo
echo 'Brewfileのソフトインストール'

brew bundle && :

if [ "$SHELL" != '/usr/local/bin/zsh' ]; then
    echo
    echo 'ログインシェルをzshに変更'
    echo /usr/local/bin/zsh | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
fi
