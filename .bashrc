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

# Determine if the rest of the configuration should be loaded. DOTFILES_ACTIVE
# is a environment variable that can be set in ~/.environment.d/dotfiles.env
if [[ "${DOTFILES_ACTIVE,,}" == @(y|yes|on|true|1) ]]; then

  # Load a function that allows us to import other function definitions from
  # the BASH_FUNC_PATH without providing their exact location and export it
  . "$DOTFILES_DIR/bash_functions/autosource.sh"
  export -f autosource

  # Load utilty functions that may be used by other configurations
  autosource bool_eval
  autosource dot_utility

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

