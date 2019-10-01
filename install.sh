#!/bin/bash

set -eu

echo 'create symlink'
for file in .??*; do
    [ "$file" = '.git' ] && continue
    [ "$file" = '.gitignore' ] && continue
    [ "$file" = '.DS_Store' ] && continue
    ln -snvf "$PWD/$file" "$HOME/$file"
done

echo
echo 'install homebrew'

if ! which brew > /dev/null 2>&1; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo 'already installed'
fi

echo
echo 'install apps in brewfile'

brew bundle && :

if [ "$SHELL" != '/usr/local/bin/zsh' ]; then
    echo
    echo 'change shell to zsh'
    echo /usr/local/bin/zsh | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
fi
