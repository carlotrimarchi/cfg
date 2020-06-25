autoload -U colors
colors

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

export EDITOR=vim
export PATH=$HOME/bin:$PATH

alias config='/usr/local/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
