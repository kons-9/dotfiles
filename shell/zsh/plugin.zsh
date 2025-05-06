# a file which is called by .zshrc has argument, so we need to flush it because gitstatus use it, and this feature is unexpected.
# check if sheldon can be executed
if __is_command_available sheldon; then
    1=
    eval "$(sheldon source)"
fi
