if ! type winget > /dev/null 2>&1; then
  __eecho "you need to install winget"
  return
fi

if ! type rustup > /dev/null 2>&1; then
  echo "rustup not found"
  read "yn?Install rustup? [y/n]"
  case $yn in
    [Yy]* ) ;;
    [Nn]* ) __eecho "you need rustup"; break;;
    * ) __eecho "Please answer y or n."; break;;
  esac
  winget install rustup
fi


