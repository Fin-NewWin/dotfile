# Enable ls colors 
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Set LS_COLORS to use for autocomplete
if [[ -z "$LS_COLORS" ]]; then 
(( $+commands[dircolors] )) && eval "$(dircolors -b)" 
fi 

ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }
zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" # Enable dir colors
zstyle ':completion:*' menu select 
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*' # case insensitive and partial completion
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

autoload -Uz compinit
compinit -u
_comp_options+=(globdots)		# Include hidden files.

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char
