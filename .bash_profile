# .bash_profile

# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

# Export environment variables found in ~/.environment.d/ . Adding files in a
# directory makes it easier to supply environment variables that are either
# specific to a machine or can not be included in the dotfiles repository for
# security or privacy reasons.
set -a
for file in ~/.environment.d/*.env; do
  . "$file"
done
set +a

unset -v file

# Source the .bashrc if the file descriptor for stdin is opened. This is a very
# simple test to determine if the .bash_profile was sourced from VT or SSH-login
# where the .bashrc has to be sourced to provide a similar environment to a
# terminal emulator. Found here:
# https://eklitzke.org/effectively-using-bash-profile
# I had to move the actual test '-t 0' over to the bashrc. More information as
# to why can be found there.
if [[ -r ~/.bashrc ]]; then
  . ~/.bashrc
fi

