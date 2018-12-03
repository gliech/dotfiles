# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Source .bashrc.d
for file in ~/.bashrc.d/*.bashrc; do
  . "$file"
done
