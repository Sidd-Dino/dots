#!/bin/sh

tmux_set-opt() { tmux ${TMUX_SOCKET:+-S "$TMUX_SOCKET"} set-option -g $1 "$2"; }

init_statusline() {
    tmux_set-opt window-status-format         ""
    tmux_set-opt window-status-current-format ""
    tmux_set-opt status-position              "top" 
    tmux_set-opt status-style                 "bg=#1e1e2e,fg=#cdd6f4"
    tmux_set-opt status-justify               "left"
    tmux_set-opt status-right                 ""
    tmux_set-opt status-left                  ""
}

_statusline() {
    tmux move-window -r
    tmux list-panes -a \
        -F '|#{session_id}|#{session_name}' \
           '|#{window_id}|#{window_name}|'  \
           '#{pane_id}' | awk -v cols=$1 \
                              -v sID=$1 -v wID=$2 -v pID=$3 "$AWK_SCRIPT"

    tmux_set-opt status-left "#[bg=default,fg=default,bold]#{?client_prefix,,${indicator}}#[bg=${bg},fg=black,bold]#{?client_prefix,${indicator},}"
}

"$@"
