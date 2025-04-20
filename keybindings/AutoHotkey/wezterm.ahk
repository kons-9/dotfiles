#e::
  ApplicationBinaryName=wezterm-gui.exe
  ApplicationBinaryPath="C:\Program Files\WezTerm\wezterm-gui.exe"

  ; process command return pid if the process is running
  Process, Exist, %ApplicationBinaryName%
  if ErrorLevel=0
  {
    Run, %ApplicationBinaryPath%, %A_WorkingDir%
    WinWait, ahk_exe %ApplicationBinaryName%
    WinActivate, ahk_exe %ApplicationBinaryName%
    Exit
  }

  WinGet, WinState, MinMax, ahk_exe %ApplicationBinaryName%
  if WinState=-1
  {
    WinActivate, ahk_exe %ApplicationBinaryName%
  }
  else
  {
    IfWinActive ahk_exe %ApplicationBinaryName%
    {
      WinMinimize, ahk_exe %ApplicationBinaryName%
    }
    else
    {
      WinActivate, ahk_exe %ApplicationBinaryName%
    }
  }

  Return

