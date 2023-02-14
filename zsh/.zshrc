### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Alias and ENV
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias"


sources=(
    'function'
)

for s in "${sources[@]}"; do
    source $HOME/.config/zsh/include/${s}.zsh
done


#############################################
#               history                     #
#############################################

export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE

setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS


# Enable searching through history
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
bindkey "^R" history-incremental-search-backward

#############################################
#               autocomplete                #
#############################################

# Enable ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Set LS_COLORS to use for autocomplete
if [[ -z "$LS_COLORS" ]]; then
    (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

unsetopt case_glob              # Use Case-Insensitve Globbing.
setopt globdots                 # Glob Dotfiles As Well.
setopt extendedglob             # Use Extended Globbing.
setopt autocd


# Smart URLs.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Persistent cd
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
DIRSTACKFILE="$HOME/.cache/zsh/dirs"


# ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }
set +o list_types
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" # Enable dir colors
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*' # case insensitive and partial completion
# zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char




#############################################
#               PROMPT                      #
#############################################
eval "$(starship init zsh)"

#############################################
#               PLUGIN                      #
#############################################

zinit wait lucid light-mode for \
        OMZ::plugins/git-auto-fetch/git-auto-fetch.plugin.zsh \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    as"completion" \
        zsh-users/zsh-completions \


zinit light zdharma-continuum/history-search-multi-word

zinit ice silent wait!1 atload"ZINIT[COMPINIT_OPTS]=-C; zpcompinit"
zinit light zdharma-continuum/fast-syntax-highlighting

#############################################
#               PLUGIN CONFIG               #
#############################################
bindkey '^ ' autosuggest-accept


#############################################
#               PYTHON                      #
#############################################
function _pip_completion {
    local words cword; read -Ac words; read -cn cword
    reply=($(
      COMP_WORDS="$words[*]"; COMP_CWORD=$(( cword-1 )) \
      PIP_AUTO_COMPLETE=1 $words 2>/dev/null)
    )
};
compctl -K _pip_completion pip3
