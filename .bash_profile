# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# Shell
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize

# Linuxbrew
if [ -d "$HOME/.linuxbrew" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# PATH
if [ -d "$HOME/exe" ]; then
  export PATH="$HOME/exe:$PATH"
fi

if [ -d "/usr/local/heroku/bin" ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

# z
if [ -f "`brew --prefix`/etc/profile.d/z.sh" ]; then
  . `brew --prefix`/etc/profile.d/z.sh
fi

# エイリアス
alias be='bundle exec'
alias r='rails'
alias s='git status'
alias v='vagrant'

# プロンプトに寿司/ピザ
function prompt_cmd {
  local s=$?
  if [ $s -eq 0 ] ; then
    export PS1="[\t \h] \W 🍣  "
  else
    export PS1="[\t \h] \W 🍕  "
  fi
}

PROMPT_COMMAND="prompt_cmd;$PROMPT_COMMAND"

function allupdate {
  brew update &&
  brew upgrade --all &&
  rbenv update &&
  gem update --system &&
  gem update &&
  brew doctor
}

function mylocate {
  if [ -z "$1" ]; then
    echo "usage: mylocate <directory>" 1>&2
  else
    find "$1" -print0 | xargs -0 ls -dl
  fi
}
