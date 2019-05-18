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

