mkdir -p $ZDOTDIR/generated

if [[ ! -f $ZDOTDIR/generated/zshrc.local ]]; then
    touch $ZDOTDIR/generated/zshrc.local
    nvim $ZDOTDIR/generated/zshrc.local
fi

if [[ ! -f $ZDOTDIR/generated/zsh_update ]]; then
    now=`date +%Y%m%d`
    echo `cd $ZDOTDIR && git pull --all` > /dev/null 
    echo $now > $ZDOTDIR/generated/zsh_update
fi

# whether initialized or not
# if .initialized does not exist, initialize
if [[ ! -f $ZDOTDIR/generated/initialized ]]; then
  touch $ZDOTDIR/generated/initialized
  read "yn?want to initialize automatically? [y/N]"
  case "$yn" in
    [yY]*) 
        __execute ../start.zsh
        # restart zsh
        exec zsh -l
    ;;
    *) 
        echo "you should initialize manually."
        ;;
  esac
fi
