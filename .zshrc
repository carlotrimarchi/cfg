typeset -A __CARLO
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"

export EDITOR=vim
export PATH=$HOME/bin:$PATH

bindkey -v


#
# Options
#

setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt AUTO_PUSHD              # [default] cd automatically pushes old dir onto dir stack
setopt AUTO_RESUME             # allow simple commands to resume backgrounded jobs
setopt CLOBBER                 # allow clobbering with >, no need to use >!
setopt CORRECT                 # [default] command auto-correction
setopt CORRECT_ALL             # [default] argument auto-correction
setopt NO_FLOW_CONTROL         # disable start (C-s) and stop (C-q) characters
setopt NO_HIST_IGNORE_ALL_DUPS # don't filter non-contiguous duplicates from history
setopt HIST_FIND_NO_DUPS       # don't show dupes when searching
setopt HIST_IGNORE_DUPS        # do filter contiguous duplicates from history
setopt HIST_IGNORE_SPACE       # [default] don't record commands starting with a space
setopt HIST_VERIFY             # confirm history expansion (!$, !!, !foo)
setopt IGNORE_EOF              # [default] prevent accidental C-d from exiting shell
setopt INTERACTIVE_COMMENTS    # [default] allow comments, even in interactive shells
setopt LIST_PACKED             # make completion lists more densely packed
setopt MENU_COMPLETE           # auto-insert first possible ambiguous completion
setopt NO_NOMATCH              # [default] unmatched patterns are left unchanged
setopt PRINT_EXIT_VALUE        # [default] for non-zero exit status
setopt PUSHD_IGNORE_DUPS       # don't push multiple copies of same dir onto stack
setopt PUSHD_SILENT            # [default] don't print dir stack after pushing/popping
setopt SHARE_HISTORY           # share history across shells



#
# Prompt
#

autoload -U colors
colors

autoload -Uz vcs_info

_setup_ps1() {
  vcs_info
  GLYPH="▲"
  [ "x$KEYMAP" = "xvicmd" ] && GLYPH="▼"
  PS1="%~"
}
_setup_ps1


precmd() {
    vcs_info
}

setopt PROMPT_SUBST
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' disable-patterns "${(b)HOME}/code/(commerce|portal|portal-ee|portal-master)(|/*)"
zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
#zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
#zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%c%u] ' # default ' (%s)-[%b|%a]%c%u-'

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}●%f"
  fi
}


# Anonymous function to avoid leaking variables.
function () {
  # Check for tmux by looking at $TERM, because $TMUX won't be propagated to any
  # nested sudo shells but $TERM will.
  local TMUXING=$([[ "$TERM" =~ "tmux" ]] && echo tmux)
  if [ -n "$TMUXING" -a -n "$TMUX" ]; then
    # In a a tmux session created in a non-root or root shell.
    local LVL=$(($SHLVL - 1))
  else
    # Either in a root shell created inside a non-root tmux session,
    # or not in a tmux session.
    local LVL=$SHLVL
  fi
  if [[ $EUID -eq 0 ]]; then
    local SUFFIX='%F{yellow}%n%f'$(printf '%%F{yellow}\u276f%.0s%%f' {1..$LVL})
  else
    local SUFFIX=$(printf '%%F{red}\u276f%.0s%%f' {1..$LVL})
  fi
  export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%B%1~%b%F{yellow}%B%(1j.*.)%(?..!)%b%f %B${SUFFIX}%b "
  if [[ -n "$TMUXING" ]]; then
    # Outside tmux, ZLE_RPROMPT_INDENT ends up eating the space after PS1, and
    # prompt still gets corrupted even if we add an extra space to compensate.
    export ZLE_RPROMPT_INDENT=0
  fi
}

export RPROMPT="\${vcs_info_msg_0_} %F{blue}%~%f"
# PROMPT=\$vcs_info_msg_0_'%# '



# Make fzf to include also hidden files
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'



alias config='/usr/local/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'



# Colors
#

__CARLO[BASE16_CONFIG]=~/.vim/.base16

# Takes a hex color in the form of "RRGGBB" and outputs its luma (0-255, where
# 0 is black and 255 is white).
#
# Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colors
luma() {
  emulate -L zsh

  local COLOR_HEX=$1

  if [ -z "$COLOR_HEX" ]; then
    echo "Missing argument hex color (RRGGBB)"
    return 1
  fi

  # Extract hex channels from background color (RRGGBB).
  local COLOR_HEX_RED=$(echo "$COLOR_HEX" | cut -c 1-2)
  local COLOR_HEX_GREEN=$(echo "$COLOR_HEX" | cut -c 3-4)
  local COLOR_HEX_BLUE=$(echo "$COLOR_HEX" | cut -c 5-6)

  # Convert hex colors to decimal.
  local COLOR_DEC_RED=$((16#$COLOR_HEX_RED))
  local COLOR_DEC_GREEN=$((16#$COLOR_HEX_GREEN))
  local COLOR_DEC_BLUE=$((16#$COLOR_HEX_BLUE))

  # Calculate perceived brightness of background per ITU-R BT.709
  # https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
  # http://stackoverflow.com/a/12043228/18986
  local COLOR_LUMA_RED=$((0.2126 * $COLOR_DEC_RED))
  local COLOR_LUMA_GREEN=$((0.7152 * $COLOR_DEC_GREEN))
  local COLOR_LUMA_BLUE=$((0.0722 * $COLOR_DEC_BLUE))

  local COLOR_LUMA=$(($COLOR_LUMA_RED + $COLOR_LUMA_GREEN + $COLOR_LUMA_BLUE))

  echo "$COLOR_LUMA"
}

color() {
  emulate -L zsh

  local SCHEME="$1"
  local BASE16_DIR=~/.zsh/base16-shell/scripts
  local BASE16_CONFIG_PREVIOUS="${__CARLO[BASE16_CONFIG]}.previous"
  local STATUS=0

  __color() {
    SCHEME=$1
    local FILE="$BASE16_DIR/base16-$SCHEME.sh"
    if [[ -e "$FILE" ]]; then
      local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
      local LUMA=$(luma "$BG")
      local LIGHT=$((LUMA > 127.5))
      local BACKGROUND=dark
      if [ "$LIGHT" -eq 1 ]; then
        BACKGROUND=light
      fi

      if [ -e "$__CARLO[BASE16_CONFIG]" ]; then
        cp "$__CARLO[BASE16_CONFIG]" "$BASE16_CONFIG_PREVIOUS"
      fi

      echo "$SCHEME" >! "$__CARLO[BASE16_CONFIG]"
      echo "$BACKGROUND" >> "$__CARLO[BASE16_CONFIG]"
      sh "$FILE"

      if [ -n "$TMUX" ]; then
        local CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
        if [ -n "$BG" -a -n "$CC" ]; then
          command tmux set -a window-active-style "bg=#$BG"
          command tmux set -a window-style "bg=#$CC"
          command tmux set -g pane-active-border-style "bg=#$CC"
          command tmux set -g pane-border-style "bg=#$CC"
        fi
      fi
    else
      echo "Scheme '$SCHEME' not found in $BASE16_DIR"
      STATUS=1
    fi
  }

  if [ $# -eq 0 ]; then
    if [ -s "$__CARLO[BASE16_CONFIG]" ]; then
      cat "$__CARLO[BASE16_CONFIG]"
      local SCHEME=$(head -1 "$__CARLO[BASE16_CONFIG]")
      __color "$SCHEME"
      return
    else
      SCHEME=help
    fi
  fi

  case "$SCHEME" in
  help)
    echo 'color                                   (show current scheme)'
    echo 'color default-dark|grayscale-light|...  (switch to scheme)'
    echo 'color help                              (show this help)'
    echo 'color ls [pattern]                      (list available schemes)'
    return
    ;;
  ls)
    find "$BASE16_DIR" -name 'base16-*.sh' | \
      sed -E 's|.+/base16-||' | \
      sed -E 's/\.sh//' | \
      grep "${2:-.}" | \
      sort | \
      column
      ;;
  -)
    if [[ -s "$BASE16_CONFIG_PREVIOUS" ]]; then
      local PREVIOUS_SCHEME=$(head -1 "$BASE16_CONFIG_PREVIOUS")
      __color "$PREVIOUS_SCHEME"
    else
      echo "warning: no previous config found at $BASE16_CONFIG_PREVIOUS"
      STATUS=1
    fi
    ;;
  *)
    __color "$SCHEME"
    ;;
  esac

  unfunction __color
  return $STATUS
}

function () {
  emulate -L zsh

  if [[ -s "$__CARLO[BASE16_CONFIG]" ]]; then
    local SCHEME=$(head -1 "$__CARLO[BASE16_CONFIG]")
    local BACKGROUND=$(sed -n -e '2 p' "$__CARLO[BASE16_CONFIG]")
    if [ "$BACKGROUND" != 'dark' -a "$BACKGROUND" != 'light' ]; then
      echo "warning: unknown background type in $__CARLO[BASE17_CONFIG]"
    fi
    color "$SCHEME"
  else
    # Default.
    color default-dark
  fi
}
