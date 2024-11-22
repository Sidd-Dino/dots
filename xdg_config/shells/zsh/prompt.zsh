zmodload zsh/zle
autoload -U colors && colors


function zle-line-init zle-keymap-select {
    PS1="${${KEYMAP/vicmd/%{$fg_bold[yellow]%}}/(main|viins)/}ƒ%{$reset_color%}"

    case $KEYMAP in
    vicmd)
        #PS1="%{$fg_bold[yellow]%}ƒ %{$reset_color%}"
        PS1="%{$fg_bold[yellow]%}>>= %{$reset_color%}"
        #printf '\e[1 q'
    ;;
    *)
        #PS1="%{$fg_bold[blue]%}ƒ %{$reset_color%}"
        PS1="%{$fg_bold[blue]%}>>= %{$reset_color%}"
        #printf '\e[5 q'
    ;;
    esac

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
