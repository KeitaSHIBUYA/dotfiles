########################################
# default
########################################

# -----------------------------
# Environment Variables & PATH
# -----------------------------
export LANG=ja_JP.UTF-8

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"

# Cloud SDK
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# Rancher Desktop (Managed Block)
### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/shibuya.keita/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Other Tools
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/bin/virtualenv:$PATH"
# Note: Removed redundant tfenv path as it is usually in homebrew bin

export EDITOR=code
export CLICOLOR=1
export LSCOLORS=cxfxcxdxbxegedabagacad

# -----------------------------
# Zsh Core Settings
# -----------------------------
# Colors
autoload -Uz colors && colors

# Keybindings (Emacs style)
bindkey -e

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Time format for history
alias history='history -t "%F %T"'

# Word Style
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# -----------------------------
# Completion
# -----------------------------
# Add homebrew completions to FPATH
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# Initialize completion (Once, robustly)
autoload -Uz compinit
if [ -n "${ZDOTDIR:-$HOME}/.zcompdump" ]; then
  # Check if dump file is older than 24 hours
  if [[ $(date +'%s') -gt $(date -r "${ZDOTDIR:-$HOME}/.zcompdump" +'%s') + 86400 ]]; then
    compinit
  else
    compinit -C
  fi
else
  compinit
fi

# Completion Options
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# -----------------------------
# Options
# -----------------------------
setopt print_eight_bit
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob

# Keybinding for history search
bindkey '^R' history-incremental-pattern-search-backward

# -----------------------------
# Plugins
# -----------------------------

# Syntax Highlighting
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# History Substring Search
if [ -f ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
fi

# Completions (Manual source if exists)
if [ -f ~/.zsh/zsh-completions/zsh-completions.zsh ]; then
  source ~/.zsh/zsh-completions/zsh-completions.zsh
fi

# Spaceship Prompt (Legacy? Kept just in case, but Starship overrides)
if [ -f ~/.zsh/spaceship-prompt/spaceship-prompt.zsh ]; then
  source ~/.zsh/spaceship-prompt/spaceship-prompt.zsh
fi

# Starship (Main Prompt)
eval "$(starship init zsh)"

# Rye
source "$HOME/.rye/env"

# Direnv
eval "$(direnv hook zsh)"

# -----------------------------
# Aliases
# -----------------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias sudo='sudo '

# Pipe aliases
alias -g L='| less'
alias -g G='| grep'

# List aliases (eza)
alias list='ls'
alias ls='eza --icons' # Override default ls
alias l='eza --icons'
alias la='eza -a --icons'
alias ll='eza --icons --header --git --time-style=long-iso -agl'
alias li='eza --icons -T -L 2 -a'

# Bat
alias cat=bat

# Git
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

# Docker
alias d="docker"

# Terraform
alias tf='terraform'
alias tfp='terraform plan'
alias tfa='terraform apply'

# System
alias resolution='system_profiler SPDisplaysDataType G Resolution'

# Clipboard
if which pbcopy >/dev/null 2>&1 ; then
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    alias -g C='| putclip'
fi

# -----------------------------
# Functions
# -----------------------------

# Add newline after command output
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

# Git Archive
function git_archive() {
  readonly local CURR_DIR=`\pwd`
  readonly local REPOSITORY_DIR=`\git rev-parse --show-toplevel 2> /dev/null`

  if [ -z "${REPOSITORY_DIR}" ]; then
    echo '### This is not the repository root'
    return
  fi

  \cd ${REPOSITORY_DIR} > /dev/null

  readonly local GIT_ATTRIBUTES_FILENAME='.gitattributes'
  if [ ! -f ${GIT_ATTRIBUTES_FILENAME} ]; then
  {
    echo '*~ export-ignore'
    echo '.DS_Store export-ignore'
    echo '.gitignore export-ignore'
    echo "${GIT_ATTRIBUTES_FILENAME} export-ignore"
  } > ${GIT_ATTRIBUTES_FILENAME}
  fi

  if [ -n "$(\git status --porcelain)" ]; then
    echo '### There are uncommited changes'
    \git status
    \cd ${CURR_DIR} > /dev/null
    return
  fi

  readonly local REPOSITORY_DIRNAME=`\basename $(git rev-parse --show-toplevel)`
  readonly local REPOSITORY_PARENT_DIR=`\dirname ${REPOSITORY_DIR}`
  readonly local TAR_NAME="${REPOSITORY_PARENT_DIR}/${REPOSITORY_DIRNAME}.tar.gz"
  
  \git archive --format=tar.gz HEAD > ${TAR_NAME} && {
    echo '#========#'
    echo '# Result #'
    echo '#========#'
    echo "Archived this repository as ${TAR_NAME}"
  }

  \cd ${CURR_DIR} > /dev/null
}

# Auto ls on cd
chpwd() {
	if [[ $(pwd) != $HOME ]]; then;
		la
	fi
}

# Note: Removed redundant vcs_info hook as Starship handles prompt/git status.

TIMEFMT=$'\n\n========================\nProgram : %J\nCPU     : %P\nuser    : %*Us\nsystem  : %*Ss\ntotal   : %*Es\n========================\n'
