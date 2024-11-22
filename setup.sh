#!/bin/sh

msg() {
    case "$1" in
          link) printf -- '%bLinking %b%s%b ==> %b%s\n' "$cG" "$cres" "$2" "$cY" "$cres" "$3" ;;
	unlink) printf -- '%bRemoved link %b%s\n' "$cY" "$cres" "$2" ;;
           err) printf -- '%bERROR %b%s\n'        "$cR" "$cres" "$2" ;;
           war) printf -- '%bWARNING %b%s\n'      "$cY" "$cres" "$2" ;;
             *) printf -- '%b--> %b%s\n'          "$cY" "$cres" "$*" ;;
    esac
}

war() { msg war "$*" ; }

die() {
    msg err "$*"
    exit 1
}

help() {
    msg "setup.sh [i|u]"
    msg "install   Install dotfiles"
    msg "uninstall Uninstall dotfiles"

    exit 1
}

unlink_file() {
    [ -e "$1" ] || return 0

    [ -L "$1" ] || {
        war 'File is not a symbolic link' "$1"
        return 1
    }

    msg unlink "$1"
    rm "$1"
}

link_file() {
    # $1  source file path
    # $2  link file path

    unlink_file "$2" || return

    msg link "$2" "$1"
    ln -s "$1" "$2" || \
        err 'Failed to link' "$2" 'to' "$1"

}

iter_on_dir() {
    act="$1"
    src="$2"
    des="$3"

    set -- "$src"/* "$src"/.*

    for item ; do
        name="${item##*/}"
        case "${name}" in '*'|'.*'|'.'|'..') continue ;; esac

        case "${act}" in
                 # *) msg "$des/$name --> $item" ;; # debugging line
              link) link_file "${item}" "${des}/${name}" ;;
            unlink) unlink_file "${des}/${name}" ;;
        esac
    done
}

dots_install() {
    iter_on_dir link "${repo_dir}/xdg_config" "${XDG_CONFIG_HOME:-${HOME}/.config}"
    iter_on_dir link "${repo_dir}/home"  "${HOME}"

    link_file "${repo_dir}/local/bin" "${HOME}/.local/bin"
    link_file "${repo_dir}/local/share/applications" "${HOME}/.local/share/applications"
}

dots_uninstall() {
    iter_on_dir unlink "${repo_dir}/xdg_config" "${XDG_CONFIG_HOME:-${HOME}/.config}"
    iter_on_dir unlink "${repo_dir}/home"  "${HOME}"

    unlink_file "${HOME}/.local/share/applications"
}

main() {
    set -e

    [ -t 2 ] && {
        cR='\033[1;31m'
        cG='\033[1;32m'
        cY='\033[1;33m'
        cres='\033[m'
    }

    repo_dir="$PWD"

    case "$1" in
        i|install)   dots_install   ;;
        u|uninstall) dots_uninstall ;;
        c) for i in $(seq 30 48); do printf '\033[1;%dm %d \033[m\n' "$i" "$i" ; done ;;
        *) help ;;
    esac
}

main "$@"
