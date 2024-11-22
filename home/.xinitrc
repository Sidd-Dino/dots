#!/bin/sh

# command -v dbus-launch >/dev/null && {
#     [ -z "$DBUS_SESSION_BUS_ADDRESS" ] \
#         && eval "$(dbus-launch --sh-syntax --exit-with-x11)"
# }
#
# command -v pipewire >/dev/null && {
#     pkill -9 pipewire
#     pipewire &
# }

command -v xcape     >/dev/null &&
command -v setxkbmap >/dev/null && {
    setxkbmap -option ctrl:nocaps
    pkill -9 xcape
    xcape -e 'Control_L=Escape' -t 150
}

xset -dpms
xset s off

[ -e ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources

exec "${1:-i3}"
