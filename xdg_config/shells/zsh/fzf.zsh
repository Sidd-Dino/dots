
fzf_path="$(command -v fzf)" || printf 'fzf: Command not found'

command -v fzf >& /dev/null && {
    source <("${fzf_path:-:}" --zsh)
}
