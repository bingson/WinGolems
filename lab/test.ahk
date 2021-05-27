
Test_Autoexecution:



return ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


















MoveJupyterCMDWindow() {
    if (WinExist("ahk_class ConsoleWindowClass") and WinExist("jupyter"))
        WinActivate
    sleep, long
    MoveWindowToOtherDesktop()
}

:*:_>::&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:*:&>:: &nbsp; 
/* -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

; :*:gpt<::
    ; :*:gg_pt<::
    { 
        send {shift down}{home}{shift up}
        var := clip()
        string_array := StrSplit(var, ",")
        data := trim(string_array[1])
        x    := trim(string_array[2])
        y    := trim(string_array[3])
        clip("ggplot(" data ", aes(" x ", " y ")) +`r"
        . "    geom_point()")
        ; clip("ggplot(data = " data ", mapping = aes(x = " x ", y = " y ")) +`r"
        ; . "    geom_point()")
        return
    }



