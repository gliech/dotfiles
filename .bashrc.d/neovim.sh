# Use neovim instead of vim if it is present

if command -v nvim >/dev/null 2>&1
then
  alias vim="nvim"
fi

