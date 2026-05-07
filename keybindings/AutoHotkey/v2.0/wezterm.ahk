#Requires AutoHotkey v2.0

; Win+E: WezTerm をトグル起動 (起動/アクティブ化/最小化)
#e::
{
    appExe := "wezterm-gui.exe"

    if !ProcessExist(appExe) {
        Run(appExe)
        WinWait("ahk_exe " appExe)
        WinActivate("ahk_exe " appExe)
        return
    }

    if WinActive("ahk_exe " appExe) {
        WinMinimize("ahk_exe " appExe)
    } else {
        WinActivate("ahk_exe " appExe)
    }
}

