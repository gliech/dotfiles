# If aws-azure-login is not installed do nothing
if ! command -v aws-azure-login >/dev/null 2>&1; then
  return
fi

# In WSL the no-sandbox parameter is mandatory for aws-azure-login to function
# correctly
if truthy $DOTFILES_WSL; then
  alias aws-azure-login="aws-azure-login --no-sandbox"
fi

# Make it so I just have to type a command and the (optionally) a profile
function aws-token {
  aws-azure-login --no-prompt ${1:+--profile $1}
}
