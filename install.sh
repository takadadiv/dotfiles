#!/bin/bash

# set -eu

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

echo
echo 'create symlink'
ln -snvf /usr/local/bin/g++-9 /usr/local/bin/g++

echo
echo 'copy stdc++.h'
mkdir -p /usr/local/include/bits && cp -fv /usr/local/Cellar/gcc/9.2.0_3/include/c++/9.2.0/x86_64-apple-darwin19/bits/stdc++.h $_

if [ "$SHELL" != '/usr/local/bin/zsh' ]; then
    echo
    echo 'change shell to zsh'
    echo /usr/local/bin/zsh | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/zsh
fi
