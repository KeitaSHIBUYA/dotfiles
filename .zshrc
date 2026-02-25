########################################
# default
########################################

export PATH=/opt/homebrew/bin:$PATH
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

# 時間表記の追加
setopt extended_history
alias history='history -t "%F %T"'

# プロンプトは Starship が管理（初期化は後述）

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

autoload -Uz add-zsh-hook

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



#=============================
# source zsh-autosuggestions
#=============================
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

FPATH=/opt/homebrew/share/zsh-completions:$FPATH

#=============================
# source anyframe
# Install: git clone https://github.com/mollifier/anyframe ~/.zsh/anyframe
#=============================
if [ -d ~/.zsh/anyframe ]; then
  fpath=(~/.zsh/anyframe(N-/) $fpath)
fi

autoload -Uz compinit
_today=$(date +'%Y%j')
case ${OSTYPE} in
  darwin*)
    _dump_day=$(stat -f '%Sm' -t '%Y%j' ~/.zcompdump 2>/dev/null)
    ;;
  linux*)
    _dump_day=$(stat -c '%Y' ~/.zcompdump 2>/dev/null | xargs -I{} date -d @{} +'%Y%j' 2>/dev/null)
    ;;
esac
if [[ "$_today" != "$_dump_day" ]]; then
  compinit
else
  compinit -C
fi
unset _today _dump_day

if [ -d ~/.zsh/anyframe ]; then
  autoload -Uz anyframe-init
  anyframe-init
fi

# Starship
eval "$(starship init zsh)"



TIMEFMT=$'\n\n========================\nProgram : %J\nCPU     : %P\nuser    : %*Us\nsystem  : %*Ss\ntotal   : %*Es\n========================\n'

# rye
[ -s "$HOME/.rye/env" ] && source "$HOME/.rye/env"

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi


########################################
# /default
########################################

########################################
# export
########################################

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# LS_COLORS
export LSCOLORS=cxfxcxdxbxegedabagacad

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"
# Cloud SDK
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
export CLOUDSDK_PYTHON_SITEPACKAGES=1
# Go のパスを通す
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
# Homebrew
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# editor
export VISUAL=code
export EDITOR=vim

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


# Cursor CLI
export PATH="$HOME/.local/bin:$PATH"

# Mermaid CLI
export PUPPETEER_EXECUTABLE_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

########################################
# /export
########################################

########################################
# alias
########################################

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
 
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
 
alias -g L='| less'
alias -g G='| grep'

if command -v eza >/dev/null 2>&1; then
  alias l='eza --icons'
  alias la='eza -a --icons'
  alias ll='eza --icons --header --git --time-style=long-iso -agl'
  alias li='eza --icons -T -L 2 -a'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat=bat
fi

# git
alias g="git"
alias gg="git la"
alias push="git push origin HEAD"
alias pull="git pull -p"
alias mkpr="git push origin HEAD && gh pr create && gh pr view --web"
alias t="tig"
alias ta="tig --all"
if [ -d ~/.zsh/anyframe ]; then
  alias gr='anyframe-widget-cd-ghq-repository'
  alias gc='anyframe-widget-checkout-git-branch'
fi
alias gd='delete-branch-incremental-search'
alias pr='gh pr list | fzf | awk '\''{print $1}'\'' | xargs gh pr view -w'

# docker
alias d="docker"

# terraform
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'

# 画面解像度 出力
alias resolution='system_profiler SPDisplaysDataType | grep Resolution'


# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if command -v pbcopy >/dev/null 2>&1; then
    # Mac
    alias -g C='| pbcopy'
elif command -v xsel >/dev/null 2>&1; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif command -v putclip >/dev/null 2>&1; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# /alias
########################################

########################################
# functions
########################################

# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
add-zsh-hook precmd add_line

# --------------------------------------

# git archive で納品するための関数
function git_archive() {
  # 現在の場所
  local -r CURR_DIR=$(\pwd)

  # gitリポジトリのroot
  local -r REPOSITORY_DIR=$(\git rev-parse --show-toplevel 2> /dev/null)

  # gitリポジトリかチェック
  if [ -z "${REPOSITORY_DIR}" ]; then
    echo '### This is not the repository root'
    return
  fi

  # リポジトリrootにcd
  \cd ${REPOSITORY_DIR} > /dev/null

  # .gitattributesの作成（存在していなかった場合）
  local -r GIT_ATTRIBUTES_FILENAME='.gitattributes'
  if [ ! -f ${GIT_ATTRIBUTES_FILENAME} ]; then
  {
    echo '*~ export-ignore'
    echo '.DS_Store export-ignore'
    echo '.gitignore export-ignore'
    echo "${GIT_ATTRIBUTES_FILENAME} export-ignore"
  } > ${GIT_ATTRIBUTES_FILENAME}
  fi

  # リポジトリがcleanかチェック
  if [ -n "$(\git status --porcelain)" ]; then
    echo '### There are uncommited changes'
    \git status
    \cd ${CURR_DIR} > /dev/null
    return
  fi

  # ディレクトリ名取得
  local -r REPOSITORY_DIRNAME=$(\basename ${REPOSITORY_DIR})

  # パス取得
  local -r REPOSITORY_PARENT_DIR=$(\dirname ${REPOSITORY_DIR})

  # ブランチ名取得
  local -r BRANCH_NAME=$(echo $(\git symbolic-ref --short HEAD) | sed s:/:-:g)

  # hash値取得
  local -r HASH=$(\git rev-parse --short=7 HEAD)

  # 納品!!
  local -r TAR_NAME="${REPOSITORY_PARENT_DIR}/${REPOSITORY_DIRNAME}_${BRANCH_NAME}_${HASH}.tar.gz"
  \git archive --format=tar.gz HEAD > ${TAR_NAME} && {
    echo '#========#'
    echo '# Result #'
    echo '#========#'
    echo "Archived this repository as ${TAR_NAME}"
  }

  # 元の場所に戻る
  \cd ${CURR_DIR} > /dev/null
}

# cd したら自動的に ls する
chpwd() {
	if [[ $PWD != $HOME ]]; then
		if command -v eza >/dev/null 2>&1; then
			la
		else
			ls
		fi
	fi
}

# --------------------------------------

# fzf でブランチを選択して削除する
function delete-branch-incremental-search() {
  local branch
  branch=$(git branch | fzf --prompt="Delete branch > " --preview="git log --oneline --graph \$(echo {} | sed 's/^[ *]*//')" | sed 's/^[ *]*//')
  if [[ -z "$branch" ]]; then
    return
  fi
  echo "Delete branch: $branch"
  read -q "REPLY?Are you sure? [y/N] "
  echo
  if [[ "$REPLY" == "y" ]]; then
    git branch -d "$branch"
  fi
}

########################################
# /functions
########################################

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

#=============================
# source zsh-syntax-highlighting (must be before zsh-history-substring-search)
#=============================
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#=============================
# source zsh-history-substring-search (must be after zsh-syntax-highlighting)
#=============================
if [ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey "${terminfo[kcuu1]}" history-substring-search-up
  bindkey "${terminfo[kcud1]}" history-substring-search-down
fi

# vim:set ft=zsh:
