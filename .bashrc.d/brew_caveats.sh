# Save other operating systems some work
if [[ $OSTYPE != darwin* ]]; then
  return
fi

# for brew formula bash-completion@2
if [[ -r /usr/local/etc/profile.d/bash_completion.sh ]]; then
  export BASH_COMPLETION_COMPAT_DIR=/usr/local/etc/bash_completion.d
  . /usr/local/etc/profile.d/bash_completion.sh
fi

# for brew formula python
export PATH=/usr/local/opt/python/libexec/bin:$PATH
