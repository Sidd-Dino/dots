XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CONFIG_HOME


profile_dir="${XDG_CONFIG_HOME:-${HOME}/.config}/shells/profile.d"

if [ -d "${profile_dir}" ]; then
	for f in "${profile_dir}"/*.sh ; do
		[ -r "$f" ] && . "$f"
	done
	unset f
fi

unset profile_dir


