# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

# Export environment variables found in ~/.env . This file should contain
# environment variables that are either specific to a machine or can not be
# included in the dotfiles repository for security or privacy reasons.
if [ -f ~/.env ]; then
  set -a
  . ~/.env
  set +a
fi
