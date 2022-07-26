#!/bin/sh

[ -e ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources


sxhkd -c "$HOME"/.config/berry/sxhkdrc &

exec "${1:-berry}"
