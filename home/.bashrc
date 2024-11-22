#!/usr/bin/env bash

[[ $- == *i* ]] || return 0

PS1='>>= '

set -o vi

shopt -s checkwinsize
shopt -s histappend

complete -c man which
complete -cf doas

export HISTCONTROL="erasedups:ignorespace"

command -v fzf >& /dev/null && {
	FZF_ALT_C_COMMAND=
	eval "$(fzf --bash)"
}

command -v zoxide >& /dev/null && {
	eval "$(zoxide init bash)"
}
