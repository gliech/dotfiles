# .bashrc
# Don't load the bashrc if the terminal is not interactive. More information
# on how this test works can be found at the end of the bash_profile. I had to
# move this test here, because in remote shells the bashrc is sourced directly,
# wether the shell is really interactive or not. A brief explanation of this
# behaviour can be found here:
# https://unix.stackexchange.com/questions/257571
if ! [[ -t 0 ]]; then
  return 0
fi

# Source global definitions
if [[ -r /etc/bashrc ]]; then
  . /etc/bashrc
fi

# Bash 4 or bust
if (( BASH_VERSINFO[0] < 4 )); then
  echo "Please get a newer version of Bash." >&2
  echo "Your bashrc won't work otherwise." >&2
  return 1
fi

# Basic safe boolean evaluation. See this Gist for details:
# https://gist.github.com/gliech/184dc7566821442202f21dfe15e2b7ff
function truthy {
  if [[ "${1,,}" == @(y|yes|on|true|1) ]]; then
    return 0
  fi
  return 1
}

function falsy {
  if [[ "${1,,}" == @(n|no|off|false|0) ]]; then
    return 0
  fi
  return 1
}

function true_false_default {
  case "${1,,}" in
    y | yes | on | true | 1)
      return 0 ;;
    n | no | off | false | 0)
      return 1 ;;
  esac
  shift
  eval "$@"
  return 1
}

export -f truthy falsy true_false_default

# Now that we have the bare essentials, determine if the rest of the configura-
# tion should be loaded. DOTFILES_ACTIVE is a environment variable that can be
# set in ~/.environment.d/dotfiles.env
if truthy $DOTFILES_ACTIVE; then

  # Load utilty functions that may be used by other configurations
  . "$DOTFILES_DIR/bash_functions.sh"

  # Load the rest of the bash configs in ~/.basrc.d
  for file in ~/.bashrc.d/*.sh; do
    . "$file"
  done

  unset -v file

# If the DOTFILES_ACTIVE is not set at all, assume that the dotfiles repo was
# cloned very recently and print a friendly reminder.
elif [[ ! -v DOTFILES_ACTIVE ]]; then
  echo "Dotfiles environment not found." >&2
  echo "You should probably reload your login session before proceeding." >&2
  return 1
fi

