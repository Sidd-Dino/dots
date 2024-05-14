#!/bin/sh

command -v dbus-launch >/dev/null && {
    [ -z "$DBUS_SESSION_BUS_ADDRESS" ] \
	&& eval "$(dbus-launch --sh-syntax --exit-with-x11)"
}

[ -e ~/.Xresources ] && xrdb -merge -I"$HOME" ~/.Xresources

exec "${1:-cwm}"
