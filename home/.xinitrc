#!/bin/sh

[ -e ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources

exec "${1:-sowm}"
