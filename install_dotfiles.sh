#!/bin/sh

for f in .??*; do
    [ "$f" == ".git" ] && continue
    [ "$f" == ".DS_Store" ] && continue

    echo ln -s ~/dotfiles/"$f" ~/"$f"
done
