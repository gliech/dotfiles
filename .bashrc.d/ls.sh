# On BSD-based operating systems the GNU coreutils version of ls may be
# installed as gls. I prefer a consistent ls to one that actually integrates
# well with MacOS, so here we are.
if command -v gls >/dev/null 2>&1; then
  alias ls="gls --color=auto"
else
  alias ls="ls --color=auto"
fi

alias ll="ls --human-readable --color=auto -l"
alias la="ls --human-readable --all --color=auto -l"
alias lA="ls --human-readable --almost-all --color=auto -l"
