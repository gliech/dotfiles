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
  # Source .bashrc.d
  for file in ~/.bashrc.d/*.bashrc; do
    . "$file"
  done

  unset -v file
fi

