# Defaults
export BROWSER="firefox"
export TERMINAL="st"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Less
export LESSHISTFILE="-"

# X
export XAUTHORITY="$HOME/.cache/Xauthority"

# rust
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# gtk
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/settings.ini"
export GTK_THEME=Adwaita:dark

# GNU
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# R
export R_ENVIRON="$XDG_CONFIG_HOME"/Renviron

# Java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export _JAVA_AWT_WM_NONREPARENTING=1 # Fixes problems on WM

# MATLAB
export MATLAB_LOG_DIR="$XDG_CACHE_HOME/matlab/"

# npm
export npm_config_userconfig=$XDG_CONFIG_HOME/npm/config
export npm_config_cache=$XDG_CACHE_HOME/npm

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# starship prompt
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship/cache"

# X11
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

# Editor
export EDITOR="nvim"
