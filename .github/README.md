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
  - AWS EC2 SSH helper
  - Battery Status
  - Disable workspace switcher popup
  - Gsconnect (Warning für die ganzen optionalen Pakete, die das braucht)
  - Launch new instance
  - No topleft hot corner
  - Status area horizonzal spacing
  - Vitals

# Missing Features (TODO)
- Vim relative line numbering
- unset all variables
- fix the umask

