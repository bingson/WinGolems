 ShowPopup(msg, ctn = "000000", wn = "400", hn = "75", drtn = "-800"
    , fsz = "16", fwt = "610", w_color = "ffffff", fnt = "Gaduigi") {

    global config_path
    Gui, PopUp: destroy
    
    Gui, PopUp: New

    IniRead, CB_WinID, %config_path%, %A_ComputerName%, CB_GUI_hwnd
    if WinExist("ahk_id " CB_WinID) 
        Gui, PopUp:+Owner2

        Gui, -Caption
    Gui, font ,s%fsz% W%fwt%, %fnt%
    Gui, PopUp: Add, Text, c%ctn% xm ym-1 Center, %msg%
    Gui, PopUp: Color, %w_color%
    GetGUIWinCoords(GUI_X, GUI_Y)
    Gui, PopUp: Show, Autosize,   
    Gui, PopUp: Show, % "x" GUI_X " y" GUI_Y
    Gui, PopUp: +LastFound +AlwaysOnTop
    SetTimer TimeOut, %drtn%
    return  
    
    TimeOut:
        SetTimer TimeOut, Off
        Gui PopUp: Destroy
        Return

    PopUpGuiEscape:
    PopUpGuiClose:
    PopUpCancel_Button:
        Gui PopUp: Destroy
        return
 }
