# read .zsh_update and get date of last update
last_update=`cat $ZDOTDIR/generated/zsh_update`
now=`date +%Y%m%d`
# compare date and if today >= last_update + 1day, update
if [[ $now -ge $((last_update + 1)) ]]; then
    echo "updating zsh setting"
    echo `cd $ZDOTDIR && git pull --all` 1> /dev/null
    echo $now > $ZDOTDIR/generated/zsh_update
fi
