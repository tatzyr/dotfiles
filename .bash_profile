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

# PATH
if [ -d $HOME/exe ]; then
  export PATH="$HOME/exe:$PATH"
fi

if [ -d /usr/local/heroku/bin ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

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

# rbenv
if [ -d $HOME/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [ -d $HOME/.pyenv ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  eval "$(pyenv init -)"
fi

# z/cdhist
if [ -f /usr/local/etc/profile.d/z.sh ]; then
  . /usr/local/etc/profile.d/z.sh
elif [ -f $HOME/dotfiles/cdhist.sh ]; then
  . $HOME/dotfiles/cdhist.sh
fi

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

# エイリアス
alias be='bundle exec'
alias r='rails'
alias s='git status'
alias v='vagrant'
