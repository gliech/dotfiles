# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

# Export environment variables found in ~/.environment.d/ . Adding files in a
# directory makes it easier to supply environment variables that are either
# specific to a machine or can not be included in the dotfiles repository for
# security or privacy reasons.
set -a
for file in ~/.environment.d/*.env; do
  . "$FILE"
done
set +a
