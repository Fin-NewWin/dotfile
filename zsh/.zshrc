# Aliasa and ENV
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/profile"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/alias"

# Enable colors and change prompt:

# Source other zsh files
for config (~/.config/zsh/zsh/*.zsh) source $config

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_MANUAL_REBIND=none
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20


## zsh_add_plugin "marlonrichert/zsh-autocomplete"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
