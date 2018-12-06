# Alias dotfiles to the custom git command required for the functioning of the
# dotfiles utility
dotgit_config="$HOME/.dotfiles/dotgit_config"
dotgit_dir="$HOME/.dotgit/"
alias dotfiles="git -c include.path=$dotgit_config --git-dir=$dotgit_dir --work-tree=$HOME"

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
