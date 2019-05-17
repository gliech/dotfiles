# https://twitter.com/liamosaur/status/506975850596536320
function fuck {
  local nth_last=${1:-1}
  if [[ "$nth_last" =~ ^[0-9]+$ ]]; then
    sudo $(fc -ln -$nth_last -$nth_last)
  else
    echo "Usage: fuck [offset]"
    return 1
  fi
}

alias please='fuck'
