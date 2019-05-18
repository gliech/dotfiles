#!/usr/bin/env bash

function autosource {
  local bash_function_dirs bash_function_dir

  # Test if 1 argument was given
  if (( $# == 0 )); then
    echo "autosource: basename of a file in BASH_FUNC_PATH required"
    echo "autosource: usage: autosource basename [arguments]"
    return 1
  fi

  # Split the BASH_FUNC_PATH into an array of directory names
  IFS=: read -ra bash_function_dirs <<< "${BASH_FUNC_PATH}"

  # Look for a .sh file with the basename given as first argument in each direc-
  # tory in each directory in turn
  for bash_function_dir in "${bash_function_dirs[@]}"; do
    if [[ -r "${bash_function_dir}/${1}.sh" ]]; then

      # If we find a matching file, source it and skip the rest of this function
      . "${bash_function_dir}/${1}.sh" ${@:2}
      return
    fi
  done

  # If the loop completes no matching file is in BASH_FUNC_PATH
  echo "autosource: no ${1} in (${BASH_FUNC_PATH})"
  return 1
}
