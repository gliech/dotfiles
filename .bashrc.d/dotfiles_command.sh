# Alias dotfiles to the custom git command required for the functioning of the
# dotfiles utility
alias dotfiles="git \
  -c include.path=$DOTFILES_DIR/dotgit_config \
  --git-dir=$DOTFILES_GITDIR \
  --work-tree=$HOME"

# Shorten the dotfiles command to dot if possible
if ! command -v dot >/dev/null 2>&1
then
  alias dot="dotfiles"
  dot_aliased="yes"
fi

# Add bash completion to the aliases if possible
possible_locations=(
  "/usr/share/doc/git/contrib/completion/git-completion.bash"
  "/usr/share/git/completion/git-completion.bash"
  "/usr/share/bash-completion/completions/git"
  "/usr/local/etc/bash_completion.d/git-completion.bash"
)

for completion_file in "${possible_locations[@]}"
do
  if [[ -r "$completion_file" ]]
  then
    . $completion_file
    __git_complete dotfiles __git_main
    if [[ $dot_aliased == yes ]]
    then
      __git_complete dot __git_main
    fi
    break
  fi
done

unset -v dot_aliased possible_locations completion_file

