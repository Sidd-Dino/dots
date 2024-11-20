#!/bin/sh

log() {
    printf '%b%s %b%s%b %s\n' \
        "$c1" "${3:-->}" "${c3}${2:+$c2}" "$1" "$c3" "$2" >&2
}

war() {
    log "$1" "$2" "${3:-WARNING}"
}

die() {
    log "$1" "$2" "${3:-ERROR}"
    exit 1
}

help() {
    log "setup.sh [i|u]"
    log "install   Install dotfiles"
    log "uninstall Uninstall dotfiles"

    exit 1
}

unlink_file() {
    [ -e "$1" ] || return 0

    [ -L "$1" ] || {
        war 'File is not a symbolic link' "$1"
        return 1
    }

    log "Removing symbolic link" "$1"
    rm "$1"
}

link_file() {
    unlink_file "$2" || return

    ln -s "$1" "$2" || war 'Failed to link' "${1#${repo_dir}/} ==> $2"

    log 'Linking' "${1#${repo_dir}/} to $2"
}

iter_on_dir() {
    act="$1"
    src="$2"
    des="$3"

    for item in "$src"* ; do
        name="${item##*/}"
        case "${name}" in '.'|'..') continue ;; esac

        case "${act}" in
              link) link_file "${item}" "${des}/${name}" ;;
            unlink) unlink_file "${des}/${name}" ;;
        esac
    done
}

dots_install() {
    iter_on_dir link "${repo_dir}/config/" "${XDG_CONFIG_HOME:-${HOME}/.config}"
    iter_on_dir link "${repo_dir}/home/."  "${HOME}"

    link_file "${repo_dir}/bin" "${HOME}/.local/bin"
}

dots_uninstall() {
    iter_on_dir unlink "${repo_dir}/config/" "${XDG_CONFIG_HOME:-${HOME}/.config}"
    iter_on_dir unlink "${repo_dir}/home/."  "${HOME}"

    unlink_file "${HOME}/.local/bin"
}

main() {
    set -e

    [ -t 2 ] && {
        c1='\033[1;33m'
        c2='\033[1;34m'
        c3='\033[m'
    }

    repo_dir="$PWD"

    case "$1" in
        i|install)   dots_install   ;;
        u|uninstall) dots_uninstall ;;
        *)
            log "setup.sh [i|u]"
            log "install   Install dotfiles"
            log "uninstall Uninstall dotfiles"
        ;;
    esac
}

main "$@"
