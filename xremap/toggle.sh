# % gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List
# ('[{"in_current_workspace":true,"wm_class":"firefox","wm_class_instance":"firefox","pid":2233,"id":165505183,"frame_type":0,"window_type":0,"focus":false},{"in_current_workspace":true,"wm_class":"org.wezfurlong.wezterm","wm_class_instance":"org.wezfurlong.wezterm","pid":1747,"id":165505181,"frame_type":0,"window_type":0,"focus":true}]',)
#
# % gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Minimize 165505181

TERMINAL_BIN="${1}"
NAME_WINDOW_SEARCH="${2}"

if [[ -z ${TERMINAL_BIN} ]]; then
    TERMINAL_BIN="wezterm"
fi
if [[ -z ${NAME_WINDOW_SEARCH} ]]; then
    NAME_WINDOW_SEARCH="org.wezfurlong.wezterm"
fi
# init
function init() {
    zsh -c "${TERMINAL_BIN}" &
}

function get_window_id() {
    local get_command="gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | cut -c 3- | rev | cut -c4- | rev | jq -c '[.[] | select (.wm_class == \""$NAME_WINDOW_SEARCH"\") | {id: .id}]'"
    local window_id_json=$(eval ${get_command})

    # if none, init
    if [[ $(echo ${window_id_json} | jq -r ". | length") -eq 0 ]]; then
        init
        window_id_json=$(eval ${get_command})
    fi

    # check if there is only one window
    if [[ $(echo ${window_id_json} | jq -r ". | length") -eq 1 ]]; then
        local window_id=$(echo ${window_id_json} | jq -r ".[0].id")
        echo ${window_id}
    else
        #error
        echo ""
    fi
}

function is_focused() {
    local id=${1}
    local focus_command=$(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Details ${id})
    local window_focus_json=$(echo ${focus_command} | cut -c 3- | rev | cut -c4- | rev | jq -r ".focus")
    if [[ ${window_focus_json} == "true" ]]; then
        echo 1
    else
        echo 0
    fi
}

function toggle() {
    local window_id=$(get_window_id)
    if [[ -z ${window_id} ]]; then
        return
    fi
    local is_focused=$(is_focused ${window_id})

    if [[ ${is_focused} -eq 1 ]]; then
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Minimize ${window_id}
    else
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.Activate ${window_id}
    fi
}

toggle

