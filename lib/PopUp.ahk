 PopUp(msg, w_color = "F6F7F1", ctn = "000000", wn = "500", hn = "75", drtn = "-600"
    , fsz = "16", fwt = "610", fnt = "Gaduigi") {
    WinGetPos, winX, winY, winWidth, winHeight, A
    ; WinGetTitle, Title, A
    global config_path, C, CB_hwnd
    Gui, PopUp: destroy
    Gui, PopUp: New
    ; IniRead, CB_WinID, %config_path%, %A_ComputerName%, CB_hwnd
        
    if WinExist("ahk_id " CB_hwnd) 
        Gui, PopUp:+Owner2                                                      ; PopUp always on top of command box

    Gui, -Caption                                                               ; To remove the border and title bar from a window with a transparent background, use the following after the window has been made transparent:
    Gui, font ,s%fsz% W%fwt%, %fnt%
    Gui, PopUp: Add, Text, c%ctn% xm ym-1 Center, %msg%
    Gui, PopUp: Color, %w_color%
    GetGUIWinCoords(GUI_X, GUI_Y)                                               ; get coordinates for positioning PopUp in center of screen
    GUI_Y := GUI_Y + (GUI_Y*0.85)                                               ; move y coordinate to bottom half of screen
    Gui, PopUp: Show, Autosize,   
    Gui, PopUp: Show, % "x" GUI_X " y" GUI_Y 
    Gui, PopUp: +LastFound +AlwaysOnTop
    SetTimer TimeOut, %drtn%
    return  
    
    TimeOut:
        SetTimer TimeOut, Off
        Gui, PopUp: Destroy
        ; WinActivate, %Title%
        Return

    PopUpGuiEscape:
    PopUpGuiClose:
    PopUpCancel_Button:
        Gui PopUp: Destroy
        WinActivate, %Title%
        return
 }
