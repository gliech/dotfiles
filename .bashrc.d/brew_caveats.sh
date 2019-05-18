# Save other operating systems some work
if [[ $OSTYPE != darwin* ]]; then
  return
fi

# brew formula bash-completion
if [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
  export BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d
  . /usr/local/etc/profile.d/bash_completion.sh
fi
