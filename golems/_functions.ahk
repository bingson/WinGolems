; COLOR CODES___________________________________________________________________

  lgreen := "CEDFBF", lblue := "BED7D6", lyellow := "FCE28A", lpurple := "CDC9D9" 
  black  := "000000", white := "FFFFFF", red     := "FF0000", green   := "107A40"
  navy   := "000080", blue  := "0000FF", purple  := "800080", lbrown  := "DFD0BF"                    
  bgreen := "29524A", pink  := "F6E1E0", bwhite  := "F6F7F1", lorange := "FFDEAD"
  dblue  := "0A244C", rblue := "165CAA", pbrown  := "D4C4B5", dgrey   := "A9A9A9" 

; WINDOW MANAGEMENT ____________________________________________________________
 
 MaximizeWin(){
    WinMaximize,A 
 }

 RestoreWin(){
    ;WinGetClass, res, A
    Send #{down} 
 }

 moveWinBtnMonitors() {
    Sendinput +#{Left}
    CursorFollowWin()
    return
 }

 MoveWindowToOtherDesktop(n = "2") {
    vd_init()
    wintitleOfActiveWindow:="ahk_id " WinActive("A")
    VD_sendToDesktop(wintitleOfActiveWindow,n,0,0)                               ; VD_sendToDesktop(wintitle,whichDesktop, followYourWindow := false, activate := true)
    return 
 }
 
 TitleTest(tab_name="MISC.txt", exact = False) {
    ; checks if tab_name occurs somewhere in the window title
    if exact 
    {
        SetTitleMatchMode, 3
        return % WinActive(tab_name)
    }
    SetTitleMatchMode 2
    WinGetActiveTitle, title
    return % InStr(title, tab_name)
 }

 ActivateWindow(title="Chrome") {
    SetTitleMatchMode, 2                                                         ; match anywhere in title
    IfWinExist, %title%
        WinActivate, %title%
    return
 }

 SaveWinID(key = "L") {
    global config_path, lgreen,  bgreen
    WinID_%key% := WinExist("A")
    IniWrite, % WinID_%key%, %config_path%, %A_ComputerName%, WinID_%key%
    ShowPopup("WinID " key " saved", bgreen, "300", "60", "-1000", "16", "610", lgreen)
    return
 }

 ActivateWinID(key = "L") {
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, WinID_%key%
    ActivateWindow("ahk_id" output)
    CursorFollowWin()
    return
 }

 CloseAllPrograms() {
    ; close all open programs (used before system shutdown)
    WinGet, id, list, , , Program Manager
    Loop, %id%
    {
        StringTrimRight, this_id, id%a_index%, 0
        WinGetTitle, this_title, ahk_id %this_id%
        winclose,%this_title%
    }
    Return
 }

 CloseClass() {
    ; close all instances of active program
    WinGetClass class, A
    GroupAdd    grp, ahk_class %class%
    WinClose    ahk_group grp
    return
 }

 AlwaysOnTop(state = "OFF") {
    ; toggle active window to be always on top
    global bgreen, red, lgreen, pink
    WinGet, Process_Name, ProcessName, A
    WinGetTitle, Title, A
    WinGetClass, class, A
    if (state = "ON") {
        Winset, Alwaysontop, ON , A
        ShowPopup(Process_Name "`nalways on top: ON", bgreen,"250","120", "-800",,,lgreen)
    } else {
        Winset, Alwaysontop, OFF , A                                            
        ShowPopup(Process_Name "`nalways on top: OFF", red,"250","120","-800",,,pink)
    }
    return
 }

 ActivatePrevInstance() {
    ; activate newest instance of active program if multiple instances exist
    WinGetClass, ActiveClass, A
    WinGet,      p_name,      ProcessName , ahk_class %ActiveClass%
    WinGet,      n_instances, List,         ahk_class %ActiveClass%

    if (n_instances > 1)
    {
        WinSet, Bottom,, A
        WinActivate, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,
    }
    CursorFollowWin()
    return
 }

 ActivateNextInstance() {
    ; activate oldest instance of active program if multiple instances exist
    WinGetClass, ActiveClass, A
    WinGet,      p_name,      ProcessName , ahk_class %ActiveClass%
    WinGet,      n_instances, List,         ahk_class %ActiveClass%

    if (n_instances > 1)
        WinActivateBottom, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,
    CursorFollowWin()
    return
 }
 
; SYSTEM APPS __________________________________________________________________

 ActivateExplorer := Func("ActivateApp").Bind("explorer.exe")

 CloudSync(state="ON") {
    ; Turn ON/OFF google cloud sync
    global med, bgreen, lblue, pink, lgreen, lpurple, purple, config_path 
    IniRead, ini_app_path, %config_path%, %A_ComputerName%, sync_path
    RegExMatch(ini_app_path, "[^\\]+$", exe_name)

    if (state = "ON") {
        try {
            ActivateApp("sync_path")
            ShowPopup("cloud sync initiated",bgreen,"300", "75", "-3000",,,lgreen)
            return
        } catch e {
            msgbox can't open cloud cloud sync app.
        }
    } else {
        if WinExist("ahk_exe " exe_name){
            WinClose, ahk_exe %exe_name%
            ShowPopup("closing cloud sync", "FF0000", "300", "75", "-3000",,,lred)
        } else {
            ShowPopup("cloud sync not running",purple , "300", "75", "-3000",,,lpurple)
        }
        return
    }
 }

 ActivateCalc() {
    ; activate windows calculator app
    global winpath
    IfWinNotExist,  Calculator
        run, %winpath%\system32\calc.exe
    else
    {
        WinGet, CalcIDs, List, Calculator
        If (CalcIDs = 1)                                                        ; Calc is NOT minimized
            CalcID := CalcIDs1
        else
            CalcID := CalcIDs2                                                  ; Calc is Minimized use 2nd ID
        winActivate, ahk_id %CalcID%
    }
    return
 }

 ActivateMail() {
    ; activate windows mail app
    IfWinExist, Inbox - Gmail
        WinActivate                                                             ; use the window found above
    else
        Run % A_ScriptDir "\assets\win\Mail.lnk"
    return
 }

 TskMgrExt() {
    global med
    sleep, med * 2
    WinMaximize,A
    CursorFollowWin()                                                           
    return
 }

 DisplaySettings() {
    Run explorer.exe ms-settings:display
 }

 BluetoothSettings() {
    Run explorer.exe ms-settings:bluetooth
 }

 SoundSettings() {
    Run explorer.exe %A_WinDir%\system32\mmsys.cpl
 }

 OpenHotStringLog() {
   Run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv
 }

 NotificationWindow() {
    Send {lwin down}a{lwin up}
 }

 RunProgWindow() {
    Send {lwin down}r{lwin up}
 }

 StartContextMenu() {
    Send {lwin down}x{lwin up}
 }

 QuickConnectWindow() {
    send {lwin down}k{lwin up}
 }

 WindowsSettings() {
    Send {lwin down}i{lwin up}
 }

 PresentationDisplayMode() {
    Send {lwin down}p{lwin up}
 }

 KeyHistory() {
    KeyHistory
 }

 StartMenu() {
    send ^{esc}
 }

 Windowspy() {
    run, golems\WindowSpy.ahk
 }
 
 ExitAHK() {
    ExitApp
 }
 
 WinMaximize(isHold, taps, state) {
    if (taps > 1)
        WinMaximize,A
 }

 ActivatePrevInstanceTHM(isHold, taps, state) {
    if (taps > 1)
        ActivatePrevInstance()
 }

 WinClose(isHold, taps, state) {
    if (taps > 1)
        WinClose,A
 }

 WinMinimize(isHold, taps, state) {
    if (taps > 1)
        WinMinimize,A
 }

 FileJumpList(isHold, taps, state) {
    global File_DICT
    % (taps > 1) ? FunctionBox("EditFile", File_DICT, "EDIT FILE") : ""
 }

 FolderJumpList(isHold, taps, state){
    global Folder_DICT, ActivateExplorer
    % (taps > 1) ? FunctionBox(ActivateExplorer, Folder_DICT, "OPEN FOLDER") : ""
 }

 WinJumpList(isHold, taps, state){
    global Command_DICT, Command_TOC
    % (taps > 1) ? FunctionBox(, Command_DICT, "RUN SYS COMMAND", Command_TOC) : ""
 }

; COMMAND BOX / JUMPLISTS ______________________________________________________

 CB( sfx = "~win", w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand") {
    global config_path
    SetTitleMatchMode, 2
    IniRead, output, %config_path%, %A_ComputerName%, CB_GUI_hwnd
    DetectHiddenText, On
    if WinExist("ahk_id " . output) 
        WinActivate, % "ahk_id " . output
    else
        CommandBox(sfx, w_color, t_color, ProcessMod) 
    DetectHiddenText, off
    return

 }

 CreateCacheList(name = "cc") {
    Global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
    Global strDir  := A_ScriptDir . "\mem_cache\"
    FileDelete %strFile%
    Global cacheList := ""
    global config_path
    IniWrite, %name%, %config_path%, %A_ComputerName%, CB_display
    
    max_len := count := 0
    Loop Files, %strDir%*.txt, R  ; Recurse into subfolders.
    {   
        file := SubStr(A_LoopFileFullPath, strlen(strDir) + 1) . "`n"
        count := count + 1
        cacheList .= file
        max_len := max(strlen(file), max_len)
    }
    halfCount := round(count/2,0) + 1
    arr := StrSplit(cacheList , "`n","`n",halfCount)
    right_arr := arr.Pop()
    Rarr := StrSplit(right_arr, "`n", "`n")
    cache_contents := ""
    char_width := 0
    loop % halfCount
    {
        space_len  := (max_len - strlen(arr[A_Index]))  
        s := RepeatString(" ", space_len)
        line := arr[A_Index] . s . Rarr[A_Index] . "`n" 
        cache_contents .= line
        char_width := max(strlen(line), char_width)

    }
    cache_contents := "CACHE CONTENTS`n" . RepeatString("-", char_width) . "`n`r" . cache_contents
    ; FileAppend, %cache_contents%, mem_cache\%name%.txt
    return % cache_contents
 }

 GUISubmit() {
    global short, med, long
    ; BlockInput, on
    GuiControl,2: Focus, UserInput
    Send {enter}
    ; BlockInput, off
    ; ReleaseModifiers()
    return
 }
 
 GUIRecall() {
    global short, med, long, config_path
    IniRead, OutputVar, %config_path%, %A_ComputerName%, last_user_input,%A_Space%
    GuiControl,2: Focus, UserInput
    sendinput {home}+{end}
    clip(OutputVar)
    sendinput {home}+{end}
    return
 }

 GUIFocusInput() {
    Gui, +LastFound
    Gui, show
    GuiControl,2: Focus, UserInput
    sendinput {home}+{end}
    return
 }
 
 UDSelect(d="down", interval = "5", c_input = "", select = True, multi_cursor = False, letter = "jk") {
    global med
    sleep med
    RegExMatch(c_input, "([0-9]+)", num)
    RegExReplace(c_input, "i)[" letter "]", "", oCount)
    n := num ? num : interval
    n := n + (oCount * interval)
    test := n + (oCount * interval)
    Switch  
    {
        Case Instr(c_input, "!"):
            sendinput % "+{" . d . " " . n . "}{del}"
        case multi_cursor, Instr(A_ThisHotkey, "Printscreen"):
            sendinput % "+^!{" . d . " " . n . "}"                              ; multi cursor selection for VScode
        Default:
            sendinput % select  
                    ? "+{" . d . " " . n . "}"
                    : "{" . d . " " . n . "}"
    }
    return
 }

 UpdateGUI(new_txt = "" , old_title = "", new_hist = "") {
     global config_path, med
     Gui,+LastFound
     GuiControl, 2:, CB_Display, %new_txt%
     RegExMatch(old_title, ".*(?= )", v)                                        ; get everything before the last space and store in v
     Gui, 2: Show, , %v% %new_hist%
     ;  sleep med
     IniRead, gui_position, %config_path%, %A_ComputerName%, gui_position, Center
     wdth := StrSplit(gui_position, " ")[3]
     GuiControl, MoveDraw, CB_Display, %wdth%                                       ; set the width to the edit box to value stored in ini file
     GuiControl, MoveDraw, UserInput, %buttonH%                                       ; set the width to the edit box to value stored in ini file
     GuiControl, MoveDraw, Enter_Button, %buttonH%                                       ; set the width to the edit box to value stored in ini file
     Gui, 2: show, %gui_position%                                               ;  Gui, 2: show, hide AutoSize
     return
 }
 
 countrows(txt) {
    loop, parse, txt, `n, `r
        max := A_Index
    return %max%
 }

 CheckExt(cache_file) {
    RegExMatch(cache_file, "[^.]+$", ext)
    if (ext != "txt")
        cache_file .= ".txt"
    return cache_file
 }

 FunctionBoxGUI(TOC, title, w_color ="CEDFBF", t_color = "000000" ) {
    Gui, +LastFound +OwnDialogs +AlwaysOnTop
    Gui, Destroy
    global UserInput := ""
    Gui, New, ,%title%
    Gui, font,s13 , calibri
    Gui, Add, text, xp yp+10 c%t_color%, % TOC "`n"
    Gui, Add, Edit, w120 vUserInput
    Gui, Add, Button, W60 X+10 Default gButtonOK, OK
    Gui, Add, Button, W60 X+5 gButtonCancel, Cancel
    Gui, font,s8 , calibri
    Gui, add, text, xs yp+30, case insensitive
    Gui, +LastFound +OwnDialogs +AlwaysOnTop
    GetGUIWinCoords(GUI_X, GUI_Y)
    Gui, Color, %w_color%
    Gui, Show, % "x" GUI_X " y" GUI_Y,                                          ; Show gui at center of current screen
    Gui, +LastFound
    WinWaitClose                                                                ; WinSet, Transparent , 255, ahk_id %GUI_Hwnd%
    return

    ButtonOK:
       Gui, Submit
       Gui, Destroy
       return
   
    GuiClose:
    ButtonCancel:
    GuiEscape:
       UserInput := ""
       Gui, Destroy
       return
 }
 
 BuildTOC(arr = "", groups = False) {
    ; buils a table of contents string created from a dictionary input array.
    ; alt_arr tells function that 
    arr_KV_swapped := {}                                                        ; key value swapped version of input array
    max_str_len := 0
    arr := alt_arr ? alt_arr : arr

    for key, val in arr                                                         ; this loop cleans dictionary values and creates a key:value swapped
    {                                                                           ; version of the array (to display TOC sorted by value instead of key)
        RegExMatch(val, "[^\\]+$", selection)
        selection := ReplaceAwithB(,,selection, False)                          ; replace consecutive bank spaces with 1 space
        arr_KV_swapped[selection] := key
        max_str_len := max(max_str_len, strlen(key . selection))
    }
    line := RepeatString("-", max_str_len * 1.35)
    TOC := "Key`tSelection`n-----`t" line "`r"
    For dest, ref in arr_KV_swapped
    {
        if groups {
            prefix := substr(dest, 1, 3)
            if (prefix <> prev_prefix and prev_prefix and prefix) {             ; adds blank line between changes in selection group prefix 
                TOC .= "`n" 
            }
            prev_prefix := prefix
        }
        TOC .= (TOC <> "" ? "`n" : "") ref "`t" rtrim(dest, """")
    }
    return TOC
 }
 
; MEM_CACHE / CREATE HOTSTRING SNIPPET__________________________________________

 WriteToCache(key, del_toggle = False, mem_path = "", input = "", append = false) {
    ; creates a txt file in \mem_cache from selected text
    global lgreen
    
    if !input
        input := clip()                                                         ; captures selected text if no input given

    if (trim(input) = "") {
                                
    } else {
        if !append
            FileDelete, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
        FileAppend, %input%, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
        ShowPopup("Written to `n" key,,"200",,,,,lgreen)
    }
    if (del_toggle = TRUE)
        send {del}
    return
 }

 AccessCache(key, mem_path = "", paste = True) {
    ; paste contents of mem folder txt file or assign to variable
    max_str_len := 0

    FileRead, output, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
    ; msgbox %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
    output := rtrim(output, "`t`n`r")
    if !paste {
        return %output%
    } 
    clip(output)                                                                ; clip(output, True)
    return
 }

; AHK UTILITIES ________________________________________________________________
 
 SelectText( ControlID, start = 0, end = -1) {
    ; EM_SETSEL = 0x00B1
    SendMessage, 0xB1, start, end,, ahk_id %ControlID%
    return (ErrorLevel != "FAIL")
 }

 GetGUIWinCoords(ByRef GUI_X, ByRef GUI_Y) {
    CurrentMonitorIndex := GetCurrentMonitorIndex()                             ; get current monitor index
    DetectHiddenWindows On                                                      ; get Hwnd of current GUI
    Gui +LastFound +OwnDialogs +AlwaysOnTop
    GUI_Hwnd := WinExist()
    Gui, Show, Hide
    GetClientSize(GUI_Hwnd,GUI_Width,GUI_Height)                                ; Calculate size of GUI
    ; msgbox % GUI_Width
    DetectHiddenWindows Off
    GUI_X := CoordXCenterScreen(GUI_Width, CurrentMonitorIndex)                 ; Calculate where the GUI should be positioned
    GUI_Y := CoordYCenterScreen(GUI_Height, CurrentMonitorIndex) 
    return 
 }

 GetCurrentMonitorIndex() {
    CoordMode, Mouse, Screen
    MouseGetPos, mx, my
    SysGet, monitorsCount, 80

    Loop %monitorsCount% {
        SysGet, monitor, Monitor, %A_Index%
        if (monitorLeft <= mx && mx <= monitorRight && monitorTop <= my && my <= monitorBottom){
            Return A_Index
        }
    }
    Return 1
 }

 CoordXCenterScreen(WidthOfGUI,ScreenNumber) {
    SysGet, Mon1, Monitor, %ScreenNumber%
    return (( Mon1Right-Mon1Left - WidthOfGUI ) / 2) + Mon1Left
 }

 CoordYCenterScreen(HeightofGUI,ScreenNumber) {
    SysGet, Mon1, Monitor, %ScreenNumber%
    return (Mon1Bottom - 30 - HeightofGUI ) / 2
 }

 GetClientSize(hwnd, ByRef w, ByRef h) {
    VarSetCapacity(rc, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
    w := NumGet(rc, 8, "int")
    h := NumGet(rc, 12, "int")
 }

 WriteToINI(section = "DESKTOP-T6USCO1", key = "cursor_follow", var = "") {
    global config_path, lgreen
    var := clip()
    ShowPopUp("config.ini updated",,,,-2000,,,lgreen)
    IniWrite, %var%, %config_path%, %section%, %key%
    return
 }

 CreateLabel(pfx = "", sfx ="", var = "") {
    var := !var ? clip() : var
    pf := (pfx != "!") ? RetrieveINI(A_ComputerName, pfx) : ""
    sf := RetrieveINI(A_ComputerName, sfx)
    var := pf . var . sf . ":"
    var := !pf ? var : (var . ":")
    clip(var)
    return
 }

 ActiveWinCoord() {
    ; returns an 1-D array with the bounding coordinates of the monitor the window is on.
    winHandle := WinExist("A")                                                  ; The window to operate on
    VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
    monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)
    DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo)
    Left      := NumGet(monitorInfo, 20, "Int")                                 ; Left
    Top       := NumGet(monitorInfo, 24, "Int")                                 ; Top
    Right     := NumGet(monitorInfo, 28, "Int")                                 ; Right
    Bottom    := NumGet(monitorInfo, 32, "Int")                                 ; Bottom
    return [Left, Top, Right, Bottom]
 }

 TimeCode() {
    ; time ahk code                                                             ; https://www.autohotkey.com/boards/viewtopic.php?t=45263
    Global StartTimer

    If (StartTimer != "")
    {
        FinishTimer := A_TickCount
        TimedDuration := FinishTimer - StartTimer
        StartTimer := ""
        Sec := round(TimedDuration/1000)
        MsgBox, % "around " . Sec . " sec have elapsed!`n"
        . "(" . round(TimedDuration) . " ms)"
        Return TimedDuration
    }
    Else
        StartTimer := A_TickCount
 }

 ConfigureWinGolems(config_path = "", apps*) {
    path := RetrieveINI(A_ComputerName, "editor_path")
    if (!FileExist(config_path) or path = "ERROR") {
        MsgBox,4132, WinGolems Setup, A valid configuration profile for this computer was not detected, would you like to create one?
        IfMsgBox Yes
        {
            CreateConfigINI(apps*)
        }
        else
        {
            ShowPopup("Warning WinGolems is not setup", "FF0000", "400", "75", "-1000", "16", "610", "ffffff")
            exit
        }
    }
 }

 CreateConfigINI(apps*) {
    global config_path, UProfile, med, bgreen, lgreen
    PATH := FindAppPath(apps*)
    IniWrite, % PATH[apps[1]], %config_path%, %A_ComputerName%, doc_path
    IniWrite, % PATH[apps[2]], %config_path%, %A_ComputerName%, xls_path
    IniWrite, % PATH[apps[3]], %config_path%, %A_ComputerName%, ppt_path
    IniWrite, % PATH[apps[4]], %config_path%, %A_ComputerName%, pdf_path
    IniWrite, % PATH[apps[5]], %config_path%, %A_ComputerName%, html_path
    IniWrite, % PATH[apps[6]], %config_path%, %A_ComputerName%, sync_path
    IniWrite, % PATH[apps[7]], %config_path%, %A_ComputerName%, editor_path
    IniWrite,141,              %config_path%, %A_ComputerName%, F_height
    IniWrite,415,              %config_path%, %A_ComputerName%, F_width
    IniWrite,lg.ico,           %config_path%, settings, starting_icon
    ShowPopup("Done!", bgreen, "200", "60", "-1000", "15",, lgreen) 
    sleep, med*2
    ClosePopup()
    return
 }

 FindAppPath(app*) {
    global UProfile, PF_x86
    FOLDER := [PF_x86 "\*",A_ProgramFiles "\*",UProfile "\AppData\Local\Programs\*"]
    PATH := {}
    for each, exe in APP
    {
        ShowPopup("Searching for " exe,,, "60", "-10000", "15")
        for each, dir in FOLDER
        {
            Loop Files, %dir%%exe%, R
            {
                RegExMatch(A_LoopFileFullPath, "[^\\]+$", file_name)
                if (strlen(exe) = strlen(file_name)) {                          ; Equal (=), case-sensitive-equal (==)
                    PATH[exe] := A_LoopFileFullPath
                }
            }
        }
    }
    return % PATH
 }

 RetrieveINI(section="passwords", key="b_Login", paste=False) {
    global config_path
    IniRead, output, %config_path%, %section%, %key%
    if (paste = True) {
        clip(output)
        return
    } else
        return %output%
 }

 SetTrayIcon(ico_file) {
    ; change tray icon
    IfExist, %ico_file%
    {
        Menu, Tray, Icon, %ico_file%
    }

 }

 ChangeTrayIcon(ico_path) {
    global config_path
    FileList := []
    FileCount := 0
    starting_icon := RetrieveINI("settings", "starting_icon")
    Loop, Files, %ico_path%*.ico
    {
        if (a_loopfileName != starting_icon) {
            FileCount += 1
            FileList[FileCount] := A_LoopFileName
        }
    }
    Random, rand, 1, %FileCount%
    ico_file_path := ico_path FileList[rand]
    ico_file := FileList[rand]
    SetTrayIcon(ico_file_path)
    IniWrite, %ico_file%, %config_path%, settings, starting_icon
    return
 }
 
 ClosePopup() {
    Progress, Off
    return
 }

 getMousePos() {
    MouseGetPos, xpos, ypos
    xy := "x" xpos " y" ypos
    ToolTip %xy%
    Clipboard := xy
    SetTimer toolTipClear, -3000
    return
 }

 tooltipClear() {
    ToolTip
    return
 }

 WinLLock(state = TRUE, supress = False) {
    ; state = TRUE enables Win+L to lock the workstation. (admin privilege req'd)
    ; False disables the Windows hook, enabling AHK to repurpose #l
    RegWrite, REG_DWORD, HKEY_CURRENT_USER
    , Software\Microsoft\Windows\CurrentVersion\Policies\System
    , DisableLockWorkstation, % !state
    global bgreen, red, lpurple 
    if !supress {
        if state
            ShowPopup("Win+L Lock: ON", bgreen,"200",, "-800")
        else
            ShowPopup("Win+L Lock: OFF", red,"200",, "-800",, lpurple)
    }
    return
 }

 GenerateHotkeyList() {
    ; generate a .txt list of all active hotkeys and hotstrings
    ; then opens that .txt in the default editor (config.ini)
    ReleaseModifiers()
    global long, med
    run %A_ScriptDir%\golems\Hotkey_Help.ahk                                    ; Run modified version of original script
    sleep, long * 2
    DetectHiddenWindows On                                                      ; Allows a script's hidden main window to be detected.
    SetTitleMatchMode 2
    WinClose %A_ScriptDir%\golems\Hotkey_Help.ahk
    Orig_File = %A_WorkingDir%\golems\HotKey Help - Dialog.txt
    TF_Replace(Orig_File, "$", "")
    Updated = %A_WorkingDir%\golems\HotKey Help - Dialog_copy.txt
    New_Location = %A_WorkingDir%\HotKey_List.txt
    FileMove, %Updated% , %New_Location%, 1
    SC_key_txt := AccessCache("sck",,False)
    SC_key_txt := StrReplace(SC_key_txt,"/* ")
    SC_key_txt := StrReplace(SC_key_txt,"E --", "E -- --")
    SC_key_txt := rtrim(StrReplace(SC_key_txt,"*/"),"`r`n`t")
    FilePrepend("HotKey_List.txt", SC_key_txt)
    sleep, long * 2
    EditFile("""" New_Location """")
    FileDelete, %Orig_File%
    return
 }

 ReleaseModifiers(timeout := "") {                                              ; timeout in ms
    ; sometimes modifier keys get stuck while switching between programs
    ; this function call can be embedded in a function to fix that.
    static  aModifiers := ["Ctrl", "Alt", "Shift", "LWin", "RWin"
                            , "PrintScreen"]

    startTime := A_Tickcount
    while (isaKeyPhysicallyDown(aModifiers))
    {
        if (timeout && A_Tickcount - startTime >= timeout)
            return 1                                                            ; was taking too long
        sleep, 5
    }
    return
 }

 isaKeyPhysicallyDown(Keys) {
    if isobject(Keys)
    {
        for Index, Key in Keys
        if getkeystate(Key, "P")
            return key
    }
    else if getkeystate(Keys, "P")
        return Keys ;keys!
    return 0
 }

; FILE AND FOLDER RELATED ______________________________________________________
 
 Explorer_GetSelection() {
    ; Get path of selected files/folders                                        ; https://www.autohotkey.com/boards/viewtopic.php?style=17&t=60403
    WinGetClass, winClass, % "ahk_id" . hWnd := WinExist("A")
    if !(winClass ~="Progman|WorkerW|(Cabinet|Explore)WClass")
        Return

    shellWindows := ComObjCreate("Shell.Application").Windows
    if (winClass ~= "Progman|WorkerW")
        shellFolderView := shellWindows.FindWindowSW(0, 0, SWC_DESKTOP := 8, 0, SWFO_NEEDDISPATCH := 1).Document
    else {
        for window in shellWindows
            if (hWnd = window.HWND) && (shellFolderView := window.Document)
            break
    }
    for item in shellFolderView.SelectedItems
        result .= (result = "" ? "" : "`n") . item.Path
    if !result
        result := shellFolderView.Folder.Self.Path
    Return result
 }

 ExpandCollapseAllGroups(){
    global med
    WinGetActiveStats, Title, Width, Height, X, Y
    CoordMode, Mouse, Screen 
    MouseGetPos, StartX, StartY
    sleep, med * 1.5
    RecallMousePosClick("FE_cg", "1", "right", 0) 
    ; sleep, med * 1.5
    ; MouseClick, right, % GetConfig("F_width"), % GetConfig("F_height")

    n := 0
    Loop {
        MouseGetPos,,,, fc
        Sleep, fc ? 25 : 0
    } Until !fc ||g_highlight ++n > 80

    Send % (Instr(A_ThisHotkey, "^") ? "u" : "g") "{Enter}"                     ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise
    sleep, short
    DllCall("SetCursorPos", int, StartX, int, StartY) 
    ; MouseMove StartX, StartY
    Return
 }

 SortByName() {
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    send !vo{enter}
    return
 }

 SortBySize() {
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    send !vo{Down}{Down}{Down}{enter}
    return
 }

 SortByType() {
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    send !vo{Down}{Down}{enter}
    return
 }

 ToggleInvisible() {
    send !v
    sleep, med
    send {h 2}
    return
 }

 SortByDate() {
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    send !vo{Down}{enter}
    return
 }

 DetailedView() {
    send {ctrl down}{shift down}6{ctrl up}{shift up}
    send {Ctrl Down}{NumpadAdd}{Ctrl up}
    return
 }

 ChangeFolder(path, sys_dependent = False) {
    ; this function instantiates a hotkey for changing the current folder
    ; in file explorer or windows "save as" type dialogue boxes
    if (sys_dependent = TRUE) {
        global config_path
        IniRead, true_path, %config_path%, %A_ComputerName%, %path%
        path := true_path
    }
    try
    {
        if  WinActive("ahk_exe explorer.exe")
        and WinActive("ahk_class CabinetWClass")
        {
            NavRun(path)
        }
        else                                                                    ; WinActive("ahk_class #32770") = class for "save" dialogue boxes
        {
            changeDialDir(path)
        }
        return
    }
 }

 changeDialDir(path) {
    ; change directory of "save as" dialogue box                                ; https://www.reddit.com/r/AutoHotkey/comments/ce8mu3/changing_folders_in_save_as_dialogue_with_com/
    WinGet, hWnd, ID, A                                                         ; Get handle of active window
    Send ^l
    ControlSetText, Edit2, %path%, ahk_id %hWnd%
    ControlSend, Edit2, {Enter}, ahk_id %hWnd%
 }

 GetActiveExplorer() {
    ; get file explorer window ID
    static objShell := ComObjCreate("Shell.Application")
    WinHWND := WinActive("A")                                                   ; Active window
    for Item in objShell.Windows
        if (Item.HWND = WinHWND)
            return Item
    return -1                                                                   ; No explorer windows match active window
 }

 NavRun(Path) {
    ; change file explorer current folder path                                  ; https://autohotkey.com/board/topic/102127-navigating-explorer-directories/
    try{
        if (-1 != objIE := GetActiveExplorer())
            objIE.Navigate(Path)
    } catch {
        Sleep, 0
        Run, % Path
    }
    return
 }

 MoveUpWorkingDir(n = 1) {
    ; returns a path string to the n-higher folder level
    loop %n%
        dirup%A_Index% := RegExReplace(A_ScriptDir, "(\\[^\\]+) {" A_Index "}$")
    return % dirup%n%
 }

 GetConfig(app_key = "F_height") {
    ; retrieves system dependent file explorer menu coordinates for
    ; collapsing/uncollapsing grouped views
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, %app_key%
    return %output%
 }

 ActivateApp(app_path = "", arguments = "", start_folder_toggle = False) {
    ; wrapper for ActivateOrOpen to process ini file path references
    ; and arguments
    global config_path
    if InStr(app_path , "_path")                                                ; "_path" string match indicates a config.ini path reference
    {
        IniRead, ini_app_path, %config_path%, %A_ComputerName%, %app_path%
        RegExMatch(ini_app_path, "[^\\]+$", exe_name)
        ActivateOrOpen(exe_name, ini_app_path, arguments)
    }
    else if app_path in cmd.exe,explorer.exe
    {
        if InStr(arguments , "_path") {
            IniRead, arguments, %config_path%, %A_ComputerName%, %arguments%
        }
        ActivateOrOpen(app_path,,arguments, start_folder_toggle)    ; only compatible options are file explorer or command window
    }
    else
    {
        RegExMatch(app_path, "[^\\]+$", exe_name)
        ActivateOrOpen(exe_name, app_path, arguments)
    }
 }

 ActivateOrOpen(exe_name, app_path = "", arguments = "", start_folder_toggle = False) {
    ; opens application located at app_path or activates application (brings to top) if underneath
    ; other windows

    global med 
    if (exe_name = "explorer.exe") {
        RegExMatch(arguments, "[^\\]+$", win_title)
        grp_ID := (start_folder_toggle)
                ? "ahk_class CabinetWClass ahk_exe " exe_name                   ; after start folder first opening, make #b key activate last explorer window
                : win_title " ahk_class CabinetWClass ahk_exe " exe_name
    } else {
        grp_ID := arguments "ahk_exe " exe_name
    }
    WinGet, wList, List, %grp_ID%
    if !wList 
    {
        app_path := (exe_name = "explorer.exe" or exe_name = "cmd.exe") ? exe_name : app_path  ; cmd.exe and explorer.exe do not need filepaths
        try {
            RunAsUser(app_path, arguments, A_ScriptDir)
        }

    } else {
        WinActivate, % "ahk_id " wList1
    }
    sleep med
    CursorFollowWin()
    return
 }

 ActivateEnv(key) {
    ; retrieves anaconda environment dependent on the system
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, %key%
    clip("activate " output)
    return
 }
 
 EditFile(file_path = "master.ahk", app_path = "editor_path") {
    ; opens or activates file in windows 10
    global config_path
    RegExMatch(file_path, "[^\\]+$", file_name)                                 ; file_name = everyting after the last \
    file_name := rtrim(file_name,"""")
    RegExMatch(file_name, "[^.]+$", ext)                                        ; ext = everything after the last .
    try
    {
        if WinExist(file_name)
        {
            WinActivate
        }
        else if ext in docm,doc,docx,dotx,dotm
        {
            oWord := ComObjCreate("Word.Application")
            oWord.Visible := True
            oWord.Documents.Open(file_path)
        }
        else if ext in xlsx,xlsm,xltx,xltm
        {
            oExcel := ComObjCreate("Excel.Application")
            oExcel.Visible := True
            oExcel.Workbooks.Open(file_path)
        }
        else if ext in ppt,pptx,pptm
        {
            oPowerPoint := ComObjCreate("PowerPoint.Application")
            oPowerPoint.Visible := True
            oPowerPoint.Presentations.Open(file_path)
        }
        else if ext in pdf
        {
            
            IniRead, prog_path, %config_path%, %A_ComputerName%, pdf_path
            RunAsUser(prog_path, file_path, A_ScriptDir)
        }
        else
        {
            IniRead, prog_path, %config_path%, %A_ComputerName%, %app_path%
            RunAsUser(prog_path, file_path, A_ScriptDir)
        }
        return
    }
    catch
    {
        MsgBox, can't open unrecognized filetype
    }
    return
 }

 OpenFolder(folder_path = "") {
    RunAsUser("explorer.exe", folder_path, A_ScriptDir)
    return
 }

 FilePrepend(filename, atext) {
    FileRead fileContent, % filename
    FileDelete % filename
    FileAppend % atext . "`n" . filecontent, % filename
 }
 

; MOUSE FUNCTIONS_______________________________________________________________
 
 ClickSaveMousePos(key = "A", n = "1") {
    global config_path
    ; CoordMode, Mouse, Screen
    CoordMode, Mouse, Screen
    Clicks(n)
    MouseGetPos, StartX, StartY
    IniWrite,%StartX% %StartY%, %config_path%, %A_ComputerName%, MousePos_%Key%
    return
 }
 
 RecallMousePosClick(key = "A", n = "1", lrm = "left", rtn_mouse = True) {
    global config_path
    CoordMode, Mouse, Screen
    MouseGetPos, StartX, StartY
    IniRead, mpos, %config_path%, %A_ComputerName%, MousePos_%Key%
    pos_array := StrSplit(mpos, " ")
    DllCall("SetCursorPos", int, pos_array[1], int, pos_array[2]) 
    ; MouseMove, pos_array[1], pos_array[2]
    Clicks(n, lrm)
    if rtn_mouse
        MouseMove, StartX, StartY
    return
 }


 TglCursorFollowWin() {
    global config_path, red, bgreen, pink, lgreen     
    IniRead,  state,    %config_path%, %A_ComputerName%, cursor_follow, 0
    IniWrite, % !state, %config_path%, %A_ComputerName%, cursor_follow
    if !state
        ShowPopup("Cursor Follows Active Window: ON", bgreen,"300","90", "-800",,,lgreen)
    else if state
        ShowPopup("Cursor Follows Active Window: Off", red,"300","90", "-800",,,pink)
    return
 }

 CursorFollowWin(Q = "BR", offset_x = "-100", offset_y = "-100") {
    global config_path
    IniRead, state, %config_path%, %A_ComputerName%, cursor_follow, 0
    if state
        CursorJump(Q, offset_x, offset_y)
    return
 }

 Clicks(num = 2, lrm = "left") {
    ; temporarily blocks mouse movement for more consistent doubleclick to select word
    ReleaseModifiers()
    BlockInput, MouseMove
    click, %num% %lrm%
    BlockInput, MouseMoveOff
    return
 }

 CursorJump(Q = "center", offset_x = "0", offset_y = "0") {
    ; move mouse cursor to the middle of active window
    global short
    Sleep, short * 2
    CoordMode, Mouse, Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    switch Q
    {
        case "T":                                                               ;top
            MouseGetPos, x
        case "B":                                                               ;bottom
            MouseGetPos, x
            y := winTopL_y + height
        case "L":                                                               ;left
            x := winTopL_x
            MouseGetPos,,y
        case "R":                                                               ;right
            x := winTopL_x + width
            MouseGetPos,,y
        case "TL":
            x := winTopL_x + width  * .10
            y := winTopL_y + height * .15
        case "TR":
            x := winTopL_x + width  * .80
            y := winTopL_y + height * .15
        case "BL":
            x := winTopL_x + width  * .10 
            y := winTopL_y + height * .80
        case "BR":
            x := winTopL_x + width  * 0.80
            y := winTopL_y + height * 0.80
        default:                                                                ; center
            x := winTopL_x + width  * .5
            y := winTopL_y + height * .5
    }
    DllCall("SetCursorPos", int, x + offset_x, int, y + offset_y) 
    return
 }


; CHROME _______________________________________________________________________
 
 ChromeConfig(tgt) {    
    send ^l
    clip(tgt)
    send {enter}
    return
 }

 BrowserForward(isHold, taps, state) {
    if (taps > 1) {
        send  !{right}
    }
 }

 BrowserBack(isHold, taps, state) {
    if (taps > 1) {
        send !{left}
    }
 }

 NextPage(isHold, taps, state) {
    if (taps > 1) {
        sendinput {sc01b 2}                                                     ; vimium integration
    }
 }

 PrevPage(isHold, taps, state) {
    if (taps > 1) {
        sendinput {sc01a 2}                                                     ; vimium integration
    }
 }
 
 LoadURL(URL) {
    ; Browser path used to load urls dependent on computer
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, html_path
    Run, %output% %URL%
    return
 }

 Search(prefix = "google.com/search?q=", suffix = "") {
    global short, med
    url := prefix . """" clip() """" . suffix
    sleep med
    loadURL(url)
    CursorFollowWin()
    return
 }

 OpenGoogleDrive(num) {
    ; Function for opening different google drive folders
    global config_path
    LoadURL("-incognito https://drive.google.com/drive/my-drive")               ; icognito to avoid signing out of google account
    MsgBox,4100, Accessing Google Drive, Enter login/pwd after page loads?
    IfMsgBox Yes
    {
        IniRead, output, %config_path%, PASSWORDS, gd%num%_login
        clip(output)
        send {enter}
        sleep 2000
        SelectLine()
        IniRead, output, %config_path%, PASSWORDS, gd%num%_pwd
        clip(output)
        send {enter}
        return
    }
    else
        return
 }

; OFFICE _______________________________________________________________________
 
 sendEmail() {
     global email := "", subject := "", body := ""
     Gui, New, ,%title%
     Gui, Add, Edit, W300 vemail,
     Gui, Add, text, xs yp+30, case insensitive
     Gui, Add, Edit, W300 vsubject,
     Gui, Add, Edit, W300 R20 vbody,
     Gui, Add, Button, Default, Send
     Gui, +LastFound +OwnDialogs +AlwaysOnTop
     GetGUIWinCoords(GUI_X, GUI_Y)
     Gui, Show, % "x" GUI_X " y" GUI_Y,                                          
     Return,
 
     ButtonSend:
         Gui, Submit, NoHide
         if email = Email
         {
             Return,
         }
         if message = Message
         {
             Return,
         }
         else
             Run, mailto:%email%?subject=%Subject%&body=%body%
         Gui, destroy
         return
 }

 RunExcelMacro(MacroName) { ; for AHK_L
    Try {
        oExcel := ComObjActive("Excel.Application") ;
        oExcel.Run(MacroName)
        return 
    } catch e {
        MsgBox, something went wrong, check if you can execute macros within the workbook
        return
    }
 }
 
 highlight_cell(CI := 0) { ;http://www.databison.com/excel-color-palette-and-color-index-change-using-vba/
    Try {
        oExcel := ComObjActive("Excel.Application")
        if (CI = oExcel.Selection.Interior.ColorIndex) 
            oExcel.Selection.Interior.ColorIndex := 0
        else 
            oExcel.Selection.Interior.ColorIndex := CI
        return
    } catch e {
        MsgBox, something went wrong, check if you can execute macros within the workbook
        return
    }
    
 }

 resize_pic(width = 100) {
    Try {
        oExcel := ComObjActive("Excel.Application")
        ; oExcel.Selection.ShapeRange.Height := height
        oExcel.Selection.ShapeRange.Width := width
        return
    } catch e {
        MsgBox, something went wrong, check if you can execute macros within the workbook
        return
    }

 }
 
 RunMSWordMacro(MacroName) { ; for AHK_L
    ; Retrieves a running object that has been registered with OLE.
    ; an inter-process communication mechanism. 
    ; Based on a subset of Component Object Model (COM) that 
    ; was intended for use by scripting languages
    RunMSWordMacro("10")
    oWord := ComObjActive("Word.Application")
    oWord.Run(MacroName)
 }

 command(tgt, opt = "") {
    ; run obsidian command corresponding to tgt string
    Send ^p
    clip(tgt)
    send {Enter}%opt%
    return
 }

; TEXT MANIPULATION ____________________________________________________________

 PasteClipboardAtMouseCursor() {
    Clicks(2)
    var := Clipboard
    var := trim(var, "`r`n`t")
    Clipboard := var
    sleep, short
    send ^v
    return
 }

 JoinArrayContents(arr, delimiter="`n") {
    content := ""
    for index, item in arr {
        if index > 1
            content := content . delimiter
        content := content . item
    }
    return content
 }

 Join(s,p*) {
    ; s = separator, p*= string array to join
    ; Function to Join strings python style                                     ; https://www.autohotkey.com/boards/viewtopic.php?t=7124
    static _:="".base.Join:=Func("Join")
    for k,v in p
    {
        if isobject(v)
            for k2, v2 in v
                o.=s v2
        else
            o.=s v
    }
    return SubStr(o,StrLen(s)+1)
 }

 FormatCode() {
    ; Adds formatting for math operators and code syntax
    var := clip()
    If !var                                             ; selects text to the left of cursor (if no text selected)
    {    
        send +{home}
        var := clip()
    }
    var := RegExReplace(var, "(\+|-|\*|\/|\>\=|\<\=|!\=|\=|\<|\>|:)", " $0 ")
    var := StrReplace(var, ",", ", ")
    var := StrReplace(var, "~", " ~ ")
    var := RegExReplace(var, "S) +", A_Space)
    var := StrReplace(var, " ,", ",")
    var := StrReplace(var, ": =", ":=")
    var := StrReplace(var, "% > %", "%>%")
    var := StrReplace(var, "= =", "==")
    var := StrReplace(var, "+ =", "+=")
    var := StrReplace(var, "- =", "-=")
    var := StrReplace(var, "- >", "->")
    var := StrReplace(var, "< -", "<-")
    clip(var)
    Sleep 200
    return
 }

 FormatTranscript() {
    ; Remove extra spaces and time index from youtube transcripts
    Unwrapped := RegExReplace(Clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")           ; strip single line breaks + replace with single space
    Unwrapped := RegExReplace(Unwrapped, "(?<!<)-\s", "$1")                     ; Join words split by hyphen on line break
    Unwrapped := RegExReplace(Unwrapped, "[0-9]+:[0-9]+")                       ; replace time stamps
    Unwrapped := RegExReplace(Unwrapped, "\S\s\K\s+(?=\S)")                     ; replace multiple consecutive spaces with single space
    clipboard := Unwrapped
    ClipWait
    send ^v
    return
 }

 RemoveBlankLines(reselect=False) {
    ; Removes blank lines within a block of selected text
    vText := clip()
    if !ErrorLevel
    {
        vText := RegExReplace(vText, "m)^ +$")
        vText := RegExReplace(vText, "\R+\R", "`r`n")
        clip(vText)
    }
    return
 }

 ConvertUpper(var = "", paste = True) {
    ; Convert selected text to uppercase
    var := !var ? clip() : var
    StringReplace, var, var, `r`n, `n, All
    StringUpper, var, var
    if !paste
        return %var%
    clip(var, True)
    return
 }

 ConvertLower(var = "", paste = True) {
    ; Convert selected text to lowercase
    var := !var ? clip() : var
    StringReplace, var, var, `r`n, `n, All
    StringLower, var, var
    if !paste
        return %var%
    clip(var, True)
    return
 }

 EveryFirstLetterCapitalized(var = "", paste = True, other_letters_lowercase = False) {
    ; Every first letter of selected text is capitalized
    var := (!var ? clip() : var)
    if (other_letters_lowercase = False)
        var := RegExReplace(var, "(\b[a-z])", "$U1")
    else {
        StringReplace, var, var, `r`n, `n, All
        StringUpper, var, var, T
    }
    if !paste
        return %var%
    clip(var, True)
    return
 }

 FirstLetterCapitalized(var = "", paste = True) {
    ; Capitalize just first letter of selected text
    var := (!var ? clip() : var)
    StringReplace, var, var, `r`n, `n, All
    StringLower, var, var
    var := RegExReplace(var, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
    if !paste
        return %var%
    clip(var, True)
    return
 }

 RepeatString(_string, _count) {
    ; Fast way to create a string of a repeated character
    local result
    VarSetCapacity(result, StrLen(_string) * _count)
    AutoTrim Off
    Loop %_count%
        result = %result%%_string%
    return result
 }

 FillChar(length = "80", char = " ", selected = True, out = false) {
    ; Function to create borders and blank spaces of fixed length 
    try {
        var := (selected) ? rtrim(clip()) : ""
        num_char    := (StrLen(char) < length) 
                     ? (length - StrLen(var))/StrLen(char) 
                     : StrLen(char) 
        string_char := RepeatString(char, num_char)
        output      := var . string_char
        output      := substr(output, 1, length)
        sleep 200
        if out
            return % output
        else
            clip(output)
    }
    return
 }
 
 AddSpaceBeforeComment(length = "80", char = " ", lines = 1) {
    ; Add spaces between two strings so the second string starts at the length position
    Send {space}{left}+{end}                                                    ; fixes issue in vscode where ^x on empty selection will cut the whole line
    end_txt := TrimText(1, clip())
    send {del}
    Send {home 2}+{end}
    beg_txt := TrimText(1, clip(), 1)
    send {del}
    gap := length - strlen(beg_txt)
    mid_txt := RepeatString(A_space, gap)
    new_line := beg_txt . mid_txt . end_txt
    clip(new_line)
    sendinput % "{left " . strlen(end_txt) . "}"
    return
 }

 AddBorder(length = "80", char = "_", prefix = "" )  {
    ; Add line border to separate code sections
    Send {home}
    sendraw %prefix%
    if (prefix != "")
        send {space}
    Send {home}
    Send {home}{shift down}{end}{shift up}
    FillChar(length, char)
    return
 }

 TrimText(cut = False, input = "", rtrim = false ) {
    ; cut/copy and trim selected text
    if !input {
        if !cut 
            send ^c
        else 
            send ^x
        clipboard := trim(clipboard)
        ; clipboard := var
        return
    }
    
    if input and rtrim 
        return % rtrim(input)
    else 
        return % trim(input)
    return
 }

 PasteWithoutBreaks(btn_paragraphs = False) {
    ; Format clipboard contents: remove double spaces and line breaks
    ; while keeping the empty lines between paragraphs
    Clipboard := RegExReplace(Clipboard, "(\S.*?)\R(.*?\S)", "$1 $2")           ; strip single line breaks + replace with single space
    if (btn_paragraphs = True)
        clipboard := RegExReplace(clipboard, "\R", A_space)                     ; replace paragraph breaks with space
    clipboard := RegExReplace(clipboard, "S) +", A_Space)                       ; replace multiple spaces with single space
    clipboard := RegExReplace(clipboard, "(?<!<)-\s", "$1")                     ; <= remove "-" if not preceded by < ("<-")
    send ^v                                                                     ;    for stitching words back together if split by
    return                                                                      ;    line breaks in pdf documents
 }

 SelectLine() {
    Send {home}{shift down}{end}{shift up}
 }
 
 AddSpaceBtnCaseChange(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := trim(RegExReplace(var, "((?<=[a-z])[A-Z]|[A-Z](?=[a-z]))", " $1"))
    if !paste
        return %var%
    clip(var, True)
    return
 }

 addQuotesAroundCommaSeparatedElements(var = "", paste = True) {
    var := clip()
    var := trim(var)
    StringReplace , var, var, %A_Space%,,All
    word_array := StrSplit(var, ",")
    Joined_array := """, """.Join(word_array)
    Joined_array := """" . Joined_array . """"
    if !paste
        return %Joined_array%
    clip(Joined_array, True)
    return
 }

 ReplaceBackspaceWithSpaces() {
    var := clip()
    clip(RepeatString(" ", strlen(var)))
    return
 }

 PasteOverwrite() {
    char_count := strlen(clipboard)
    send ^v
    sendinput {del %char_count%}
    return
 }

 ReplaceAwithB(A = "", B = "", var = "", paste = True, select = True, regex = false) {
    var := (!var ? clip() : var)
    var := RegExReplace(var, "S) +", A_Space)
    if regex
        var := RegExReplace(var, A, B)
    else 
        var := StrReplace(var, A, B)

    if !paste
        return %var%
    clip(var, select)
    return
 }

 removeHtmlTags() {
    ; remove html tags from selected text
    cl := clip()
    LR:=RegExReplace( cl, "<.*?>","`r`n" )
    stringreplace,lr,lr,|`r`n,,all
    Loop                                        ;- remove empty lines
    {
        StringReplace,lr,lr, `r`n`r`n, , UseErrorLevel
        if ErrorLevel = 0
            break
    }
    clip(lr)
    return
 } 
 
 /* 
 PCJupyter(UserInput, suffix, title, fsz, fnt, w_color, t_color) {
    global config_path, File_DICT, Folder_DICT, long, med
    global lg, pink, lblue, black, lpurple, purple, green, red, lgreen
    FirstChar := SubStr(UserInput, 1 , 1)
    f_path := A_ScriptDir "\mem_cache\" 
    Iniread, tgt_winID, %config_path%, %A_ComputerName%, CB_tgt_hwnd

    if RegExMatch(FirstChar,"[0-9A-Z\?jk:]") 
    {
        C_input := SubStr(UserInput, 2)                                         ; everything after the first character
        SplitPath, C_input, FileName, Dir, Extension, NameNoExt                 ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
        ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
        dir := dir ? dir . "\" : ""
        Switch FirstChar
        {
            Case 1,2,3,4,5,6,7,8,9,0:
                NameNoExt := FirstChar
                C_input := FirstChar
                gosub, Loadj
                return 1
            Case "?":
                NameNoExt := "help"
                C_input := "help"
                gosub, Loadj
                return 1
            Case "A", "P":                                                      ; append|prepend selected text
                ActivateWindow("ahk_id " tgt_winID) 
                text_to_add := "`n" . trim(clip())
                if (FirstChar == "A") {
                    FileAppend, %text_to_add%, %f_path%%Dir%%NameNoExt%.txt    
                    ShowPopUp("added to bottom of`n" NameNoExt ,,"250",,,,,lgreen)  
                } else {
                    FilePrepend(f_path Dir NameNoExt ".txt", text_to_add) 
                    ShowPopUp("added to top of`n" NameNoExt ,,"250",,,,,lgreen)
                }    
                sleep 800
                gosub, Loadj
                return 1    
            Case "L":                                                           ; display file in command box
                Loadj:                                                    
                if !FileExist(f_path dir NameNoExt ".txt") or (C_input = "list") {
                    txt  := CreateCacheList("list")
                } else {
                    IniWrite, %dir%%NameNoExt%, %config_path%, %A_ComputerName%, CB_last_display
                    txt  := AccessCache(NameNoExt,dir, False)
                }
                new_title_file := dir . NameNoExt . ".txt"
                UpdateGUI(txt, title, new_title_file)
                sleep med
                return 1
            Case "O":                                                           ; overwrite file/clipboard
                C_input := RegExReplace(C_input, "S) +", A_Space)
                If (SubStr(C_input, 1 , 1) == ":") 
                {
                    C_input := trim(SubStr(C_input, 2))
                    SplitPath, C_input, , Dir, , NameNoExt 
                    clipboard := AccessCache(NameNoExt,dir, False)
                    return
                }
                else If !RegExMatch(C_input, " .+")
                {                    
                    ActivateWindow("ahk_id " tgt_winID) 
                    text_to_add := trim(clip())
                    tgt_path := f_path dir namenoext . "txt"
                    FileDelete, tgt_path
                    if !InStr(FileExist(f_path dir), "D") and dir
                    {                                      
                        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
                        MsgBox,4100,Create Hotstring,%msg% 
                        IfMsgBox Yes
                            FileCreateDir, %f_path%%dir%
                        else 
                            return 1
                    }
                    WriteToCache(namenoext,, dir)   
                    sleep 800
                    gosub, Loadj
                    return 1 
                } else {
                    arr := StrSplit(C_input, " ")
                    SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                    SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                    odir := odir ? odir . "/" : ""
                    ndir := ndir ? ndir . "/" : ""

                    if FileExist(f_path odir oNameNoExt ".txt") and FileExist(f_path ndir nNameNoExt ".txt")
                    {
                        try {
                            Filecopy,% f_path . nDir . nNameNoExt . ".txt",% f_path . oDir . oNameNoExt . ".txt", 1
                            ShowPopUp(oFileName . " overwritten with " . nFileName,green,,,-1000,,,lgreen)
                            sleep 800
                            txt  := AccessCache(oNameNoExt,dir, False)
                            new_title_file := oNameNoExt . ".txt" 
                        } catch {
                            ShowPopUp("invalid path",green,,,-2000,,,lgreen)
                            sleep 800
                            gosub, redrawGUIj
                        }
                    }
                    UpdateGUI(txt, title, new_title_file)
                }
                return 1
            Case "V":                                                           ; paste file contents
                ActivateWindow("ahk_id" tgt_winID)
                AccessCache(namenoext, dir)
                ShowPopUp(namenoext " pasted", "000000", "230", "70", "-600", "14", "610", lgreen)
                return
            Case "E":                                                           ; edit file
                if !C_input
                    FunctionBox("EditFile", File_DICT, lgreen)
                else if (C_input == "F")
                    FunctionBox("OpenFolder", Folder_DICT, lblue)
                else    
                {
                    FileName := !Extension ? FileName . ".txt" : FileName
                    EditFile(f_path Dir FileName)
                }
                return
            Case "C":                                                           ; copy file
                If !RegExMatch(C_input, " ")
                {
                    ShowPopUp("DUPLICATE DETECTED!`nappending suffix to filename", purple,,,,,,lp )
                    var := 1
                    Filecopy,%f_path%%C_input%.txt,%f_path%%Dir%%namenoext%_%var%.txt,0
                    exist = %ErrorLevel%                                        ; get the error level 0 = no errors
                    while exist > 0                                             ; what to do if there is an error like filename already exists
                    {
                        ShowPopUp("DUPLICATE DETECTED!`nappending suffix to filename", purple,,,,,,lp )
                        ++var
                        Filecopy,%f_path%%Dir%%namenoext%.txt, %f_path%%Dir%%namenoext%_%var%.txt,0
                        exist = %ErrorLevel%
                    }
                }
                else
                {
                    try {
                        arr := StrSplit(C_input, " ")
                        SplitPath,% arr[1], oFileName, oDir, oExtension, oNameNoExt 
                        SplitPath,% arr[2], nFileName, nDir, nExtension, nNameNoExt 
                        odir := odir ? odir . "/" : ""
                        ndir := ndir ? ndir . "/" : ""
                        Filecopy,% f_path . oDir . oNameNoExt . ".txt",% f_path . nDir . nNameNoExt . ".txt", 1  ; 1 = overwrite 
                        ShowPopUp(oFileName . " copied to " . nFileName,green,,,-2000,,,lgreen)
                    } catch {
                        ShowPopUp("invalid file path",green,,,-2000,,,lgreen)
                    }
                }
                return 1
            Case "R":                                                           ; replace string 
                C_First2chr := SubStr(C_input, 1, 2) 
                remainder := SubStr(C_input, 3)
                switch C_First2chr
                {
                    case "1~":
                        IniWrite,%remainder%, %config_path%, %A_ComputerName%, Rsep1
                        return 1
                    case "2~":
                        IniWrite,%remainder%, %config_path%, %A_ComputerName%, Rsep2
                        return 1
                    Case "f~":
                        OuterArr := StrSplit(remainder, " ")
                        InnerArr := StrSplit(outerArr[1], "~")
                        SplitPath,% InnerArr[1], oFileName, oDir, oExtension, oNameNoExt                 ; msgbox % C_input "`n`nFileName: " FileName "`nDir: " Dir "`nExtension: " Extension "`nNameNoExt: " NameNoExt
                        SplitPath,% InnerArr[2], pFileName, pDir, pExtension, pNameNoExt
                        SplitPath,% OuterArr[2], nFileName, nDir, nExtension, nNameNoExt
                        odir := odir ? odir . "/" : ""
                        pdir := pdir ? pdir . "/" : ""
                        ndir := ndir ? ndir . "/" : ""
                        
                        otxt := AccessCache(oNameNoExt,oDir, False)
                        ptxt := AccessCache(pNameNoExt,pDir, False)
                        ptxt := StrReplace(ptxt, "`n")
                        ptxt := StrReplace(ptxt, "`r")
                        pArr := StrSplit(ptxt, "__")
                        
                        ntxt := otxt
                        loop % pArr.MaxIndex()
                        {
                            AB := StrSplit(pArr[A_index], "~")
                            ntxt := ReplaceAwithB(AB[1], AB[2],ntxt,0,0)
                        }
                        FileDelete,% f_path . nDir . nNameNoExt . ".txt"
                        FileAppend, %ntxt%, %f_path%%nDir%%nNameNoExt%.txt    
                        return

                    default:
                        ActivateWindow("ahk_id " tgt_winID)      
                        vtext := clip()                       
                        arrN := StrSplit(C_input, "__")
                        loop % arrN.MaxIndex()
                        {
                            AB := StrSplit(arrN[A_index], "~")
                            vtext := ReplaceAwithB(AB[1], AB[2],vtext,0,0)
                        }
                        clip(vtext)   
                       
                        return

                }        
                return
            Case "F":                                                           ; fill space with char
                ActivateWindow("ahk_id " tgt_winID)                             
                arr := StrSplit(C_input, ",")
                FillChar(arr[2], arr[1], 0)
                return 
            Case "G":                                                           ; run function
                ActivateWindow("ahk_id" tgt_winID)
                arr := StrSplit(C_input, ",")
                if arr.MaxIndex() > 1 
                {
                    params := ""
                    p_num := arr.MaxIndex() - 1
                    func := arr[1]
                    arr.RemoveAt(1)
                    for k, v in arr
                        params .= (k < p_num) ? v . "," : v
                    %func%(params)
                }
                else
                    %C_input%()
                return
            Case "J":                                                           ; select|goto rows below
                ActivateWindow("ahk_id " . tgt_winID)
                if (FirstChar == "j")
                    UDSelect("down", "10", C_input, false)                      ; no selection just row movement
                else
                    UDSelect("down", "10", C_input)
                return
            Case "K":
                ActivateWindow("ahk_id " . tgt_winID)                           ; select|goto rows above
                if (FirstChar == "k")
                    UDSelect("Up", "10", C_input, false)
                else
                    UDSelect("Up", "10", C_input)
                return
            Case "W":
                return
            Case "S":                                                           ; open cache folder in explorer and (case-insensitive) select files according to match string  
                OpenFolder("mem_cache\")
                WinWait, mem_cache,, 3
                SelectByRegEx(C_input)
                return
            Case "H":
                msgbox 2
                
                
                return
            Default:
                return 1
        } 
    } 
    Else 
    {
        ActivateWindow("ahk_id " tgt_winID)
        sleep medvv 
        Switch 
        {
            Case IsLabel(        UserInput . suffix): UserInput :=         UserInput . suffix
            Case IsLabel(":X:" . UserInput . suffix): UserInput := ":X:" . UserInput . suffix
            Case IsLabel(":*:" . UserInput . suffix): UserInput := ":*:" . UserInput . suffix
            Case IsLabel(        UserInput . "~win"): UserInput :=         UserInput . "~win"
            Case IsLabel(":X:" . UserInput . "~win"): UserInput := ":X:" . UserInput . "~win"
            Case IsLabel(":*:" . UserInput . "~win"): UserInput := ":*:" . UserInput . "~win"
            Default:
                gosub, redrawGUIj
                return 1
        }     
        Gosub, %UserInput% 
        return
    }
    redrawGUIj:
        IniRead, gui_position, %config_path%, %A_ComputerName%, gui_position, Center
        wdth := StrSplit(gui_position, " ")[3]
        GuiControl, MoveDraw, CB_Display, %wdth%                                    
        Gui, 2: show, %gui_position%                                            
        return
 } */