vim.cmd[[
  set runtimepath+=/home/kons/im_control.vim-master
  
  " 「日本語入力固定モード」の動作モード
  let IM_CtrlMode = 1
  " 「日本語入力固定モード」切替キー
  inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
  
  " IBus 1.5以降
  function! IMCtrl(cmd)
    let cmd = a:cmd
    if cmd == 'On'
      let res = system('ibus engine "mozc-jp"')
    elseif cmd == 'Off'
      let res = system('ibus engine "xkb:jp::jpn"')
    endif
    return ''
  endfunction
  
  " <ESC>押下後のIM切替開始までの反応が遅い場合はttimeoutlenを短く設定してみてください。
  " IMCtrl()のsystem()コマンド実行時に&を付けて非同期で実行するという方法でも体感速度が上がる場合があります。
  set timeout timeoutlen=3000 ttimeoutlen=100 
]]
