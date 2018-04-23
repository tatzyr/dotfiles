#!/bin/sh

echo "$(tput bold)$(tput setaf 6)Run the following commands$(tput sgr0)"
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    echo ln -s ~/dotfiles/"$f" ~/"$f"
done

echo

echo "$(tput bold)$(tput setaf 6)Your git identity$(tput sgr0)"
egrep '^\s+(name|email) = ' .gitconfig
