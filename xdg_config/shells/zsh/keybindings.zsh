bindkey -v # enable vim mode

bindkey -M vicmd '^ ' autosuggest-accept
bindkey -M viins '^ ' autosuggest-accept

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd '^[[A' history-substring-search-up
bindkey -M vicmd '^[[B' history-substring-search-down

bindkey -M viins '^[[A' history-substring-search-up
bindkey -M viins '^[[B' history-substring-search-down

bindkey -M vicmd '^r' history-search-multi-word
bindkey -M viins '^r' history-search-multi-word
