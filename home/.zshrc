export KEYTIMEOUT=2
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

zsh_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/shells/zsh"

[[ -d "${zsh_dir}" ]] && {
	for f in "${zsh_dir}/"*.zsh ; do
		[[ -r "$f" ]] && \
			source "$f"
	done
}
