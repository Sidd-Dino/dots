
common_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/shells/common"

for item in "${common_dir}/"* ; do
	source "$item"
done
