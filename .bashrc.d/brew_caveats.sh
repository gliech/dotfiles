# Save other operating systems some work
if [[ $OSTYPE != darwin* ]] || ! command -v brew  >/dev/null 2>&1; then
  return
fi

BREW_DIR=$(brew --prefix)

# for brew formula bash-completion@2
if [[ -r ${BREW_DIR}/etc/profile.d/bash_completion.sh ]]; then
  export BASH_COMPLETION_COMPAT_DIR=${BREW_DIR}/etc/bash_completion.d
  . ${BREW_DIR}/etc/profile.d/bash_completion.sh
fi

# for brew formula python
if [[ -d ${BREW_DIR}/opt/python/libexec/bin ]]; then
  export PATH=${BREW_DIR}/opt/python/libexec/bin:$PATH
fi
