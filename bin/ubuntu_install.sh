#!/bin/bash

# zshがインストールされているかチェック
if ! command -v zsh &> /dev/null; then
    echo "zsh is not installed. Would you like to install it now? (y/n)"
    while true; do
        read -r answer
        case $answer in
            [Yy]* ) 
                sudo apt-get update || exit 1
                sudo apt-get install -y zsh || exit 1
                break;;
            [Nn]* ) 
                echo "zsh installation skipped."
                break;;
            * ) 
                echo "Please answer 'y' or 'n'.";;
        esac
    done
else
    echo "zsh is already installed."
fi

# デフォルトシェルをzshに切り替え
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "Switching default shell to zsh..."
    chsh -s /bin/zsh || exit 1
    echo "You may need to log out and log back in for the changes to take effect."
else
    echo "Default shell is already zsh."
fi

# starshipがインストールされているかチェック
if ! command -v starship &>/dev/null; then
    echo "starship is not installed. Would you like to install it now? (y/n)"
    while true; do
        read -r answer
        case $answer in
            [Yy]* ) 
                curl -sS https://starship.rs/install.sh || exit 1
                # echo 'eval "$(starship init zsh)"' >> ~/.zshrc    # .zshrcに記述済み
                break;;
            [Nn]* ) 
                echo "starship installation skipped."
                break;;
            * ) 
                echo "Please answer 'y' or 'n'.";;
        esac
    done
else
    echo "starship is already installed."
fi


## シンボリックリンクを作成
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

# ~/.condfig/ に starship.toml をシンボリックリンク
mkdir -p ~/.config || exit 1
ln -snf $DOTFILES_DIR/.config/starship.toml ~/.config/ || exit 1

echo "Successfully created symbolic links for dotfiles."
