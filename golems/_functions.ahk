; GLOBAL VARIABLES _____________________________________________________________
  
  short := 100, med := 300, long := 900

  C := { "lgreen"      : "CEDFBF"
       , "lblue"       : "BED7D6"
       , "lyellow"     : "FCE28A"
       , "lpurple"     : "CDC9D9"
       , "black"       : "000000"
       , "white"       : "FFFFFF"
       , "red"         : "FF0000"
       , "green"       : "107A40"
       , "navy"        : "000080"
       , "blue"        : "0000FF"
       , "purple"      : "800080"
       , "lbrown"      : "DFD0BF"
       , "bgreen"      : "29524A"
       , "pink"        : "F6E1E0"
       , "bwhite"      : "F6F7F1"
       , "lorange"     : "FFDEAD"
       , "dblue"       : "0A244C"
       , "rblue"       : "165CAA"
       , "pbrown"      : "D4C4B5"
       , "dgrey"       : "525252"
       , "onyx"        : "353839" }

  GroupAdd, FileListers, ahk_class CabinetWClass                                ; reference group for file explorer and save as dialogue boxes
  GroupAdd, FileListers, ahk_class WorkerW
  GroupAdd, FileListers, ahk_class #32770, ShellView
        

; WINDOW MANAGEMENT ___________________________________________________________

  MoveWin(Q = "TL", ha = 8, wa = 8) {
    global config_path, ghwnd
    static x, y, w, h
    WinRestore, A
    MI := StrSplit(GetMonInfo()," ")  
    x := MI[1] , y  := MI[2] , w := MI[3] , h  := MI[4]                         ; get monitor dimensions
    hw:= w//2  , qw := w//4  , hh:= h//2  , qh := h//4

    if (winactive("ahk_id " ghwnd) and !GC("CB_Display"))
        return

    switch Q
    {
        case "F" ,"Maximize"        : x := x      , y := y       , w := w  , h := h                   
        case "L" ,"LeftHalf"        : x := x      , y := y       , w := hw , h := h     
        case "R" ,"RightHalf"       : x := x+hw   , y := y       , w := hw , h := h     
        case "LS","LeftHalfSmall"   : x := x      , y := y       , w := qw , h := h     
        case "RS","RightHalfSmall"  : x := x+3*qw , y := y       , w := qw , h := h     
        case "T" ,"TopHalf"         : x := x      , y := y       , w := w  , h := hh    
        case "TS","TopHalfSmall"    : x := x      , y := y       , w := w  , h := qh    
        case "B" ,"BottomHalf"      : x := x      , y := y+hh    , w := w  , h := hh    
        case "BS","BottomHalfSmall" : x := x      , y := y+hh+qh , w := w  , h := qh    
        case "TL","TopLeft"         : x := x      , y := y       , w := hw , h := hh    
        case "TR","TopRight"        : x := x+hw   , y := y       , w := hw , h := hh    
        case "BL","BottomLeft"      : x := x      , y := y+hh    , w := hw , h := hh    
        case "BR","BottomRight"     : x := x+hw   , y := y+hh    , w := hw , h := hh    
        case "L1","TopLeftSmall"    : x := x      , y := y       , w := hw , h := qh    
        case "L4","BottomLeftSmall" : x := x      , y := y+3*qh  , w := hw , h := qh    
        case "R1","TopRightSmall"   : x := x+hw   , y := y       , w := hw , h := qh    
        case "R4","BottomRightSmall": x := x+hw   , y := y+3*qh  , w := hw , h := qh    
        default:                                                              
            return
    }
    ; #if 
    
    If (winactive("ahk_id " ghwnd))
    {
        ; msgbox % "x" x " y"y " w"w " h"h
        GuiControl, 2: -HScroll -VScroll, CB_Display
        Gui, 2: show
        GuiControl, 2: +HScroll +VScroll, CB_Display
        CC("CB_position", "x" x " y" y " w" w " h" h)
    }

    WinMove,A,, x, y, w, h
    
  }
 
 
  MaximizeWin(){
    WinMaximize,A 
  }
 
  moveWinBtnMonitors() {
    Sendinput +#{Left}
    CursorFollowWin()
    return
  }
 
  MoveWindowToOtherDesktop(n = "2") {                                            ; https://github.com/FuPeiJiang/VD.ahk
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
 
  ActivateWin(title="Chrome") {
    SetTitleMatchMode, 2                                                        ; match anywhere in title
    IfWinExist, %title%
        WinActivate, %title%
    return
  }
 
  SaveWinID(key = "L") {
    global config_path, C
    WinID_%key% := WinExist("A")
    IniWrite, % WinID_%key%, %config_path%, %A_ComputerName%, WinID_%key%
    ShowPopup("WinID " key " saved", C.lgreen, C.bgreen, "300", "60", "-1000", "16", "610")
    return
  }
 
  ActivateWinID(key = "L") {
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, WinID_%key%
    ActivateWin("ahk_id" output), CursorFollowWin()
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
  
  AlwaysOnTop(state = True, supress = False) {
    ; toggle active window to be always on top
    global C
    WinGet, Process_Name, ProcessName, A
    WinGetTitle, Title, A
    WinGetClass, class, A
    ; Msgbox % "`nsupress1: " . supress
    if (state)
    {
        Winset, Alwaysontop, ON , A
        if (!supress)
            ShowPopup(Process_Name "`nalways on top: ON", C.lgreen, C.bgreen,"250","120", "-800")
    } else {
        Winset, Alwaysontop, OFF , A    
        if (!supress) 
            ShowPopup(Process_Name "`nalways on top: OFF", C.pink, C.red,"250","120","-800") 
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
 
; SYSTEM APPS _________________________________________________________________
 
  PowerOptions(s = "") {
    switch s 
    {
        case "sleep":     DllCall("PowrProf\SetSuspendState","int",0,"int",0,"int",0)
        case "hybernate": DllCall("PowrProf\SetSuspendState","int",1,"int",0,"int",0)
        case "shutdown":  ShutDown, 9
        case "restart":   ShutDown, 2
    }
    return
  }

  ActivateExplorer := Func("ActivateApp").Bind("explorer.exe")

  CloudSync(state="ON") {
    ; Turn ON/OFF google cloud sync
    global med, config_path, C 
    IniRead, ini_app_path, %config_path%, %A_ComputerName%, sync_path, 
    RegExMatch(ini_app_path, "[^\\]+$", exe_name)

    if (state = "ON") {
        try {
            ActivateApp("sync_path")

            ShowPopup("cloud sync initiated",C.lgreen,C.bgreen,"300", "75", "-3000")
            return
        } catch e {
            msgbox can't open cloud cloud sync app.
        }
    } else {
        if WinExist("ahk_exe " exe_name){
            WinClose, ahk_exe %exe_name%
            ShowPopup("closing cloud sync",C.pink,,,,"-3000")
        } else {
            ShowPopup("cloud sync not running",C.lpurple,C.purple,,,"-3000")
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
 
; COMMAND BOX / JUMPLISTS _____________________________________________________
  
  ToggleDisplay(){
    % (GC("CB_Display") = 1) ? (GUIFocusInput(), clip("Tm"))
                              : (GUIFocusInput(), clip("Td"))
    sendinput {enter}
    return
  }          

  RunOtherCB(C_input = "", Chr = "") {
    C_1stchr := SubStr(C_input, 1, 1)
    if (SubStr(C_input, 1, 1) = "~") 
    {
        CC("CB_" Chr "sfx", "~" SubStr(C_input, 2))
        Gui, 2: destroy
        return
    } else {
        sfx := GC("CB_" Chr "sfx", "~win")  
        RunLabel(C_input, sfx, TgtWinID)
    }
    return
  }
  
  ReplaceAlias(arr*) {
    static sect := ""
    for k,v in arr
    {
        sect := (k = 1) ? "function" : "parameter"
        IniRead,out, %A_ScriptDir%\mem_cache\ALIAS.ini, %sect%,% arr[k], %A_space%
        arr[k] := out ? out : arr[k]
    }
    return % arr
  }

  RunFunction(p*){
    global C
    p := ReplaceAlias(p*)
    
    func := p[1]
    if (p.MaxIndex() > 1)
    {
        p.RemoveAt(1)
        %func%(p*)
    }
    else
    {
        Try 
        {
            %func%()
        } 
        catch 
        {
            ShowPopUp("Sorry can't find function",C.lpurple,,,,-2000)
        }
    }
    return
  }

  s(k = "down", n = 1) {                                                         ; function wrapper for send keystrokes command
    sleep 100
    switch k 
    {
        case "enter"     : 
            send % "{enter}"
            return
        case "u", "up"   : send % "{ up "    n "}"
        case "d", "down" : send % "{ down "  n "}"
        case "l", "left" : send % "{ left "  n "}"
        case "r", "right": send % "{ right " n "}"
        case "enter"     : send {enter}
        Default          : send % k
    }
    return
  }

  RunLabel(UserInput, suffix, tgt_winID) {
    global med, TgtWinID
    ; ActivateWin("ahk_id " TgtWinID)
    ; sleep med
    Switch 
    {
        Case IsLabel(        UserInput . suffix): UserInput :=         UserInput . suffix
        Case IsLabel(":X:" . UserInput . suffix): UserInput := ":X:" . UserInput . suffix
        Case IsLabel(":*:" . UserInput . suffix): UserInput := ":*:" . UserInput . suffix
        Case IsLabel(        UserInput . "~win"): UserInput :=         UserInput . "~win"
        Case IsLabel(":X:" . UserInput . "~win"): UserInput := ":X:" . UserInput . "~win"
        Case IsLabel(":*:" . UserInput . "~win"): UserInput := ":*:" . UserInput . "~win"
        Default:
            Gui, 2: destroy
            return
    }     
    Gosub, %UserInput% 
    Gui, 2: destroy
    return
  }

  CB( sfx = "~win", w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand") {
    ReleaseModifiers()
    global config_path
    SetTitleMatchMode, 2
    DetectHiddenText, On
    
    if WinExist("ahk_id " GC("CB_hwnd")) {
        
        WinActivate, % "ahk_id " GC("CB_hwnd")
        GUIFocusInput()
        return
    }
    
    CommandBox(sfx, w_color, t_color, ProcessMod) 
    DetectHiddenText, off
    return
  }

  FB(func="", input_dict="", w_color = "CEDFBF", t_color = "000000", title="", name_dict = "", grp=1, p*) {
    ReleaseModifiers()
    global config_path, FBhwnd
    SetTitleMatchMode, 2
    ; IniRead, output, %config_path%, %A_ComputerName%, CB_hwnd
    DetectHiddenText, On
    if WinExist("ahk_id " . FBhwnd) 
        WinActivate, % "ahk_id " . FBhwnd
    else
        FunctionBox(func, input_dict, w_color, t_color, title, name_dict, grp, p*) 
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
    ; Loop Files, %strDir%*.txt, R  ; Recurse into subfolders.
    Loop Files, %strDir%*.*, R  ; Recurse into subfolders.
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
    ; Sort, cache_contents, CL
    cache_contents := "CACHE CONTENTS`n" . RepeatString("-", char_width) . "`n`r" . cache_contents
    FileAppend, %cache_contents%, mem_cache\%name%.txt
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
    OutputVar := GC("last_user_input")
    GuiControl,2: Focus, UserInput
    sendinput {home}+{end}
    clip(OutputVar)
    sendinput {home}+{end}
    return
  }

  GUIFocusInput() {
    Gui, 2: +LastFound
    Gui, 2: restore
    GuiControl, 2: Focus, UserInput
    sendinput {home}+{end}
    return
  }
 
  UDSelect(d="down", interval = "5", c_input = "", select = True, MultiCursor = False
          , letter = "jk", MC_key = "Printscreen") {
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
        case MultiCursor, Instr(A_ThisHotkey, MC_key):
            sendinput % "+^!{" . d . " " . n . "}"                              ; multi cursor selection for VScode
        Default:
            sendinput % select  
                    ? "+{" . d . " " . n . "}"
                    : "{" . d . " " . n . "}"
    }
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
    global UserInput := "", FBhwnd := ""

    FB_TgtWinID := WinExist("A")                                                      ; store win ID of active application before calling GUI 
    IniWrite, %FB_TgtWinID%, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    winget, output, ProcessName, A    
    
    
    Gui, +LastFound 
    Gui, Destroy
    Gui, fb: New, ,%title%
    Gui, font,s13 , Consolas
    Gui, fb: Add, text, xp yp+10 c%t_color%, % TOC "`n"
    Gui, fb: Add, Edit, w120 vUserInput
    Gui, fb: Add, Button, W60 X+10 Default gButtonOK, OK
    Gui, fb: Add, Button, W60 X+5 gButtonCancel, Cancel
    Gui, font,s8 , calibri
    Gui, fb: add, text, xs yp+30, case insensitive
    Gui, fb: +LastFound +OwnDialogs +AlwaysOnTop
    FBhwnd  := WinExist()
    GetGUIWinCoords(GUI_X, GUI_Y)
    Gui, Color, %w_color%
    Gui, fb: Show, % "x" GUI_X " y" GUI_Y,                                          ; Show gui at center of current screen
    ; Gui, +LastFound
    WinWaitClose                                                                ; WinSet, Transparent , 255, ahk_id %CB_Hwnd%
    return

    ButtonOK:
       Gui, fb: Submit
       Gui, fb: Destroy
       return
   
    fbGuiClose:
    ButtonCancel:
    fbGuiEscape:
       UserInput := ""
       Gui, fb: Destroy
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
        dest := Trim(AddSpaceBtnCaseChange(dest, 0))
        if groups {
            prefix := substr(dest, 1, 3)
            if (prefix <> prev_prefix and prev_prefix and prefix) {             ; adds blank line between changes in selection group prefix 
                TOC .= "`n" 
            }
            prev_prefix := prefix
        }

        TOC .= (TOC <> "" ? "`n" : "") ref "`t" trim(dest, """")
    }
    
    return TOC
  }
 
; MEM_CACHE / CREATE HOTSTRING SNIPPET ________________________________________

  WriteToCache(key, del_toggle = False, mem_path = "", input = "", append = false, supress = False) {
    ; creates a txt file in \mem_cache from selected text
    global C
    
    if !input
        input := clip()                                                         ; captures selected text if no input given

    if (trim(input) = "") {
                                
    } else {
        if !append
            FileDelete, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
        FileAppend, %input%, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
        if !supress
            ShowPopup("Written to `n" key, C.lgreen)
    }
    if (del_toggle = TRUE)
        send {del}
    return
  }

  RetrieveExt(tgt) {
    out := ""
    if FileExist(tgt ".txt") 
        out := ".txt"
    else if FileExist(tgt ".ini") 
        out := ".ini"
    return % out
  }

  AccessCache(key, mem_path = "", paste = True) {
    ; paste contents of mem folder txt file or assign to variable
    max_str_len := 0
    input = %A_ScriptDir%\mem_cache\%mem_path%%key%
    
    if !RegExMatch(input,"(\.[a-zA-Z]{3})$")                                    ; check if there's a file extension
    {
        if FileExist(input ".txt") 
            input .= ".txt"
        else if FileExist(input ".ini") 
            input .= ".ini"
    }

    FileRead, output, %input%
    output := rtrim(output, "`t`n`r")
    if !paste {
        return %output%
    } 
    clip(output)                                                                ; clip(output, True)
    return
  }

  OverwriteMemory(del_toggle = false) {
    global lb, short
    ReleaseModifiers()
    slot := substr(A_ThisHotkey, 0)        
    ; del_toggle := Instr(A_ThisHotkey, "del") ? True : False               ;     cut selected text hot key condition  
    WriteToCache(slot, del_toggle)                                          ;     note: if no text selected, no overwrite will occur 
    return
  }

  AddToMemory(del_after_copy = "0"){
    global C, ghwnd
    ReleaseModifiers()
    slot            := substr(A_ThisHotkey, 0)
    new_text_to_add := trim(clip())
    FileAppend % "`n" . new_text_to_add, mem_cache\%slot%.txt           
    ShowPopUp("added to bottom of`n" slot ".txt",C.lgreen)
    If WinExist("ahk_id " ghwnd)
        UpdateGUI()
    ; cut := Instr(A_ThisHotkey, "!") ? True : False 
    if (cut = true)
       send {del}
    return
  } 

  RetrieveMemory(mpaste = "^#LButton", mprompt="#!LButton", pasteOvr="printscreen") {
    global med, short, C
    ReleaseModifiers()
    WinID := WinExist("A") 
    if (Instr(A_ThisHotkey, mprompt))
    ; if (Instr(A_ThisHotkey, "#!LButton"))
    {
        Clicks(2)
        ShowPopUp("PASTE WHICH SLOT #?",C.lpurple,"000000", "230", "75", "-5000", "14", "610")
        input, mem_slot, L1 T5
        Gui, PopUp: Destroy
    } 
    else if Instr(A_ThisHotkey, mpaste) 
    ; else if Instr(A_ThisHotkey, "^#LButton") 
    {
        Clicks(2)
        mem_slot := "1"
        ShowPopUp("M1 PASTED", C.lgreen, , "230", "75", "-600", "14", "610")
    }
    else 
    {
        mem_slot := substr(A_ThisHotkey, 0)                                 ; store last key pressed in hotstring/hotkey as memory slot selection 
    }
    ActivateWin("ahk_id " WinID)
    AccessCache(mem_slot)
    if Instr(A_ThisHotkey, pasteOvr) {                               
        del_char := strlen(AccessCache(mem_slot, ,False))
        del_char := (del_char < 200) ? del_char : ""                        ; delete after paste inconsistent with large blocks of multi-line text
        sendinput {del %del_char%}
        return
    }
    return
  } 

; AHK UTILITIES _______________________________________________________________


  CC(key = "CB_Titlebar", nval = "", sect = "") {                               ; Change Config.ini
    global config_path
    section := sect ? sect : A_ComputerName

    if (nval = "!") {
        IniRead,  state,    %config_path%,%section%,%key%, 0
        IniWrite, % !state, %config_path%,%section%,%key%
    } else {   
        IniWrite, %nval%, %config_path%,%section%, %key%
    }
    return
  }
  
  GC(key = "CB_Titlebar", d = "") {                                             ; Get Config.ini value
    global config_path
    IniRead,  val, %config_path%, %A_ComputerName%, %key%, %d%
    return % val
  }

  MsgBoxVar(mb = True) {
    var := clip()
    out := mb ? "Msgbox % " : ""
    Arr := StrSplit(var, ",")
    loop % Arr.MaxIndex()
    {
        out .= """``n" . Arr[A_index] . ": "" . " . Arr[A_index] 
        if !(A_index == Arr.MaxIndex()) 
            out .= " . "
    }
    clip(out)
    return
  }
 
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

  GetMonInfo(wa = "8", ha = "8") {
    n := GetCurrentMonitorIndex()
    SysGet, XY, MonitorWorkArea , %n%
    x  := XYLeft                 , y  := XYtop
    w  := Abs(XYLeft-XYRight)+wa , h  := Abs(XYtop-XYbottom)+ha
    return % x " " y " " w " " h
  }

  WriteToINI(section = "DESKTOP-T6USCO1", key = "cursor_follow", var = "") {
    global config_path, C
    var := clip()
    ShowPopUp("config.ini updated",C.lgreen,,,,-2000)
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
    global C, exe := {}
    static doc_exe, xls_exe, ppt_exe, pdf_exe, html_exe, sync_exe, editor_exe

    path := RetrieveINI(A_ComputerName, "editor_path")
    if (!FileExist(config_path) or path = "ERROR") {
        Gui, c: +LastFound
        Gui, c: Destroy          
        Gui, c: New,,WinGolems Configuration
        Gui, c: +LastFound +OwnDialogs +Owner -DPIscale +Resize +AlwaysOnTop ; +E0x08000000 +Resize  +E0x00200 (border)
        Gui, c: Color,% C.bwhite
        
        lw := 150, rw := 200
        Gui, c: font, s11 w%lw%, %fnt%, Consolas
        Gui, c: Add, Text,% "w" . (rw + lw) . " xm"
            ,No system configuration detected. Please confirm/modify the following default application associations.`n
        
        Gui, c: font, s10 w%lw%, %fnt%, Consolas
        
        Gui, c: Add, Text, section xm w%lw%,word files
        Gui, c: Add, Edit, w%rw% ys vdoc_exe,% apps[1]         
        
        Gui, c: Add, Text, section xm w%lw%,excel files
        Gui, c: Add, Edit, section w%rw% ys vxls_exe,% apps[2]
    
        Gui, c: Add, Text, section xm w%lw%,powerpoint files
        Gui, c: Add, Edit, w%rw% ys vppt_exe,% apps[3]         
        
        Gui, c: Add, Text, section xm w%lw%,pdf viewer
        Gui, c: Add, Edit, section w%rw% ys vpdf_exe,% apps[4]
        
        Gui, c: Add, Text, section xm w%lw%,web browser
        Gui, c: Add, Edit, w%rw% ys vhtml_exe,% apps[5]         
        
        Gui, c: Add, Text, section xm w%lw%,cloud backup
        Gui, c: Add, Edit, section w%rw% ys vsync_exe,% apps[6]
    
        Gui, c: Add, Text, section xm w%lw%,default editor
        Gui, c: Add, Edit, w%rw% ys veditor_exe,% apps[7]         
        
        Gui, c: Add, Text, section xm w%lw%,
        Gui, c: Add, Button, w%rw% ys Default gSubmit_Button, submit                   ; Gui, c: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter ;
        
        Gui, c: show, autosize 
        return
    
        Submit_Button:
            Gui, c: Submit
            exe["doc"] := doc_exe
            exe["xls"] := xls_exe
            exe["ppt"] := ppt_exe
            exe["pdf"] := pdf_exe
            exe["html"] := html_exe
            exe["sync"] := sync_exe
            exe["editor"] := editor_exe
            CreateConfigINI(exe*)
            return
    } else {
        CreateEXEDict()
    }
  }

  CreateEXEDict() {
    apps := ["doc","xls","ppt","pdf","html","sync","editor"]
    global exe := {}
    loop % apps.MaxIndex()
    {
        SplitPath,% GC(apps[A_Index] "_path"), FileName
        exe[apps[A_Index]] := FileName
    }
    return
  }

  CreateConfigINI(exe*) {
    global config_path, UProfile, med, C

    PATH := FindAppPath(exe*)
    CC("doc_path"      , PATH[exe["doc"]])
    CC("xls_path"      , PATH[exe["xls"]])
    CC("ppt_path"      , PATH[exe["ppt"]])
    CC("pdf_path"      , PATH[exe["pdf"]])
    CC("html_path"     , PATH[exe["html"]])
    CC("sync_path"     , PATH[exe["sync"]])
    CC("editor_path"   , PATH[exe["editor"]])
    CC("starting_icon" , "lg.ico", "settings")
    ShowPopup("Configuration complete`nYou are good to go!", C.lgreen, C.bgreen, "200", "60", "-1200", "15") 
    sleep, med*4
    ClosePopup()
    return
  }

  FindAppPath(app*) {
    global UProfile, PF_x86, C
    FOLDER := [PF_x86 "\*",A_ProgramFiles "\*",UProfile "\AppData\Local\Programs\*"]
    PATH := {}
    for each, exe in APP
    {
        ShowPopup("Searching for " exe,C.lblue,,, "60", "-10000", "15")
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
    global C
    if !supress {
        if state
            ShowPopup("Win+L Lock: ON",,C.bgreen,"200",, "-800")
        else
            ShowPopup("Win+L Lock: OFF", C.lpurple,,"200",, "-800")
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

  
  getWinDim() {
    global config_path
    SysGet, monitorsCount, 80

    if (GC("MonDim","error") == "error") 
        Loop %monitorsCount% {
            SysGet, sg, monitor, %A_index%
            SGw  := Abs(SGLeft - SGRight) , SGh  := Abs(SGtop - SGbottom)
            ; IniWrite,%SGLeft% %SGtop% %SGw% %SGh%, %config_path%, %A_ComputerName%, MonDimSG%A_Index%
            CC(" MonDimSG" A_Index, SGLeft " " SGtop " " SGw " " SGh)
            Gui, z: New, 
            Gui, z: +hwndZhwnd
            Gui, z: show, x%SGLeft% y%SGtop% w%SGw% h%SGh%
            WinSet, Transparent, 0, ahk_id %zhwnd%
            Gui, z: +LastFound -dpiscale +Resize +OwnDialogs +AlwaysOnTop -E0x00200
            WinRestore,zhwnd
            WinMaximize,A
            WinGetPos , xt, yt, wt, ht, A
            CC("MonDim" A_Index, xt " " yt " " wt " " ht)
            SysGet, OutputVar, MonitorPrimary
            if (A_index = OutputVar) {
                CC("MonDimDiff", (xt-SGLeft) " " (yt-SGtop) " " (wt-SGw) " " (ht-SGh))
                adj := xt-SGLeft
            }
            Gui z: Destroy
        }
    
    Exit 
    return

    zGuiClose:
    zGuiEscape:
        Gui z: Destroy
        Exit 

  }

; FILE AND FOLDER RELATED _____________________________________________________
 
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
 

; MOUSE FUNCTIONS _____________________________________________________________
 
  SaveMousPos(key = "A", n = "0") {
    global config_path
    ; CoordMode, Mouse, Screen
    CoordMode, Mouse, Screen
    loop % n
        click
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
 
  TglSetting(sect = "cursor_follow", msg = "Cursor Follow Active Window: ") {
    global config_path, C

    IniRead,  state,    %config_path%, %A_ComputerName%, %sect%, 0
    IniWrite, % !state, %config_path%, %A_ComputerName%, %sect%

    if !state
        ShowPopup( msg "True",C.lgreen,,"300","90", "-800")
    else if state
        ShowPopup( msg "False",C.pink,,"300","90", "-800")
    return
  }
 
  CursorFollowWin(Q = "center", offset_x = "0", offset_y = "100") {
    global config_path
    sleep 100
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
 
  CursorJump(Q = "center", offset_x = "0", offset_y = "0", ScreenDim = False) {
    ; move mouse cursor to the middle of active window
    global short
    Sleep, short * 2
    CoordMode, Mouse, Screen
    if ScreenDim
        winTopL_x := 0, winTopL_y := 0, width := A_ScreenWidth, height := A_ScreenHeight
    else
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


; CHROME ______________________________________________________________________
 
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

; OFFICE ______________________________________________________________________
 
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
    try {
        oWord := ComObjActive("Word.Application")
        oWord.Run(MacroName)
    } catch e {
        MsgBox, something went wrong, check if you have permission to run macros 
        return
    }
  }
 
  command(tgt, opt = "") {
    ; run obsidian command corresponding to tgt string
    Send ^p
    clip(tgt)
    send {Enter}%opt%
    return
  }

; TEXT MANIPULATION ___________________________________________________________

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
  
  CaseRotation(){
    static key
    key++                        
    if key = 1
        Capitalize1stLetter()
    else if key = 2
        ConvertUpper()
    else if key = 3
    {
        ConvertLower()   
        key = 0
    }
    return
  }

  ConvertUpper(var = "", paste = True) {
    ; Convert selected text to uppercase
    ReleaseModifiers()
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
    ReleaseModifiers()
    var := !var ? clip() : var
    StringReplace, var, var, `r`n, `n, All
    StringLower, var, var
    if !paste
        return %var%
    clip(var, True)
    return
  }
 
  EveryCapitalize1stLetter(var = "", paste = True, other_letters_lowercase = True) {
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
 
  Capitalize1stLetter(var = "", paste = True, firstWord = True, LowerCaseOthers = True) {
    ; Capitalize just first letter of selected text
    ReleaseModifiers()
    var := (!var ? clip() : var)
    StringReplace, var, var, `r`n, `n, All
    if firstWord 
    {
        StringLower, var, var
        var := RegExReplace(var, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
    } else {
        if (LowerCaseOthers)
            StringUpper, var, var, T
        else 
            var := RegExReplace(var, "(\b[a-z])", "$U1")
    }

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
    ReleaseModifiers()
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
 
; TEST ________________________________________________________________________

