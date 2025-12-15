mkdir -p $ZDOTDIR/generated
GENERATED_DIR="$ZDOTDIR/generated"

if [[ ! -f $GENERATED_DIR/zshrc.local ]]; then
    touch $GENERATED_DIR/zshrc.local
    nvim $GENERATED_DIR/zshrc.local
fi

if [[ ! -f $GENERATED_DIR/zsh_update ]]; then
    now=`date +%Y%m%d`
    echo `cd $ZDOTDIR && git pull --all` > /dev/null 
    echo $now > $GENERATED_DIR/zsh_update
fi

# whether initialized or not
# if .initialized does not exist, initialize
if [[ ! -f $GENERATED_DIR/initialized ]]; then
  touch $GENERATED_DIR/initialized
  read "yn?want to initialize automatically? [y/N]"
  case "$yn" in
    [yY]*) 
        __execute initialize.zsh
        # restart zsh
        exec zsh -l
    ;;
    *) 
        echo "you should initialize manually."
        ;;
  esac
fi
