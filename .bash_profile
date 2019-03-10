# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

### Shell
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth
export HISTFILE=~/._bash_history
shopt -s histappend
shopt -s checkwinsize
export PS1='[\t \h] \W \$ '

# Linuxbrew
if [ -d "$HOME/.linuxbrew" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# path
if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

# adb
if [ -d "$HOME/Library/Android/sdk/platform-tools" ]; then
  export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PATH="$HOME/.pyenv/bin:$PATH"
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# ndenv
if [ -d "$HOME/.ndenv" ]; then
  export PATH="$HOME/.ndenv/bin:$PATH"
  eval "$(ndenv init -)"
fi

# z
if type brew > /dev/null 2>&1; then
  if [ -f "`brew --prefix`/etc/profile.d/z.sh" ]; then
    . `brew --prefix`/etc/profile.d/z.sh
  fi
fi

# ls color
if [ "$(uname)" == 'Darwin' ]; then
  export LSCOLORS=GxFxDxBxCxegedabagacad
  alias ls='ls -G'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  export LS_COLORS='di=1;36:ln=1;35:so=1;33:pi=1;31:ex=1;32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
  alias ls='ls --color=auto'
fi

# aliases
alias d='git diff --color | diff-so-fancy | less -R'
alias dw='git diff -w --color | diff-so-fancy | less -R'
alias dc='git diff --cached --color | diff-so-fancy | less -R'
alias dcw='git diff --cached -w --color | diff-so-fancy | less -R'
alias b='git branch --sort=committerdate'
alias s='git status'
alias HandBrakeCLINormal='HandBrakeCLI -e x264 -q 20.0 -a 1 -E faac -B 160 -6 dpl2 -R Auto -D 0.0 --audio-copy-mask aac,ac3,dtshd,dts,mp3 --audio-fallback ffac3 -f mp4 --loose-anamorphic --modulus 2 -m --x264-preset veryfast --h264-profile main --h264-level 4.0'
alias HandBrakeCLIHighProfile='HandBrakeCLI -e x264 -q 20.0 -a 1,1 -E faac,copy:ac3 -B 160,160 -6 dpl2,auto -R Auto,Auto -D 0.0,0.0 --audio-copy-mask aac,ac3,dtshd,dts,mp3 --audio-fallback ffac3 -f mp4 -4 --decomb --loose-anamorphic --modulus 2 -m --x264-preset medium --h264-profile high --h264-level 4.1'

# prompt
function prompt_cmd {
  local s=$?
  if [ $s -ne 0 ]; then
    echo "$(tput bold)$(tput setaf 1)[exit $s]$(tput sgr0)"
  fi
}

PROMPT_COMMAND="prompt_cmd;$PROMPT_COMMAND"

function allupdate {
  brew update &&
  brew upgrade &&
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
