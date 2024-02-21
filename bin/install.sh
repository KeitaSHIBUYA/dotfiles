#!/bin/zsh

# dotfiles/ で実行すること
DOTFILES_DIR=./

echo "Starting to create symbolic links for dotfiles..."

# "."から始まるファイルをシンボリックリンク
for file in $(find $DOTFILES_DIR -name ".*" -type f); do
  ln -snf $file ~/ || exit 1
done

# iceberg.vimをシンボリックリンク
mkdir -p ~/.vim/colors || exit 1
ln -snf $DOTFILES_DIR/.vim/colors/iceberg.vim ~/.vim/colors/ || exit 1

echo "Successfully created symbolic links for dotfiles."
