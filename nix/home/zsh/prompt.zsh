# git prompt
setopt PROMPT_SUBST

function __virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function __git_status_info {
    [ ${GITSTATUS_PROMPT} ] && echo '['${GITSTATUS_PROMPT}']'
}

function makeprompt {
PROMPT="%F{green}%n@%m[`uname`]: %F{yellow}%~%f $(__git_status_info) [%*]
$(__virtualenv_info)%F{white}%%%f "
RPROMPT=''
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd makeprompt
