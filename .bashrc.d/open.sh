if ! command -v open >/dev/null 2>&1
then
  function open {
    gio open ${@:-.}
  }
fi
