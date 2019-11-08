# dotfiles

インストール

```
$ ./install.sh
```

Brewfile書き出し

```
$ brew bundle dump --force
```

Brewfileにないパッケージをアンインストール

```
$ brew bundle cleanup --force
```

# homebrew

インストール・アンインストール・確認

```
$ brew install <name>
$ brew uninstall <name>
$ brew list
```

アップデート

```
$ brew update # 本体のみ
$ brew upgrade # 本体+パッケージ
```

パッケージの検索・情報表示

```
$ brew search <name>
$ brew info <name>
```

ヘルプ系

```
$ brew commands
$ brew help
$ brew help <command>
$ man brew
```

リポジトリの追加・削除・確認

```
$ brew tap <user>/<repo>
$ brew untap <user>/<repo>
$ brew tap
```

 # cask

 `brew cask <command>`とするだけ

 ```
$ brew cask install <name>
$ brew cask help
 ```
