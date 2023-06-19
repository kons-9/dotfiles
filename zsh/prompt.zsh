# git prompt
setopt PROMPT_SUBST
RPROMPT='%*'
RPROMPT='$GITSTATUS_PROMPT'

function __virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`')'
}

function __git_status_info {
  [ ${GITSTATUS_PROMPT} ] && echo '('${GITSTATUS_PROMPT}')'
}

function precmd {
PROMPT="%F{green}%n@%m: %F{yellow}%~%f
$(__virtualenv_info)$(__git_status_info)%F{white}%%%f "
}
