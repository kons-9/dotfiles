if ! type winget > /dev/null 2>&1; then
  eecho "you need to install winget"
  return
fi

if ! type rustup > /dev/null 2>&1; then
  echo "rustup not found"
  read "yn?Install rustup? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) eecho "you need rustup"; break;;
    * ) eecho "Please answer y or n."; break;;
  esac
  winget install rustup
fi


