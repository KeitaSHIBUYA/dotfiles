#!/bin/zsh

DOTFILES_DIR=~/github.com/KeitaSHIBUYA/dotfiles

echo "Starting to create symbolic links for dotfiles..."

# "."から始まるファイルをシンボリックリンク
for file in $(find $DOTFILES_DIR -name ".*" -type f); do
  ln -snf $file ~/
done

# iceberg.vimをシンボリックリンク
mkdir -p ~/.vim/colors
ln -snf $DOTFILES_DIR/.vim/colors/iceberg.vim ~/.vim/colors/

echo "Successfully created symbolic links for dotfiles."
