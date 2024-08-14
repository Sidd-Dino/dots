for dir in "$HOME/bin" "$HOME/.cargo/bin" "$HOME/.ghcup/bin" "$HOME/.cabal/bin" ; do
    test -d "$dir" || continue
    case ":$PATH:" in
        *:"$dir":*)
            ;;
        *)
            export PATH="$dir:$tPATH"
            ;;
    esac
done

#PATH="$HOME/bin:$PATH"
#PATH="$HOME/.cargo/bin:$PATH"
export PATH
