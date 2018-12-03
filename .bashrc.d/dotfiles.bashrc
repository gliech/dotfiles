alias dotfiles="git -c include.path=$HOME/.dotfiles/dotgit_config --git-dir=$HOME/.dotgit/ --work-tree=$HOME"
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main dotfiles
