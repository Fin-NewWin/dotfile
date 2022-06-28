#!/bin/sh

# Enable colors and change prompt:
autoload -Uz colors && colors	# Load colors

# useful options
unsetopt BEEP
setopt extendedglob nomatch menucomplete
setopt interactive_comments
stty stop undef	
zle_highlight=('paste:none')

# History in cache directory:
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt appendhistory
setopt no_hist_allow_clobber
setopt no_hist_beep
setopt share_history
HISTSIZE=10000000
SAVEHIST=10000000

# Source ENV and ALIAS
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias"

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		

# Enable searching through history
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward

# functions
source "$ZDOTDIR/zsh-functions"

# Add-ons
zsh_add_file "zsh-prompt"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

ZSH_AUTOSUGGEST_MANUAL_REBIND=()
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
compinit
