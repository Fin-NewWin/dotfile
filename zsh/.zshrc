# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ENV export
[ -f $HOME/.config/zsh/profile ] && source $HOME/.config/zsh/.profile
[ -f $HOME/.config/zsh/alias ] && source $HOME/.config/zsh/alias

eval "$(starship init zsh)"

autoload -U colors
colors
setopt prompt_subst

# Lines configured by zsh-newuser-install
export HISTFILE=~/.cache/shell/history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
bindkey -e

zstyle :compinstall filename '/home/fin/.zshrc'

# Autocomplete
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-za-z}={a-za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true


# Prompt
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
