autoload -Uz compinit
compinit -u

zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}" # Enable dir colors
zstyle ':completion:*' menu select 
# _comp_options+=(globdots)		
