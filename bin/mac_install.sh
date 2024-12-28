#!/bin/zsh

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

# Homebrewがインストールされているかチェック
if ! command -v brew &>/dev/null; then
    echo "Homebrew is not installed. Would you like to install it now? (y/n)"
    while true; do
        read -r answer
        case $answer in
            [Yy]* ) 
                curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh || exit 1
                break;;
            [Nn]* ) 
                echo "Homebrew installation skipped."
                break;;
            * ) 
                echo "Please answer 'y' or 'n'.";;
        esac
    done
else
    echo "Homebrew is already installed."
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

# CI 実行時はここまでで終了する
# ユーザ入力を待機し、"y" の入力があれば正常終了する
while true; do
    echo "Would 'not' you like to install Homebrew packages? (y/n)"
    read -r answer
    case $answer in
        [Yy]* ) exit 0;;
        [Nn]* ) break;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done

# Brewfile から brew bundle を実行
cd ~
brew update
brew upgrade
brew bundle --global
