# Gliech Dotfiles

## Replication
```bash
git clone -n --config core.bare=true --separate-git-dir=$HOME/.dotgit git@github.com:gliech/dotfiles.git $(mktemp -d)
git --work-tree=$HOME --git-dir=$HOME/.dotgit reset HEAD
git --work-tree=$HOME --git-dir=$HOME/.dotgit checkout -b $HOSTNAME
git --work-tree=$HOME --git-dir=$HOME/.dotgit commit -am "Backed up pre-existing configs to local branch"
git --work-tree=$HOME --git-dir=$HOME/.dotgit checkout master
```

## Untracked Configurations (TODO)
- Firefox profile
  - Addons (uBlockOrigin, PrivacyBadger)
  - about:config keys (Turn off Pocket)
  - Gnome3 integration (https://github.com/kurogetsusai/firefox-gnome-theme)
  - userChrome.css
  - control profiles.ini
- Gnome Extensions
  - Disable workspace switcher popup
  - Gsconnect (Warning für die ganzen optionalen Pakete, die das braucht)
  - No topleft hot corner
  - Launch new instance

