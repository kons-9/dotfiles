#Requires AutoHotkey v2.0

; Win + E キーに対してイベントを設定
#e::
{
    ; 起動するアプリケーションのパス
    appPath := "C:\Users\0108412465\tools\Alacritty-v0.15.1-portable.exe"
    appTitle := "MainAlacritty"

    ; アプリケーションが既に実行中か確認
    if (IsAppRunning(appTitle)) {
        ; アプリケーションがアクティブか確認
        if (WinActive(appTitle)) {
            ; アクティブなら最小化
            WinMinimize(appTitle)
        } else {
            ; 非アクティブならアクティブ化
            WinActivate(appTitle)
        }
    } else {
        ; アプリケーションが起動していなければ、HTTPリクエストで準備
        statusUri := "http://uri/status"
        enableUri := "http://uri/enable"
        
        ; 状態確認
        status := GetHttpResponse(statusUri)
        
        ; 状態がOKでない場合、ENABLEを実行
        if (status != "OK") {
            PostHttpRequest(enableUri)
        }
        
        ; アプリケーションを起動
        Run(appPath)
    }
}

; アプリケーションが実行中か確認する関数
IsAppRunning(appTitle) {
    ; アプリケーションのウィンドウが存在するかチェック
    return WinExist(appTitle) != 0
}

; GET リクエストを送信する関数
GetHttpResponse(uri) {
    return "OK"
    ; HTTPオブジェクトを作成
    ; http := ComObjCreate("MSXML2.XMLHTTP.6.0")
    ; http.Open("GET", uri, false)
    ; http.Send()
    
    ; レスポンスを取得
    ; return http.ResponseText
}

; POST リクエストを送信する関数
PostHttpRequest(uri) {
    ; HTTPオブジェクトを作成
    ; http := ComObjCreate("MSXML2.XMLHTTP.6.0")
    ; http.Open("POST", uri, false)
    ; http.Send()  ; 必要に応じてデータを送信（例: http.Send("param=value")）
}
