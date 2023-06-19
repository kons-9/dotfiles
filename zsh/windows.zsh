if ! type winget > /dev/null 2>&1; then
  eecho "you need to install winget"
  exit 1
fi

if ! type rustup > /dev/null 2>&1; then
  echo "rustup not found"
  read "yn?Install rustup? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) eecho "you need rustup"; exit 1;;
    * ) eecho "Please answer y or n."; exit 1;;
  esac
  winget install rustup
fi


