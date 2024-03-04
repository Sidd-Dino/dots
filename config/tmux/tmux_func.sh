#!/bin/sh

_key_table() {
	case "$1" in
	root)     t="ROOT" ;;
	prefix)   t="PFIX" ;;
	*resize)  t="RESZ" ;;
	esac

	printf '%s' "${t}"
}

_date() {
	date '+%H:%M'
}

_battery() {
	bat_dir="/sys/class/power_supply/BAT0/"

	read -r c < "${bat_dir}/capacity"
	read -r s < "${bat_dir}/status"

	case "${s}" in
	Disc*) s='Batt' ;;
	Char*) s='Chrg' ;;
	Full)  s='Full' ;;
	*)     s='Whut' ;;
	esac

	frmt='[%s %3s%%]'
	[ "$c" -le 30 ] && frmt="#[push-default]#[blink, bg=#f38ba8]$frmt#[pop-default]"

	printf  "$s" "$c"
}

_pane_path() {
	printf '%s\n' "${1}" \
	| sed -e "s%${HOME}%~%g"
}

_w_status() {
	# w : Width of the client
	# n : Number of tmux windows
	# c : 1 for current window
	#     0 for other windows
	w="$1"
	n="$2"
	c="$3"

	w=$((w-n+1)) # remove columns used by separator -> (n-1)

	[ "${windows}" == 1 ] && {
		tmux \
		    set-option status           'on' \;\
		    set-option status-format[0] '#[align=left range=left #{E:status-left-style}]#[push-default]#{T;=/#{status-left-length}:status-left}#[pop-default]#[norange default]#[nolist align=right range=right #{E:status-right-style}]#[push-default]#{T;=/#{status-right-length}:status-right}#[pop-default]#[norange default]' \;
		printf ''
		return
	}

	w1=$((w/n + w%n))
	w2=$((w/n))

	tmux \
	    set-option status           '2' \;\
	    set-option status-format[0] '#[list=on align=#{status-justify}]#[list=left-marker]<#[list=right-marker]>#[list=on]#{W:#[range=window|#{window_index}]#[push-default]#{T:window-status-format}#[pop-default]#[norange default]#{?window_end_flag,,#{window-status-separator}},#[range=window|#{window_index} list=focus]#[push-default]#{T:window-status-current-format}#[pop-default]#[norange list=on default]#{?window_end_flag,,#{window-status-separator}}}' \;\
	    set-option status-format[1] '#[align=left range=left #{E:status-left-style}]#[push-default]#{T;=/#{status-left-length}:status-left}#[pop-default]#[norange default]#[nolist align=right range=right #{E:status-right-style}]#[push-default]#{T;=/#{status-right-length}:status-right}#[pop-default]#[norange default]' \;

	frmt="#{=%s:#{p%s:#{window_index} #{window_name}}}"
	frmt="#{?window_end_flag,${frmt},${frmt}}"
	case "${c}" in
		0) printf "${frmt}"                "$w1" "$w1" "$w2" "$w2" ;;
		1) printf "#[reverse,bold]${frmt}" "$w1" "$w1" "$w2" "$w2" ;;
	esac
}

# _init() {
# 	tmux \
# 	    set-option    status                       'on' \;\
# 	    set-option -g status-position              'bottom' \;\
# 	    set-option -g status-style                 'bg=#cdd6f4,fg=#1e1e2e' \;\
# 	    set-option -g status-justify               'left' \;\
# 	    set-option -g status-left                  '[#{client_key_table}] #{pane_current_path}' \;\
# 	    set-option -g status-right                 '[#( cut -c3- '$TMUX_CONF' | sh -s _date )][ #{session_id} #{window_id} #{pane_id} ]' \;\
# 	    set-option -g window-status-format         '#( cut -c3- '$TMUX_CONF' | sh -s _w_status "#{client_width}" "#{session_windows}" "0" )'
# 	    set-option -g window-status-current-format '#( cut -c3- '$TMUX_CONF' | sh -s _w_status "#{client_width}" "#{session_windows}" "1" )'
# 	    set-option -g window-status-separator      '|'
# }

"$@"
###############################
  #[align=left range=left #{E:status-left-style}]#[push-default]#{T;=/#{status-left-length}:status-left}#[pop-default]#[norange default]#[list=on align=#{status-justify}]#[list=left-marker]<#[list=right-marker]>#[list=on]#{W:#[range=window|#{window_index} #{E:window-status-style}#{?#{&&:#{window_last_flag},#{!=:#{E:window-status-last-style},default}}, #{E:window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}}, #{E:window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{E:window-status-activity-style},default}}, #{E:window-status-activity-style},}}]#[push-default]#{T:window-status-format}#[pop-default]#[norange default]#{?window_end_flag,,#{window-status-separator}},#[range=window|#{window_index} list=focus #{?#{!=:#{E:window-status-current-style},default},#{E:window-status-current-style},#{E:window-status-style}}#{?#{&&:#{window_last_flag},#{!=:#{E:window-status-last-style},default}}, #{E:window-status-last-style},}#{?#{&&:#{window_bell_flag},#{!=:#{E:window-status-bell-style},default}}, #{E:window-status-bell-style},#{?#{&&:#{||:#{window_activity_flag},#{window_silence_flag}},#{!=:#{E:window-status-activity-style},default}}, #{E:window-status-activity-style},}}]#[push-default]#{T:window-status-current-format}#[pop-default]#[norange list=on default]#{?window_end_flag,,#{window-status-separator}}}#[nolist align=right range=right #{E:status-right-style}]#[push-default]#{T;=/#{status-right-length}:status-right}#[pop-default]#[norange default]
#
#123456789012345678901234567890
#tmux set-option -g window-status-separator ""
#
#
#w=$((cols/N))
#fmt="#{=/${w}/...:#{p${w}: #{window_index}:#{window_name}}}"
#
# n='#{session_name}' ;
# #( c=$(( #{client_width} - 10 - ${#n} )) ; w='#{session_windows}'; printf "$(( c / w ))" )
#fmt="#{=/#( c=$(( #{client_width} - 10 - ${#n} )) ; w='#{session_windows}'; printf "$(( c / w ))" )/...:#{p#( c=$(( #{client_width} - 10 - ${#n} )) ; w='#{session_windows}'; printf "$(( c / w ))" ): #{window_index}:#{window_name}}}"
#
#tmux set-option window-status-format "$fmt"
#
#w=$((cols/N + cols%N))
#fmt="#[bg=brightblue,fg=#000000,bold]#{=/${w}/...:#{p${w}: #{window_index}:#{window_name}}}"
#
#tmux set-option window-status-current-format "$fmt"
#
###########################################################################
#
#tmux list-windows -F "#{window_index}:#{window_name} #{?window_active,+,-}" |
#while IFS= read -r ln; do
#    wstr="${ln% *}"
#
#    case "${ln##* }" in
#        +)
#            spc="$(( (cols/N) + (cols%N) ))"
#            l="$(( (spc + ${#wstr})/2 ))"
#            r="$(( spc - l ))"
#            printf "\033[36;7m%${l}s%${r}s\033[m" "${wstr}" ""
#        ;;
#        *)
#            spc="$((cols/N))"
#            l="$(( (spc + ${#wstr})/2 ))"
#            r="$(( spc - l ))"
#            printf "%${l}s%${r}s" "${wstr}" ""
#        ;;
#    esac
#done
#
#printf '\n'
#
###########################################################################
#
#awk -v cols="$cols" '
#function centre(str, spc) {
#    Ssize = length(str)
#    #Lsize = int(spc/2)           + (int(Ssize/2) + (Ssize%2))
#    #Rsize = int(spc/2) + (spc%2) - (int(Ssize/2) + (Ssize%2))
#
#    Lsize = (spc + length(str))/2
#    Rsize = spc - LSize
#
#    return sprintf("%" Lsize "s%" Rsize "s", str, "")
#}
#
#{
#    arr[L++] = $0
#}
#
#END {
#    for(i=0;i<L;i++) {
#        spc = int(cols / L)
#        if(arr[i] ~ /+$/) {
#            printf "\033[34;7m"
#            spc = int(cols / L) + (cols%L)
#        }
#
#        sub(/ [+-]$/, "", arr[i])
#
#        printf "%s\033[m", centre(arr[i], spc)
#    }
#    print ""
#
#}
#'
#
# pooop
# |------
# -------|
# |<-------N------->|   |<-str->|
# (N/2) - (len(str)/2)
# 
#
#
# tab-bar-width = client_width - (client_windows - 1)
#
# ROOT
# COPY
# RESZ
#
# [B 100%]
# [C 100%]
# [F 100%]
#
# [C   99%]
# [AC 100%]
# [DC 100%]
#
# + Ch arging
# - Di scharging
# ~ Fu ll
# ! Lo w
