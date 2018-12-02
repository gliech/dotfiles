# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

alias dotfiles="git -c include.path=$HOME/.dotfiles/dotgit_config --git-dir=$HOME/.dotgit/ --work-tree=$HOME"

# I should later write this as a function that checks for the existence of a
# venv subdirectory
alias activate="source venv/bin/activate"
