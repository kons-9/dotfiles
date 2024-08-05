# if this distro is arch and the display is not set and the tty is tty1 and the session type is tty
if [[ -f /etc/arch-release ]]; then
    if [[ -z $DISPLAY && $(tty) == /dev/tty1 && $XDG_SESSION_TYPE == tty ]]; then
        # gnome
        MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
        # sway
        # exec dbus-run-session sway
    fi
fi
