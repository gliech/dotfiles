# .bashrc
# Source global definitions
if [[ -r /etc/bashrc ]]; then
  . /etc/bashrc
fi

# Bash 4 or bust
if (( BASH_VERSINFO[0] < 4 )); then
  echo "Please get a newer version of Bash."
  echo "Your bashrc won't work otherwise."
else

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

  if truthy $DOTFILES_ACTIVE; then

    # Source .bashrc.d
    for file in ~/.bashrc.d/*.sh; do
      . "$file"
    done

    unset -v file

  elif [[ ! -v DOTFILES_ACTIVE ]]; then
    echo "Dotfiles environment not found."
    echo "You should probably reload your login session before proceeding."
  fi
fi

