export PATH=/opt/homebrew/bin:$PATH

# License : MIT
# http://mollifier.mit-license.org/
 
########################################
# 環境変数
export LANG=ja_JP.UTF-8
 
# 色を使用出来るようにする
autoload -Uz colors
colors
 
# emacs 風キーバインドにする
bindkey -e
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 改変箇所_1
# 時間表記の追加
setopt extended_history
alias history='history -t "%F %T"'

# プロンプト
# 1行表示
# PROMPT="%~ %# "

# 改変箇所_2
PROMPT="%{${fg[blue]}%}%n:%{${reset_color}%} %c/ %# "
# 2行表示
# PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
# %# " 

# 改変箇所_3
# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'
 
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
 
########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
 
########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
 
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
 
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg
 
########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# beep を無効にする
setopt no_beep
 
# フローコントロールを無効にする
setopt no_flow_control
 
# Ctrl+Dでzshを終了しない
setopt ignore_eof
 
# '#' 以降をコメントとして扱う
setopt interactive_comments
 
# ディレクトリ名だけでcdする
setopt auto_cd
 
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 高機能なワイルドカード展開を使用する
setopt extended_glob
 
########################################
# キーバインド
 
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
########################################
# エイリアス
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
 
alias mkdir='mkdir -p'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
 
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
 
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
 
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# vim:set ft=zsh:


#=============================
# source zsh-syntax-highlighting
#=============================
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#=============================
# source zsh-autosuggestions
#=============================
if [ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

#=============================
# source zsh-completions
#=============================
if [ -f ~/.zsh/zsh-completions/zsh-completions.zsh ]; then
  source ~/.zsh/zsh-completions/zsh-completions.zsh
fi

#=============================
# source zsh-history-substring-search
#=============================
if [ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

#=============================
# source spaceship-prompt
#=============================
if [ -f ~/.zsh/spaceship-prompt/spaceship-prompt.zsh ]; then
  source ~/.zsh/spaceship-prompt/spaceship-prompt.zsh
fi



export LSCOLORS=cxfxcxdxbxegedabagacad

### ここからエイリアス
# alias ls='ls -GF'     # 元々これだった
alias list='ls'
alias l='exa --icons'
alias la='exa -a --icons'
alias ll='exa --header --git --time-style=long-iso -agl'
alias li='exa --icons -T -L 2 -a'

### batコマンドをcatにエイリアス
alias cat=bat

# autoload -U promptinit; promptinit
# prompt pure
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"

### gitエイリアス
alias g="git"
alias gg="git la"
alias push="git push origin HEAD"
alias pull="git pull -p"
alias mkpr="git push origin HEAD && gh pr create && gh pr view --web"
alias t="tig"
alias ta="tig --all"
alias gr='anyframe-widget-cd-ghq-repository'
alias gc='anyframe-widget-checkout-git-branch'
alias gd='delete-branch-incremental-search'
alias pr='gh pr list | fzf | awk '\''{$1=$1};1'\'' | sed -e '\''s/ .*//'\'' | {read n} && gh pr view $n -w'

### docker エイリアス
alias d="docker"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/shibuya.keita/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/shibuya.keita/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/shibuya.keita/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/shibuya.keita/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# cloud-sql-proxy のエイリアス
# alias cloud_sql_proxy="/opt/homebrew/share/google-cloud-sdk/bin/cloud_sql_proxy"
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"


### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/shibuya.keita/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# znap
# source ~/app/zsh-snap/znap.zsh
# znap source marlonrichert/zsh-autocomplete


. /opt/homebrew/opt/asdf/libexec/asdf.sh

TIMEFMT=$'\n\n========================\nProgram : %J\nCPU     : %P\nuser    : %*Us\nsystem  : %*Ss\ntotal   : %*Es\n========================\n'

# tfenv
export PATH=$PATH:[パス]/.tfenv/bin

# terraform エイリアス
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'

export CLOUDSDK_PYTHON_SITEPACKAGES=1

# 画面解像度 出力コマンド
alias resolution='system_profiler SPDisplaysDataType G Resolution'

# Go のパスを通す
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

export PATH="/opt/homebrew/opt/curl/bin:$PATH"
source "$HOME/.rye/env"

# Pub/Sub
export PROJECT_ID="ca-shibuya-srestudy-native"
export TOPIC_NAME="crossing"

