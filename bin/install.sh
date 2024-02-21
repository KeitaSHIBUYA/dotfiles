#!/bin/zsh

# dotfiles/ のパスを DOTFILES_DIR に代入
DOTFILES_DIR=`pwd`

echo "Starting to create symbolic links for dotfiles..."

# "."から始まるファイルをシンボリックリンク
# .DS_Store と .gitignore は除外
for file in $(find $DOTFILES_DIR -name ".*" -type f | grep -v -e "\.DS_Store$" -e "\.gitignore$"); do
  ln -snf $file ~/
done

# iceberg.vimをシンボリックリンク
mkdir -p ~/.vim/colors || exit 1
ln -snf $DOTFILES_DIR/.vim/colors/iceberg.vim ~/.vim/colors/ || exit 1

echo "Successfully created symbolic links for dotfiles."
