# This is the first-run installation of the dotfiles utility. Although I have
# been trying to avoid the need of executing additional code to put my config
# files into place, that is not always possible or practical. The following
# script is my attempt to make this as painless as possible.

# Get the checksum of this very file.
read -r checksum _ <<< $(sha256sum "${BASH_SOURCE[0]}")

# Compare the computed checksum to a cached version from the environment. This
# is done instead of a boolean token, so that the installation will run again
# automatically, should this file change after an update.
if [[ $checksum != $DOTFILES_INSTALL_CHECKSUM ]]; then

  # If the checksum differed, source the file that contains the cached checksum
  # and compare again to make sure that an update has not occured and already
  # been processed since the environment has last been sourced at the beginning
  # of the login session. Testing twice is a trade-off because most of the time
  # the first test will fail and no file has to be sourced.
  if [[ -r ~/.environment.d/dotfiles_install.env ]]; then
     . ~/.environment.d/dotfiles_install.env
  fi
  if [[ $checksum != $DOTFILES_INSTALL_CHECKSUM ]]; then
    # Installation starts here. Sections should still be designed in a way that
    # they won't run twice if possible.
    ############################################################################
    echo "Dotfiles: Starting automatic installation routines"
    dotfiles_install_error="no"


    # vim-plug
    if ! [[ -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
      echo "Dotfiles: Downloading vim-plug..."
      if curl \
        --fail \
        --location \
        --retry 5 \
        --retry-delay 1 \
        --create-dirs \
        --progress-bar \
        --output ~/.local/share/nvim/site/autoload/plug.vim \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      then
        echo "Dotfiles: Done"
      else
        echo "Dotfiles: Error downloading vim-plug"
        dotfiles_install_error="yes"
      fi
    fi


    ############################################################################
    # Installation ends here. If we have come this far the installation should
    # have been successful. Write the current checksum of this file to
    # dotfiles_install.env and export the variable for good measure.
    if [[ $dotfiles_install_error == "no" ]]; then
      echo "Dotfiles: Automatic installation successful. Setting new checksum..."
      echo "DOTFILES_INSTALL_CHECKSUM=$checksum" > ~/.environment.d/dotfiles_install.env
      export DOTFILES_INSTALL_CHECKSUM=$checksum
    else
      echo "Dotfiles: Errors were encountered during automatic installation"
      echo "Dotfiles: Installation can be re-run by opening a new shell"
    fi
  fi
fi
