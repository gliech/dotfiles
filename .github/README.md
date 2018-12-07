# Gliech Dotfiles

## Replication
```bash
git clone -n --config core.bare=true --separate-git-dir=$HOME/.dotgit git@github.com:gliech/dotfiles.git $(mktemp -d)
git --work-tree=$HOME --git-dir=$HOME/.dotgit reset HEAD
git --work-tree=$HOME --git-dir=$HOME/.dotgit checkout -b $HOSTNAME
git --work-tree=$HOME --git-dir=$HOME/.dotgit commit -am "Backed up pre-existing configs to local branch"
git --work-tree=$HOME --git-dir=$HOME/.dotgit checkout master
```
