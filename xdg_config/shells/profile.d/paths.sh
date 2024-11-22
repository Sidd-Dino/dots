add_path() {
    test -d "$dir" || return
    case ":$PATH:" in
        *:"$dir":*)
            ;;
        *)
            export PATH="$dir:$PATH"
            ;;
    esac
}

ANDROID_HOME="/opt/android_sdk"
export NVM_DIR="${HOME}/.local/share/nvm/v22.9.0/bin"

for dir in  "$HOME/.local/bin" \
            "$HOME/.cargo/bin" \
            "$HOME/.ghcup/bin" \
            "$HOME/.cabal/bin" \
            "${NVM_DIR}" \
            "${ANDROID_HOME}/cmdline-tools/latest/bin" \
            "${ANDROID_HOME}/tools" \
            "${ANDROID_HOME}/tools/bin" \
            "${ANDROID_HOME}/platform-tools"
do
    add_path "$dir"
done

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH

unset addPath
unset dir
