# .bashrc

# Source global definitions
if [[ -r /etc/bashrc ]]; then
  . /etc/bashrc
fi

# Source .bashrc.d
for file in ~/.bashrc.d/*.bashrc; do
  . "$file"
done
