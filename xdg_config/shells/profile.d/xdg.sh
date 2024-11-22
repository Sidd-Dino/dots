export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# export XDG_RUNTIME_DIR="/tmp/run-$(id -u)"

mkdir -p \
    "${XDG_CONFIG_HOME}" \
    "${XDG_CACHE_HOME}" \
    "${XDG_DATA_HOME}" \
    "${XDG_STATE_HOME}" \
    # "${XDG_RUNTIME_DIR}"

# chmod 700 "${XDG_RUNTIME_DIR}"

