; GLOBAL VARIABLES _____________________________________________________________
  
  ChangeFont := RegisterCallback("ChangeFont")
  short := 150, med := 300, long := 1000
  C := { "AliceBlue"    : "F0F8FF"   ,   "LemonChiffon" : "FFFACD"
       , "Bgreen"       : "29524A"   ,   "Lgreen"       : "CEDFBF"
       , "BGyellow"     : "FFFFE0"   ,   "Linen"        : "FAF0E6"
       , "Black"        : "000000"   ,   "Lorange"      : "FFDEAD"
       , "Blue"         : "0000FF"   ,   "Lpurple"      : "CDC9D9"
       , "BurntUmber"   : "330000"   ,   "Lsalmon"      : "ffc8b3"
       , "Buttercream"  : "EFE1CE"   ,   "Lyellow"      : "FCE28A"
       , "Bwhite"       : "F6F7F1"   ,   "Midnightblue" : "000033"
       , "Chrome"       : "E8F1D4"   ,   "MintCream"    : "F5FFFA"
       , "Cornsilk"     : "FFF8DC"   ,   "Navy"         : "000080"
       , "Cyan"         : "00FFFF"   ,   "OldLace"      : "FDF5E6"
       , "Dblue"        : "093145"   ,   "OldWhite"     : "FAEBD7"
       , "Dgreen"       : "013220"   ,   "Onyx"         : "353839"
       , "Dgrey"        : "525252"   ,   "Pbrown"       : "D4C4B5"
       , "Dpurple"      : "330033"   ,   "Pink"         : "F6E1E0"
       , "Drkcherryred" : "330000"   ,   "Purple"       : "800080"
       , "Dyellow"      : "ECC846"   ,   "RawUmber"     : "333300"
       , "GhostWhite"   : "F8F8FF"   ,   "Rblue"        : "165CAA"
       , "Green"        : "107A40"   ,   "Red"          : "FF0000"
       , "KashmirGreen" : "003300"   ,   "SeaGreen"     : "CFE2CF"
       , "Lblue"        : "BED7D6"   ,   "Silver"       : "CCCCCC"
       , "Lbrown"       : "DFD0BF"   ,   "Vlorange"     : "ffe4b3"
       , "Lcoral"       : "FFA07A"   ,   "White"        : "FFFFFF"
       , "Ldaisy"       : "EFD469"   ,   "WhiteSmoke"   : "F5F5F5" 
       , "lgrey"        : "EDEDED"   }
  
  GroupAdd, FileListers, ahk_class CabinetWClass                                ; create reference group for file explorer and open + save dialogue boxes
  GroupAdd, FileListers, ahk_class WorkerW                                      ; https://www.autohotkey.com/boards/viewtopic.php?t=28347
  GroupAdd, FileListers, ahk_class #32770, ShellView

  GroupAdd, browsers, ahk_exe vivaldi.exe
  GroupAdd, browsers, ahk_exe chrome.exe 
  GroupAdd, browsers, ahk_exe msedge.exe 
  GroupAdd, browsers, ahk_exe firefox.exe
        

; WINDOW MANAGEMENT ____________________________________________________________
  mw(Q){
      MoveWin(Q)
  }

  MoveWinWIP(Q = "TL", xa=0,ya=0, ha=0,wa=0) {

    global config_path, CB_hwnd
    CoordMode, Mouse, Screen
    static x, y, w, h
    WinRestore, A
    MI := StrSplit(GetMonInfo()," ")                                            ;getmonitordimensions    
    y:=MI[2]+ya-ha                                                              ;adjustments made to account for taskbar on top instead of taskbar on bottom 
    h:=A_ScreenHeight
    w:=A_ScreenWidth
    x:=MI[1]+xa-wa    

    hw:= w/2  , qw := w/4  , hh:= h/2  , qh := h/4

    if (winactive("ahk_id " CB_hwnd) and !GC("CB_Display"))
        return

    switch Q
    {
        case "F" ,"0Maximize"             : x := x      , y := y       , w := w    , h := h                   
        case "TL","1TopLeft"              : x := x      , y := y       , w := hw   , h := hh    
        case "TR","1TopRight"             : x := x+hw   , y := y       , w := hw   , h := hh    
        case "BL","2BottomLeft"           : x := x      , y := y+hh    , w := hw   , h := hh    
        case "BR","2BottomRight"          : x := x+hw   , y := y+hh    , w := hw   , h := hh    
        case "L" ,"0LeftHalf"             : x := x      , y := y       , w := hw   , h := h     
        case "R" ,"0RightHalf"            : x := x+hw   , y := y       , w := hw   , h := h     
        case "T" ,"0TopHalf"              : x := x      , y := y       , w := w    , h := hh    
        case "B" ,"0BottomHalf"           : x := x      , y := y+hh    , w := w    , h := hh    
        case "LS","3LeftHalfSmall"        : x := x      , y := y       , w := qw   , h := h
        case "RS","3RightHalfSmall"       : x := x+3*qw , y := y       , w := qw   , h := h
        case "TS","4TopHalfSmall"         : x := x      , y := y       , w := w    , h := qh
        case "BS","4BottomHalfSmall"      : x := x      , y := y+hh+qh , w := w    , h := qh
        case "L1","L1TopLeftSmall"       : x := x      , y := y       , w := hw   , h := qh
        case "L1v","L1vTopLeftSmall"       : x := x      , y := y       , w := qw   , h := hh
        case "L2","L2TopMidLeftSmall"     : x := x      , y := y+qh    , w := hw   , h := qh
        case "L3","L3BottomMidLeftSmall"  : x := x      , y := y+hh    , w := hw   , h := qh
        case "L4","L4BottomLeftSmall"    : x := x      , y := y+3*qh  , w := hw   , h := qh
        case "L4v","L4vBottomLeftSmall"    : x := x      , y := y+hh    , w := qw   , h := hh
        case "R1","R1TopRightSmall"     : x := x+hw   , y := y       , w := hw   , h := qh
        case "R1v","R1vTopRightSmall"       : x := x+3*qw , y := y       , w := qw   , h := hh
        case "R2","R2TopMidRightSmall"    : x := x+hw   , y := y+qh    , w := hw   , h := qh
        case "R3","R3BottomMidRightSmall" : x := x+hw   , y := y+hh    , w := hw   , h := qh
        case "R4","R4BottomRightSmall"  : x := x+hw   , y := y+3*qh  , w := hw   , h := qh
        case "R4v","R4vBottomRightSmall"    : x := x+3*qw , y := y+hh    , w := qw   , h := hh
        default:                                                              
            return
    }
    
    ;msgbox % x " " y " " h " " w    

    if (winactive("ahk_id " CB_hwnd)) {
        if !GC("CB_ScrollBars", 0)
            GuiControl, 2: -HScroll -VScroll, CB_Display
        Gui, 2: show
        settimer, addHiddenScrollBar,-400
        CC("CB_position", "x" x " y" y " w" w " h" h)
    }

    WinMove,A,, x, y, w, h
    
  } ; move active window to different areas of the screen

  MoveWin(Q = "TL", xa=0,ya=0, ha=0,wa=0) {

    global config_path, CB_hwnd
    static x, y, w, h
    WinRestore, A
    MI := StrSplit(GetMonInfo()," ")                                            ;getmonitordimensions    
    y:=MI[2]+ya-ha                                                              ;adjustments made to account for taskbar on top instead of taskbar on bottom 
    h:=MI[4]+ha
    w:=MI[3]+wa
    x:=MI[1]+xa-wa        

    hw:= w//2  , qw := w//4  , hh:= h//2  , qh := h//4

    if (winactive("ahk_id " CB_hwnd) and !GC("CB_Display"))
        return

    switch Q
    {
        case "F" ,"0Maximize"             : x := x      , y := y       , w := w    , h := h                   
        case "TL","1TopLeft"              : x := x      , y := y       , w := hw   , h := hh    
        case "TR","1TopRight"             : x := x+hw   , y := y       , w := hw   , h := hh    
        case "BL","2BottomLeft"           : x := x      , y := y+hh    , w := hw   , h := hh    
        case "BR","2BottomRight"          : x := x+hw   , y := y+hh    , w := hw   , h := hh    
        case "L" ,"0LeftHalf"             : x := x      , y := y       , w := hw   , h := h     
        case "R" ,"0RightHalf"            : x := x+hw   , y := y       , w := hw   , h := h     
        case "T" ,"0TopHalf"              : x := x      , y := y       , w := w    , h := hh    
        case "B" ,"0BottomHalf"           : x := x      , y := y+hh    , w := w    , h := hh    
        case "LS","3LeftHalfSmall"        : x := x      , y := y       , w := qw   , h := h
        case "RS","3RightHalfSmall"       : x := x+3*qw , y := y       , w := qw   , h := h
        case "TS","4TopHalfSmall"         : x := x      , y := y       , w := w    , h := qh
        case "BS","4BottomHalfSmall"      : x := x      , y := y+hh+qh , w := w    , h := qh
        case "L1","L1TopLeftSmall"       : x := x      , y := y       , w := hw   , h := qh
        case "L1v","L1vTopLeftSmall"       : x := x      , y := y       , w := qw   , h := hh
        case "L2","L2TopMidLeftSmall"     : x := x      , y := y+qh    , w := hw   , h := qh
        case "L3","L3BottomMidLeftSmall"  : x := x      , y := y+hh    , w := hw   , h := qh
        case "L4","L4BottomLeftSmall"    : x := x      , y := y+3*qh  , w := hw   , h := qh
        case "L4v","L4vBottomLeftSmall"    : x := x      , y := y+hh    , w := qw   , h := hh
        case "R1","R1TopRightSmall"     : x := x+hw   , y := y       , w := hw   , h := qh
        case "R1v","R1vTopRightSmall"       : x := x+3*qw , y := y       , w := qw   , h := hh
        case "R2","R2TopMidRightSmall"    : x := x+hw   , y := y+qh    , w := hw   , h := qh
        case "R3","R3BottomMidRightSmall" : x := x+hw   , y := y+hh    , w := hw   , h := qh
        case "R4","R4BottomRightSmall"  : x := x+hw   , y := y+3*qh  , w := hw   , h := qh
        case "R4v","R4vBottomRightSmall"    : x := x+3*qw , y := y+hh    , w := qw   , h := hh
        default:                                                              
            return
    }
    
    
    if (winactive("ahk_id " CB_hwnd)) {
        if !GC("CB_ScrollBars", 0)
            GuiControl, 2: -HScroll -VScroll, CB_Display
        Gui, 2: show
        settimer, addHiddenScrollBar,-400
        CC("CB_position", "x" x " y" y " w" w " h" h)
    }

    WinMove,A,, x, y, w, h
    
  } ; move active window to different areas of the screen

  WinPos() {
                q := { "q" : "1TopLeft"         
                     , "e" : "1TopRight"        
                     , "z" : "2BottomLeft"      
                     , "c" : "2BottomRight"     
                     , "a" : "0LeftHalf"     
                     , "d" : "0RightHalf"       
                     , "w" : "0TopHalf"         
                     , "s" : "0BottomHalf"      
                     , "dd": "3RightHalfSmall"       
                     , "aa": "3LeftHalfSmall"       
                     , "ww": "4TopHalfSmall"
                     , "ss": "4BottomHalfSmall"
                     , "qq": "L1TopLeftSmall"    
                     , "qa": "L2TopMidLeftSmall"    
                     , "za": "L3BottomMidLeftSmall"    
                     , "zz": "L4BottomLeftSmall" 
                     , "ee": "R1TopRightSmall"   
                     , "ed": "R2TopMidRightSmall"    
                     , "cd": "R3BottomMidRightSmall"                            
                     , "cc": "R4BottomRightSmall" }                             ; "r" optn sorts menu order by value instead of by key (default)
                FB("MoveWin", q, C.bwhite,, "rs")                               ; "s" optn adds a space between case changes for GUI menu   
                return                                                          ;FunctionBox: resize & move window                           
  } ; creates function box to move windows to preset positions
 
  MaximizeWin(){
    ; ReleaseModifiers()
    WinMaximize,A 
  } 

  MinimizeWin(){
    ; ReleaseModifiers()
    WinMinimize,A
  } 
 
  moveWinBtnMonitors() {
    Send +#{Left}
    ; Sendinput +#{Left}
    CursorFollowWin()
    return
  }
 
  WinToDesktop(n = "2") {                                                   
    VD.init()
    wintitleOfActiveWindow:="ahk_id " WinActive("A")
    ; VD.sendToDesktop(wintitleOfActiveWindow,n,0,0)                              ; VD.sendToDesktop(wintitle,whichDesktop, followYourWindow := false, activate := true)
    VD.MoveWindowToDesktopNum(wintitleOfActiveWindow, n)
    return 
  } ; move window between virtual desktops https://github.com/FuPeiJiang/VD.ahk
  
  getCurrentDesktop() {
    VD.init()
    return % VD.getCurrentDesktop()
  } ; return virtual desktop numbers

  GotoDesktop(n = "2") {                                                        ; https://github.com/FuPeiJiang/VD.ahk
    VD.init()
    VD.goToDesktopNum(n)
    return 
  } ; switch to particular virtual desktop
  
  TitleTest(tab_name="MISC.txt", mode = 2) {
    ; checks if tab_name matches the active window title
    ; returns boolean

    ; MODES:
    ; 1 = A window's title must start with the specified tab_name to be a match.
    ; 2 = A window's title can contain tab_name anywhere inside it to be a match.
    ; 3 = A window's title must exactly match tab_name to be a match.
    
    WinGetActiveTitle, title
    switch mode 
    {
        case 1: result := (InStr(title, tab_name) == 1)
        case 2: result := (InStr(title, tab_name) >= 1)
        case 3: result := (InStr(title, tab_name) == 1) && (strlen(title) == strlen(tab_name))
        default:
    }
    return % result

  } ; creates condition for context-sensitive hotkeys
 
  ActivateWin(title="Chrome") {
    SetTitleMatchMode, 2                                                        ; match anywhere in title
    IfWinExist, %title%
        WinActivate, %title%
    return
  } 
 
  SaveWinID(key = "L") {
    global config_path, C
    vde := getCurrentDesktop()                                                  ; virtual desktop environment 
    WinID_%vde%_%key% := WinExist("A")
    IniWrite, % WinID_%vde%_%key%, %config_path%, %A_ComputerName%, WinID_%vde%_%key%
    PopUp("WinID_" vde "_" key " saved", C.lgreen, C.bgreen, "300", "60", "-1000", "16", "610")
    return
  }
 
  ActivateWinID(key = "L") {
    global config_path
    vde := getCurrentDesktop()                                                  ; virtual desktop environment 
    IniRead, output, %config_path%, %A_ComputerName%, WinID_%vde%_%key%
    BlockInput, Mousemove
    settimer, BlockInputTimeOut,-600
    ActivateWin("ahk_id " output), CursorFollowWin()
    BlockInput, MousemoveOff
    return
  }
 
  CloseAllPrograms() {
    WinGet, id, list, , , Program Manager
    Loop, %id%
    {
        StringTrimRight, this_id, id%a_index%, 0
        WinGetTitle, this_title, ahk_id %this_id%
        winclose,%this_title%
    }
    Return
  } ; close all open programs (used before system shutdown)
 
  CloseClass() {
    WinGetClass class, A
    GroupAdd    grp, ahk_class %class%
    WinClose    ahk_group grp
    return
  } ; close all instances of active program
 
  
  AlwaysOnTop(state = True, supress = False) {
    
    global C
    WinGet, Process_Name, ProcessName, A
    WinGetTitle, Title, A
    WinGetClass, class, A
    if (state)
    {
        Winset, Alwaysontop, ON , A
        if (!supress)
            PopUp(Process_Name "`nalways on top: ON", C.lgreen, C.bgreen,"250","120", "-800")
    } else {
        Winset, Alwaysontop, OFF , A    
        if (!supress) 
            PopUp(Process_Name "`nalways on top: OFF", C.pink, C.red,"250","120","-800") 
    }
    return
  } ; toggle active window to be always on top
 
  ActivatePrevInstance() {
    WinGetClass, ActiveClass, A
    WinGet,      p_name,      ProcessName , ahk_class %ActiveClass%
    WinGet,      n_instances, List,         ahk_class %ActiveClass%
    BlockInput, Mousemove
    settimer, BlockInputTimeOut,-600
    if (n_instances > 1)
    {
        WinSet, Bottom,, A
        WinActivate, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,   ; excludes windows with "tabs outliner" in the title
    }
    CursorFollowWin()
    BlockInput, MousemoveOff
    return
  } ; activate newest instance of active program if multiple instances exist

  
  ActivateNextInstance() {
    WinGetClass, ActiveClass, A
    WinGet,      p_name,      ProcessName , ahk_class %ActiveClass%
    WinGet,      n_instances, List,         ahk_class %ActiveClass%
    SetStoreCapsLockMode, Off
    BlockInput, MouseMove
    settimer, BlockInputTimeOut,-600
    if (n_instances > 1) {
        WinActivateBottom, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,
    }        
    CursorFollowWin()
    BlockInput, MouseMoveOff
    SetStoreCapsLockMode, on
    return
  } ; activate oldest instance of active program if multiple instances exist
  
  HideShowTaskbar(action) {
    static ABM_SETSTATE := 0xA, ABS_AUTOHIDE := 0x1, ABS_ALWAYSONTOP := 0x2
    VarSetCapacity(APPBARDATA, size := 2*A_PtrSize + 2*4 + 16 + A_PtrSize, 0)
    NumPut(size, APPBARDATA), NumPut(WinExist("ahk_class Shell_TrayWnd"), APPBARDATA, A_PtrSize)
    NumPut(action ? ABS_AUTOHIDE : ABS_ALWAYSONTOP, APPBARDATA, size - A_PtrSize)
    DllCall("Shell32\SHAppBarMessage", UInt, ABM_SETSTATE, Ptr, &APPBARDATA)
  } ; https://www.autohotkey.com/boards/viewtopic.php?t=60866
 
  toggle_DarkMode(){       
    #SingleInstance Force                                                       ; Allow only one instance off this app]                           
    ; #NoTrayIcon                                                               ; remove SystemTray icon                                  
    ; read the System lightmode from the registry 
    RegRead,L_LightMode,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme
    If L_LightMode {                                                            ; if the mode was Light                            
        ; write both system end App lightmode to the registry
        RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,0
        RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme   ,0
        }
    else {                                                                      ; if the mode was dark                                         
        ; write both system end App lightmode to the registry
        RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,1
        RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme   ,1
        }
    ; tell the system it needs to refresh the user settings
    run,RUNDLL32.EXE USER32.DLL`, UpdatePerUserSystemParameters `,2 `,True
  } ; toggle dark/light mode for windows apps https://www.autohotkey.com/boards/viewtopic.php?t=73967
 
; SYSTEM APPS __________________________________________________________________
 
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
  
  ActivateCalc() {
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
    CFW()
    return
  } ; activate windows calculator app

  ActivateMail() {
    IfWinExist, Inbox - Gmail
        WinActivate                                                             ; use the window found above                                                     
    else
        Run % A_ScriptDir "\assets\win\Mail.lnk"
    return
  } ; activate windows mail app
 
  TskMgrExt() {
    global long
    sleep, long
    WinMaximize,A
    CursorFollowWin()                                                           
    return
  }

  DisplaySettings() {
    global med
    Run explorer.exe ms-settings:display
    settimer, CFW,-600
  }
 
  BluetoothSettings() {
    global med
    Run explorer.exe ms-settings:bluetooth
    settimer, CFW,-600
  }
 
  SoundSettings() {
    global med
    Run explorer.exe %A_WinDir%\system32\mmsys.cpl
    sleep med
    CFW()

  }
 
  OpenHotStringLog() {
   Run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv
  }
 
  NotificationWindow() {
    Send {lwin down}a{lwin up}
  }

  RunProgWindow() {
    ; PostMessage, 0x111, 401, 0, , ahk_class Shell_TrayWnd  ;Get Windows Run Dialog
    Send {lwin down}r{lwin up}
  }
 
  StartContextMenu() {
    Send {lwin down}x{lwin up}
  }
 
  QuickConnectWindow() {
    Send {lwin down}k{lwin up}
  }
 
  WindowsSettings() {
    global med
    Send {lwin down}i{lwin up}
    sleep med
    CFW()
  }
 
  PresentationDisplayMode() {
    global med
    Send {lwin down}p{lwin up}
    sleep, med
    CFW()
  }
 
  SysTray() {
    If (!WinExist("ahk_class NotifyIconOverflowWindow"))
    {
       Send #b
       Send {Space}
    }
    else
       WinClose, ahk_class NotifyIconOverflowWindow
    return
  }

  KeyHistory() {
    KeyHistory
  }
 
  StartMenu() {
    Send ^{esc}
  }
 
  Windowspy() {
    try {
        run, golems\tools\WindowSpy.ahk
    } catch e {
        SplitPath, A_AhkPath, , Dir, , 
        run, % dir "\WindowSpy.ahk"                                       
    }
    return
  }

  
  
  ExitAHK() {
    ExitApp
  }
  
  
 
; COMMAND BOX __________________________________________________________________
  
  RunCmd(Prefix="",sfx="~win", n = 1, autoSelect = True){
    global med
    sleep, med
    ; ReleaseModifiers()
    ; SetBatchLines, -1
    ; SetkeyDelay, -1
    ; SetWinDelay, -1

    ; settimer, BlockInputTimeOut,-1000
    
    if (autoSelect = True)
    {
        Send % "+^{left " . n . "}"
    }
    userInput := clip()
    if (substr(Prefix,1,1) == "V") {
        Prefix := LTrim(Prefix, "V"), userInput := trim(userInput)
        AccessCache(userInput,(userinput ~= "\b[0-9]\b") ? ("") : Prefix)
    } else {
        Send {del}
        RunLabel(userInput, sfx, WinExist())  
    }
  }
   
  GUISubmit(commandkey = ">!space") {
    global short, med, long
    Gui +LastFound
    GuiControl, Focus, UserInput
    if Instr(A_ThisHotkey, commandkey) {
        Send ^a
        Capitalize1stLetter()
    }
    Send {enter}
    return
  } ; submit GUI userinput; commandkey -> submit also capitalizes first letter of user input 

  addHiddenScrollBar() {
    GuiControl, 2: +HScroll +VScroll, CB_Display
    GuiControl, fb: +HScroll +VScroll, FB_Menu
    Send {shift up}                                                             ; corrects sticky key problem                                                    
    Send {ctrl up}                                                              ; drawing of the CB sometimes interferes 
    Send {lwin up}     
    return
  }

  ToggleDisplay(set = ""){
    static fszDisplay := 11

    if (GC("CB_Display") or (set = "Minimal")) {
        fszDisplay := GC("CBfsz")
        CC("CBfsz", "11")
        CC("CB_Titlebar",0), CC("CB_Display",0) ,CC("CB_persistent",0),CC("CB_Wrap",0),CC("CB_reenterInput",1) 
        , IBw := GC("CB_InputBox_width")
        , MI := StrSplit(GetMonInfo()," ")                                
        , cX := (MI[3] - IBw) // 2
        , mw := IBw + 4
        , mh := 20 + (2 * GC("CBfsz", "11"))
        , bY := MI[4] - mh - (2.1 * GC("CBfsz", "11"))
        , CC("CB_position","x" cX " y" bY " w" mw " h" mh)
    } else if (!GC("CB_Display") or (set = "Display")) {
        CC("CBfsz", fszDisplay)
        CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0),CC("CB_persistent",0),CC("CB_Wrap",0),CC("CB_reenterInput",1)
        , MI := StrSplit(GetMonInfo()," ")                              
        , d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
        , CC("CB_position", d)
    }
    CB(GC("CB_sfx"), GC("CBw_color"), GC("CBt_color"), GC("CB_ProcessMod"))
    return
  }

  RunOtherCB(C_input = "", Chr = "W") {
    C_1stchr := SubStr(C_input, 1, 1)
    if (SubStr(C_input, 1, 1) = ":") 
    {
        CC("CB_" Chr "sfx", SubStr(C_input, 2))
        PU(Chr "suffix: " C_input)
        Gui, 2: destroy
        return
    } else {
        sfx := GC("CB_" Chr "sfx", "~win")  
        RunLabel(C_input, sfx, tgt_hwnd)
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
            PopUp("Sorry can't find function",C.lpurple,,,,-2000)
        }
    }
    return
  }

  RunLabel(UserInput="", suffix = "", tgt_winID ="", base_sfx = "~win") {   
    suffix := suffix ? suffix : GC("CB_sfx")
    UserInput := trim(UserInput)
    Switch 
    {
        Case IsLabel(        UserInput . suffix)   : UserInput :=         UserInput . suffix
        Case IsLabel(":X:" . UserInput . suffix)   : UserInput := ":X:" . UserInput . suffix
        Case IsLabel(":*:" . UserInput . suffix)   : UserInput := ":*:" . UserInput . suffix
        Case IsLabel(        UserInput . base_sfx) : UserInput :=         UserInput . base_sfx
        Case IsLabel(":X:" . UserInput . base_sfx) : UserInput := ":X:" . UserInput . base_sfx
        Case IsLabel(":*:" . UserInput . base_sfx) : UserInput := ":*:" . UserInput . base_sfx
        Default:
            CB(GC("CB_sfx"), GC("CBw_color"), GC("CBt_color"), GC("CB_ProcessMod"))
            return
    }     
    ActivateWin("ahk_id " tgt_winID)
    sleep 50
    Gosub, %UserInput% 
    if !GC("CB_persistent",0) or WinExist("ahk_id " CB_hwnd) {
        Gui, 2: +LastFound
        CleanHist(100)
        Gui, 2: destroy
        exit
    }
  }

  CB( sfx = "~win", w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand") {
    CommandBox(sfx, w_color, t_color, ProcessMod)
  }
  
  CreateCacheListListView(name = "cc", folder = "") {
    global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
    global strDir  := A_ScriptDir . "\mem_cache\" . folder
    global cacheList := ""
    global config_path
    
    FileDelete %strFile%
    ; IniWrite, %name%, %config_path%, %A_ComputerName%, CB_display
    CC("CB_display", name)
    ; max_len := count := 0

    Gui,2: Add, ListView, r20 w700 gMyListView, Name
    Loop Files, %strDir%*.*, R                                                  ; Recurse into subfolders.  
    {   
        file := SubStr(A_LoopFileFullPath, strlen(strDir) + 1) . "`n"           ; get file name  
        ; count := count + 1                                                      ; count rows 
        cacheList .= file                                                       ; append file name to list 
        LV_Add("", A_LoopFileFullPath)
        ; max_len := max(strlen(file), max_len)                                   ; get max column width 
    }
    LV_ModifyCol()
    Gui, 2:Show
    return

    
    MyListView:
    if (A_GuiEvent = "DoubleClick")
    {
        LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
        ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
    }
    return

    GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
    ExitApp
    ; return % cacheList
    

    ; halfCount := round(count/2,0) + 1
    ; arr := StrSplit(cacheList , "`n","`n",halfCount)
    ; right_arr := arr.Pop()
    ; Rarr := StrSplit(right_arr, "`n", "`n")
    ; cache_contents := ""
    ; char_width := 0
    ; loop % halfCount
    ; {
    ;     space_len  := (max_len - strlen(arr[A_Index]))  
    ;     s := RepeatString(" ", space_len)
    ;     line := arr[A_Index] . s . Rarr[A_Index] . "`n" 
    ;     cache_contents .= line
    ;     char_width := max(strlen(line), char_width)

    ; }
    ; ; Sort, cache_contents, CL
    ; cache_contents := "CACHE CONTENTS " . folder . "`n" . RepeatString("-", char_width) . "`n`r" . cache_contents
    ; FileDelete, mem_cache\%name%.txt
    ; FileAppend, %cache_contents%, mem_cache\%name%.txt
    ; return % cache_contents
  }

  CreateCacheList(name = "cc", folder = "") {
    global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
    global strDir  := A_ScriptDir . "\mem_cache\" . folder
    global cacheList := ""
    global config_path
    
    FileDelete %strFile%
    ; IniWrite, %name%, %config_path%, %A_ComputerName%, CB_display
    CC("CB_display", name)
    max_len := count := 0
    Loop Files, %strDir%*.*, R                                                  ; Recurse into subfolders.  
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
    cache_contents := "CACHE CONTENTS " . folder . "`n" . RepeatString("-", char_width) . "`n`r" . cache_contents
    FileDelete, mem_cache\%name%.txt
    FileAppend, %cache_contents%, mem_cache\%name%.txt
    return % cache_contents
  }

  GUIRecall() {
    global short, med, long, config_path
    OutputVar := GC("last_user_input")
    Gui +LastFound
    GuiControl,2: Focus, UserInput
    ; GuiControl,2: Focus, UserInput
    Send {home}+{end}
    clip(OutputVar)
    Send {home}+{end}
    return
  }

  GUIFocusInput(t = "CB") {
    global CB_hwnd, FB_hwnd, short, UserInput
    static GUI_hwnd := ""
    switch t
    {
        Case "CB": GUI_hwnd := CB_hwnd
        Case "FB": GUI_hwnd := FB_hwnd
    }
    ; msgbox % GUI_hwnd
    ActivateWin("ahk_id " GUI_hwnd) 
    GuiControl, Focus, UserInput
    ; Sendinput {tab}{home}+{end}                                               bb
    return
  }
 
  UDSelect(d="down", interval = "5", c_input = "", select = True, MultiCursor = False, letter = "jk", MC_key = "rshift") {
    global short
    sleep short
    RegExMatch(c_input, "([0-9]+)", num)
    RegExReplace(c_input, "i)[" letter "]", "", oCount)
    n := num ? num : interval
    n := n + (oCount * interval)
    test := n + (oCount * interval)
    Switch  
    {
        Case Instr(c_input, "!"):
            Sendinput % "+{" . d . " " . n . "}{del}"
        case MultiCursor, Instr(A_ThisHotkey, MC_key):
            keywait, shift
            if WinActive("ahk_exe code.exe")
                Sendinput % "+^!{" . d . " " . n . "}"                          ; multi cursor selection for VScode                   
            else 
                goto, normal
        Default:
            normal:
            Sendinput % select  
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

  BufferKeystrokes() {
    global input_buffer
    ; BlockInput, on
    ; settimer, BlockInputTimeOut,-300
    SetTimer, CheckKeystrokeBuffer, -300
    input, input_buffer, V T.3
    return
  } ; captures keystrokes while a GUI is loading to pre-enter into the input box

  CheckKeystrokeBuffer(){
    global input_buffer
    if input_buffer 
        clip(input_buffer)
    return
  }

  CleanHist(lines = 30){
    CleanedHist := TF_RemoveDuplicateLines(AccessCache("_hist",,False))
    CleanedHist := TF_RemoveLines(CleanedHist, lines)
    FileDelete, mem_cache\_hist.txt
    WriteToCache("_hist.txt",,,CleanedHist,1,1)
  } ; remove duplicates and truncate CB history file
  

; FUNCTION BOX _________________________________________________________________
  
  FB(func="", input_dict="", w_color = "BED7D6", t_color = "000000", name_dict = "", grps = 0, title="", p*) {
    FunctionBox(func, input_dict, w_color, t_color, name_dict, grps, title, p*) 
  }

  FunctionBox(func="", input_dict="", w_color = "CEDFBF", t_color = "000000", optn = "", grps = 0,toc_dict="", title="", p*) {
 
    ; FunctionBox() opens an input box offering choices based on input_dict array, 
    ;
    ; func: calls a function that accepts values from the input array
    ;       the value of input_dict will be treated as a parameter to that function. 
    ;
    ; optn: "i" => applies special formatting to input dictionary for TOC generation
    ;              
    ;   

    global UserInput, med, config_path, uprofile
    ; sleep ,med                                                                ; short wait to delete hotstring                                                         
    
    TOC := (toc_dict) ? BuildTOC(toc_dict, optn, grps) : BuildTOC(input_dict, optn, grps)
    default_title := (!title) ? AddSpaceBtnCaseChange(func, 0) : title
    default_title .= "  (-_-)  "                                                ; l := "    |    "                                              
    winget, output, ProcessName, A    
    ; title_app := Capitalize1stLetter(output,0, True)
    ; default_title := title_app "  " default_title
    
    ; IniWrite, %FB_tgt_hwnd%, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    FB_tgt_hwnd := WinExist("A")                                                ; store win ID of active application before calling GUI                                           
    
    FunctionBoxGUI(TOC, default_title, w_color, t_color, input_dict, optn, grps, toc_dict, title, p*)
    ; Iniread, tgt_winID, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    ; ActivateWin("ahk_id " FB_tgt_hwnd)
    UserInput := trim(UserInput)
    
    if (func and input_dict[UserInput]) {
        if !(p.MaxIndex() > 0) 
            %func%(input_dict[UserInput])
        else 
            %func%(input_dict[UserInput], p*)
    } else if (!func and input_dict[UserInput]) {
        try 
        { 
            command := input_dict[UserInput]
            %command%.call()
        }
    } else if UserInput                                                         
        FunctionBox(func, input_dict, w_color, t_color, optn, grps, toc_dict, title, p*)
    
    return
  } ; run same function with different parameters from dictionary {"key" : "parameter"}

  FunctionBoxGUI(TOC, title, w_color ="CEDFBF", t_color = "000000" , input_dict="", optn="", grps="", toc_dict="", p*) {
    global FB_Menu := "", UserInput := "", FB_hwnd := ""
    static InputWidth := 170
    BufferKeystrokes()
   ; build gui -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    FB_tgt_hwnd := WinExist("A")                                                ; store win ID of active application before calling GUI                                               
    IniWrite, %FB_tgt_hwnd%, %config_path%, %A_ComputerName%, FB_tgt_hwnd
    winget, output, ProcessName, A    
    reloadFB:
    Gui, +LastFound 
    Gui, fb: Destroy

    Gui, fb: New, ,%title%
    Gui, fb: +OwnDialogs +Owner +DPIscale +AlwaysOnTop 
    Gui, fb: font,s12 %t_color%, Consolas
    ; Gui, fb: Margin, 5, 5
    rows := countrows(TOC)
    rows := (rows < 2) ? 2 : (rows > 25) ? 25 : rows
    Width := StringWidth(toc, "Consolas", 12) + 10
    Width := (Width < 200) ? 200 : (Width > 1000) ? 1000 : Width
    ; msgbox % Width
    Gui, fb: Add, Edit, section x2 w%Width% R%rows% ReadOnly -HScroll -VScroll -wrap -E0x200 vFB_Menu
    
    Guicontrol, ,FB_Menu, %TOC%
    Gui, fb: Add, Edit, xm-5 y+10 w%InputWidth% r1 vUserInput ;,% GC("chr_path")
    Gui, fb: Add, Button, Default Hidden gButtonOK, OK ;
    Gui, fb: font,s8 , calibri
    Gui, fb: add, text, xs xm-5 yp-10, case insensitive
    Gui, +LastFound 
    FB_hwnd  := WinExist()
    GetGUIWinCoords(GUI_X, GUI_Y)
    Gui, Color, %w_color%
    GuiControl, -HScroll -VScroll, FB_menu
    ; Gui, fb: Show, AutoSize
    Gui, fb: Show, hide AutoSize
    Gui, fb: Show, % "x" GUI_X " y" GUI_Y Restore                               ; Show gui at center of active screen                              
    GuiControl, fb: Focus, UserInput
    ; Send % GC("chr_path") ? ("{end}") : ("")
    ; Gui, fb: Show, % "x" GUI_X " y" GUI_Y                                     ; Show gui at center of current screen                                     
    settimer, addHiddenScrollBar,-400
    BlockInput OFF
    WinWaitClose
    return

   ; labels -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    ButtonOK:

        Gui, fb: +LastFound
        ; Gui, fb: Submit                                                       ; Save the input from the user to each control's associated variable.                                                       
        Gui, fb: Submit, Nohide
        Gui, fb: Destroy 
        1stChar := SubStr(UserInput, 1, 1)
        2ndChar := SubStr(UserInput, 2, 1)
        if (1stChar = "+") and RegExMatch(2ndChar,"[A-Za-z]") {
            RunLabel(UserInput, "~win", FB_tgt_hwnd)
        } else if (1stChar = ":") {
            UserInput := ltrim(UserInput, ":")
            tgt_hwnd := FB_tgt_hwnd
            ProcessCommand(UserInput, "~win", title, fsz, fnt, w_color, t_color)
            ; SetTimer, reloadWG, -700
        } else if (1stChar ~= "[0-9]") {
            UserInput := GC("chr_path","F") . UserInput
        }
        reloadWG()
        return
   
    fbGuiClose:
    ButtonCancel:
    fbGuiEscape:
       UserInput := ""
       Gui, fb: Destroy
       return
  } ; 
 
  BuildTOC(arr = "", optn = "" , grps = 0, maxW = 45) {
    ; buils a table of contents string created from a dictionary input array.
    ; alt_arr tells function that 
    ; otpn :
    ;      r = reverse (sort order by value instead of key)
    ;      s = adds a space between case changes in array value for TOC menu presentation

    arr_KV_swapped := {}                                                        ; key value swapped version of input array
    max_str_len := 0
    arr := alt_arr ? alt_arr : arr
    TOC := ""
    for key, val in arr                                                         ; this loop cleans dictionary values and creates a key:value swapped
    {      
        strReplace(val, "\",,count)                                             ; version of the array (to display TOC sorted by value instead of key)
        if (count > 1)
            RegExMatch(val, "[^\\]+$", selection)
        else
            selection := val

        selection := ReplaceAwithB(,,selection, False)                          ; replace consecutive bank spaces with 1 space
        selection := ReplaceAwithB("- ","-",selection,0)
        selection := ReplaceAwithB("_ ","_",selection,0) 
        selection := ReplaceAwithB("_ ","_",selection,0)    
        selection := RegExReplace(selection, "^(?:https?:\/\/)?(?:www\.)?", "") 
        selection := (strlen(selection) > maxW) ? substr(selection, 1, maxW) : selection
        NewStr := SubStr(String, StartingPos , Length)

        selection := InStr(optn, "s") ? Trim(AddSpaceBtnCaseChange(selection, 0)) : selection 
        if InStr(optn , "r")                                                    ; (optn = "r") ;InStr(optn , "r")
            arr_KV_swapped[selection] := key
        else             
            TOC .= (TOC <> "" ? "`n" : "") key "`t" trim(selection, """") 
        max_str_len := max(max_str_len, strlen(key . selection))
    }
    max_str_len := (max_str_len > maxW) ? maxW : max_str_len
    line := RepeatString("-", max_str_len)
    TOC := !InStr(optn , "r") ? ("Key`tSelection`n-----`t" line "`r`n" . TOC) : ("Key`tSelection`n-----`t" line "`r")

    if InStr(optn , "r") {                                                      ; optn for value ordered dictionary             
        For dest, ref in arr_KV_swapped
        {
            
            if grps {
                prefix := substr(dest, 1, 2)
                if (prefix <> prev_prefix and prev_prefix and prefix) {         ; adds blank line between changes in selection group prefix
                    TOC .= "`n" 
                }
                prev_prefix := prefix
            }
            TOC .= (TOC <> "" ? "`n" : "") ref "`t" trim(dest, """")
        }
    }
    return TOC
  } ; buils a table of contents string created from a dictionary input array.


 
; MEM_CACHE / MEMORY SYSTEM ____________________________________________________

  GetNumMemLines(startline=1,endline=1,blen=30, alpha = 0){
    output := ""
    border := RepeatString("-", blen)
    Loop, Files, C:\Users\bings\AHK\mem_cache\?.txt
    {
        if regexmatch(A_LoopFileName, "\d\.txt") or alpha {
            lines := TF_ReadLines(A_LoopFilePath, StartLine, EndLine)           ; FileReadLine, first_line, % A_LoopFilePath, 1       
            splitpath, A_LoopFileName,,,,NameNoExt
            fl := trim(lines, " `t`r`n")
            result =%border%`n[%NameNoExt%] %fl%`n 
            output .= result
        }
        CC("MemSummaryLines", endline)
    }
    line := TF_ReadLines(clipboard, StartLine, EndLine)
    output := "[CB] " line output
    Return % output
  }

  WriteToCache(key, del_toggle = False, mem_path = "", input = "", append = false, supress = False) {
    ; creates a txt file in \mem_cache from selected text
    global C
    ; Critical
    if !RegExMatch(key,"(\.[a-zA-Z]{3})$")
        key .= ".txt"
    if (SubStr(mem_path, 2, 1) = ":")                                           ; check if second character is ":" to test if absolute path given 
        key_path := mem_path . key . RetrieveExt(tgt)
    else if (SubStr(key, 2, 1) = ":")
        key_path := key . RetrieveExt(tgt)                                                       ; check if memory key is actually a path to a file, instead of just the file
    else
        key_path := A_ScriptDir . "\mem_cache\" mem_path . key . RetrieveExt(tgt)

    if !input
        input := clip()                                                         ; captures selected text if no input given 

    if (input = "") {                                                           ; do nothing if no text selected and no input file given 
                                
    } else {
        if !append
            FileDelete, %key_path%
        FileAppend, %input%, %key_path%
        if !supress
            PopUp("Written to " key, C.lgreen)
    }
    if (del_toggle = TRUE)
        Send {del}
    return
  } ; creates a txt file in \mem_cache from selected text

  RetrieveExt(tgt) {
    out := ""
    if !RegExMatch(tgt,"(\.[a-zA-Z]{3})$") {                                    ; if no 3 character file extension given 
        if FileExist(tgt ".txt") 
            out := ".txt"
        else if FileExist(tgt ".ini") 
            out := ".ini"
        return % out
    } 
    return
  }

  AccessCache(key, mem_path = "", paste = True) {
    ; paste contents of txt|ini file or assign to variable
    max_str_len := 0
    if (SubStr(mem_path, 2, 1) = ":")                                           ; check if second character is ":" to test if absolute path given 
        input = %mem_path%%key%
    else if (SubStr(key, 2, 1) = ":")
        input = %key%                                                           ; check if memory key is actually a path to a file, instead of just the file
    else
        input = %A_ScriptDir%\mem_cache\%mem_path%%key%

    if !RegExMatch(input,"(\.[a-zA-Z]{3})$")                                    ; check if there's a file extension
    {
        if FileExist(input ".txt") 
            input .= ".txt"
        else if FileExist(input ".ini") 
            input .= ".ini"
        input
    }

    FileRead, output, %input%
    output := rtrim(output, "`t`n`r")
    if !paste {
        return %output%
    } 
    clip(output)                                                                ; clip(output, True)
    return
  } ; paste contents of txt|ini file or assign to variable

  OverwriteMemory(del_toggle = false) {
    slot := substr(A_ThisHotkey, 0)        
    WriteToCache(slot, del_toggle)                                              ; note: if no text selected, no overwrite will occur                                        
    return
  }

  AddToMemory(del_after_copy = "0", del_breaks = 0, del_blank_lines = 0, del_leading_spaces = 0){
    global C, CB_hwnd, short
    ; CoordMode, Mouse, relative
    ; CoordMode, Mouse, Screen
    BlockInput, on
    settimer, BlockInputTimeOut,-600
    ; MouseGetPos, StartX, StartY
    slot            := substr(A_ThisHotkey, 0)
    input := clip()
    input := del_breaks ? PasteWithoutBreaks(del_breaks,input) : input
    var := del_blank_lines ? RemoveBlankLines(0,var) : var
    input := del_leading_spaces ? RegExReplace(input, " [ `t]+", " ") : input
    ; new_text_to_add := trim(Input)
    new_text_to_add := Input
    FileAppend % "`n" . new_text_to_add, mem_cache\%slot%.txt           
    PopUp("added to bottom of " slot ".txt",C.lgreen)
    If WinExist("ahk_id " CB_hwnd)
        UpdateGUI()
    ; cut := Instr(A_ThisHotkey, "!") ? True : False 
    if (cut = true)
       Send {del}
    ; MouseMove, StartX, StartY
    BlockInput, Off
    return
  }  ; appends selected text to single digit memory file

  RetrieveMemory(mpaste = "^#LButton", mprompt="#!LButton", pasteOvr="PrintScreen", mpasteNum = "0" ) {
    global med, short, C
    WinID := WinExist("A") 
    ; BlockInput, mousemove
    ; settimer, BlockInputTimeOut,-600
    if (Instr(A_ThisHotkey, mprompt)) {
        Clicks(2)
        PopUp("PASTE WHICH SLOT #?",C.lpurple,"000000", "230", "75", "-5000", "14", "610")
        input, mem_slot, L1 T5
        Gui, PopUp: Destroy
    } else if Instr(A_ThisHotkey, mpaste) {
        Clicks(2)
        mem_slot := mpasteNum
        ; PU(mpasteNum " PASTED", C.lgreen, , "230", "75", "-600", "14", "610")
    } else {
        mem_slot := substr(A_ThisHotkey, 0)                                     ; store last key pressed in hotstring/hotkey as memory slot selection                             
    } 

    ActivateWin("ahk_id " WinID)
    ; PU(A_ThisHotkey,,,,, -2000)
    AccessCache(mem_slot)
    if Instr(A_ThisHotkey, pasteOvr) {                               
        del_char := strlen(AccessCache(mem_slot, ,False))
        del_char := (del_char < 200) ? del_char : ""                            ; delete after paste inconsistent with large blocks of multi-line text                  
        Sendinput {del %del_char%}
        return
    }
    BlockInput, Off
    return
  } ; retrieves text to single digit memory file

; AHK UTILITIES ________________________________________________________________

  SaveReloadAHK() {
    KeyWait, ctrl
    SendInput, ^s
    sleep, 200
    WinGetTitle, WindowTitle
    If (InStr(WindowTitle, ".ahk")){
        Reload
    }
    Return
  } ; Ctrl and S → Save changes and, if an AutoHotkey script, reload it
    
  ShowTime(paste_key="", show_key = "", msgbox_key = ""){
    FormatTime, MyTime,, hh:mm:ss tt
    switch A_ThisHotkey
    {
        case show_key:   popup(MyTime,,,,,"-1500")
        case paste_key:  clip(MyTime)
        case msgbox_key: msgbox % MyTime
    }
    return
  } 

  copyFiles(dest_path="", F*) {
    loop % F.MaxIndex()
    {   
        FileCopy,% A_ScriptDir "\" F[A_Index],% dest_path F[A_Index], 1
    }
        
    return
  }

 ; WRAP NATIVE AHK COMMANDS INTO FUNCTIONS -- -- -- -- -- -- -- -- -- 
  S(k = "down", sleep = "100", n = 1, SendInput ="") {                                        
    ; function wrapper to chain line commands using the comma operator
    ; also contains shorter aliases for frequently performed send operations
    ; si := SendInput
    switch k 
    {
        case "suspend"   : suspend
        case "e", "enter": Send % "{enter}"
        case "u", "up"   : Send % "{ up "    n "}"
        case "d", "down" : Send % "{ down "  n "}"
        case "l", "left" : Send % "{ left "  n "}"
        case "r", "right": Send % "{ right " n "}"
        Default          : Send % k
    }
    if sleep 
        sleep, %sleep%
    return
  } ; Send namespace alias/function wrapper to chain line commands using the comma operator

  SI(k = "down", n = 1, sleep = 0 , si =True) {                                        
    ; function wrapper to chain line commands using the comma operator
    ; also contains shorter aliases for frequently performed send operations
    switch k 
    {
        case "suspend"   : suspend
        case "enter"     : % (si ? Sendinput : Send) "{enter}"
        case "u", "up"   : % (si ? Sendinput : Send) "{up " n "}"
        case "d", "down" : % (si ? Sendinput : Send) "{down " n "}"
        case "l", "left" : % (si ? Sendinput : Send) "{left " n "}"
        case "r", "right": % (si ? Sendinput : Send) "{right " n "}"
        Default          : Sendinput % k
        ; Default          : Sendinput % k
    }
    if sleep {
        sleep, %sleep%
    }
    return
  } ; SendInput namespace alias/function wrapper to chain line commands using the comma operator

  reloadWG() { 
    CC("CBfsz", "11")
    Reload                                                                      
  } ; reload WinGolems

 ; MODIFY/ACCESS CONFIG.INI -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  DC(key = "CB_Titlebar", sect = "") {
    global config_path
    section := sect ? sect : A_ComputerName
    IniDelete, %config_path%, %Section% , %Key%
  } ; Delete config.ini entry   

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
  } ; (C)hange (C)onfig.ini entry
  
  GC(key = "CB_Titlebar", d = "") {                                             ; Get Config.ini value
    global config_path
    try {
        IniRead,  val, %config_path%, %A_ComputerName%, %key%, %d%
    } catch {
        /*  loop other sections of config.ini 
            IniRead, SectionNames, %config_path%
            arr := StrSplit(SectionNames, "`n")
            loop 

        */
        return
    }
    arr := StrSplit(SectionNames, "`n")
    return % val
  } ; (G)et (C)onfig.ini value

  TC(sect = "T_CF", msg = "") {

    global config_path, C
    msg := msg ? msg : (sect . ":") 
    IniRead,  state,    %config_path%, %A_ComputerName%, %sect%, 0
    IniWrite, % !state, %config_path%, %A_ComputerName%, %sect%

    if !state
        PopUp( msg "True",C.lgreen,,"300","90", "-800")
    else if state
        PopUp( msg "False",C.pink,,"300","90", "-800")
    return
  } ; (T)oggle (C)onfig.ini variable with 1 or 0, sets to 1 if no variable found

 
 ; POPUPS GUI positioning info -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  PU(msg, w_color = "F6F7F1", ctn = "000000", wn = "400", hn = "75", drtn = "-600", fsz = "16", fwt = "610", fnt = "Gaduigi") {
    PopUp( msg, w_color, ctn , wn, hn, drtn, fsz, fwt, fnt) 
  } ; alias for PopUp 
  
  BlockInputTimeOut() {
    SetTimer,, Off
    BlockInput, MouseMoveOff
    BlockInput, default
    Send {shift up}                                                             ; corrects sticky key problem
    Send {ctrl up}                                                              ; drawing of the CB sometimes interferes
    Send {lwin up}                                                              ; with key up signals, making windows believe the keys is still pressed
    BlockInput, Off
    Return
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
  } ; debugging msgbox. input format: var1, var2 __ output format: msgbox % "var1: " var 1 "`nvar2: " var 2 , etc...
 
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

  GetMonInfo(wa = 0, ha = 0) {
    n := GetCurrentMonitorIndex()
    CC("CBtgt_MonIdx",n)
    SysGet, XY, Monitor , %n%                                                   ; SysGet, XY, MonitorWorkArea , %n%
    x  := XYLeft                 
    y  := XYtop
    w  := Abs(XYLeft-XYRight)+wa , h  := Abs(XYtop-XYbottom)+ha
    ; z := "`n" x " " y " " w " " h
    ; WriteToCache(5,,,z,1,1)
    return % x " " y " " w " " h
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

  WriteToINI(section = "DESKTOP-T6USCO1", key = "T_CF", var = "") {
    global config_path, C
    var := clip()
    PopUp("config.ini updated",C.lgreen,,,,-2000)
    IniWrite, %var%, %config_path%, %section%, %key%
    return
  }
 
  CreateLabel(pfx = "", sfx ="", var = "") {
    var := !var ? clip() : var
    pf := (pfx != "!") ? GC("pfx",":X:") : ""
    sf := GC(sfx,"~win")
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
 
  TimeCode(PU=1) {
    ; ahk codeTimer                                                             ; https://www.AutoHotkey.com/boards/viewtopic.php?t=45263 
    Global StartTimer

    If (StartTimer != "")
    {
        FinishTimer := A_TickCount
        TimedDuration := FinishTimer - StartTimer
        StartTimer := ""
        Sec := round(TimedDuration/1000)
        msg := "around "  Sec  " sec have elapsed!`n"  "("  round(TimedDuration)  " ms)"
        . "`n WinDelay: " A_winDelay
        . "`n KeyDelay : " A_KeyDelay 
        . "`n BatchLines : " A_BatchLines 
        if !PU
            MsgBox % msg
        else
            PU(msg,,,,,-2000)
        
        Return TimedDuration
    }
    Else
        StartTimer := A_TickCount
  }

 ; CONFIGURATION/SETUP -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  ConfigureWinGolems(config_path = "", apps*) {
    global C, exe := {}
    static doc_exe, xls_exe, ppt_exe, pdf_exe, html_exe, editor_exe

    path := RetrieveINI(A_ComputerName, "editor_path")
    if (!FileExist(config_path) or path = "ERROR") {
        Gui, c: +LastFound
        Gui, c: Destroy          
        Gui, c: New,,% "   (-(-_(-_-)_-)-)   WinGolems Configuration"
        Gui, c: +LastFound +OwnDialogs +Owner -DPIscale +Resize +AlwaysOnTop    ; +E0x08000000 +Resize  +E0x00200 (border)
        Gui, c: Color,% C.bwhite
        
        lw := 500, rw := 210
        Gui, c: font, s11 w%lw%, %fnt%, Consolas
        Gui, c: Add, Text,% "w" . (rw + lw) . " xm"
            ,New system detected. Please confirm/modify the following application associations before using WinGolems.`n
        
        Gui, c: font, s10 w%lw%, %fnt%, Consolas
        
        Gui, c: Add, Text, section xm w%lw%,DOC files:`t`tMicrosoft Word  
        Gui, c: Add, Edit, w%rw% ys vdoc_exe,% apps[1]         
        
        Gui, c: Add, Text, section xm w%lw%,XLS files:`t`tMicrosoft Excel
        Gui, c: Add, Edit, section w%rw% ys vxls_exe,% apps[2]
    
        Gui, c: Add, Text, section xm w%lw%,PPT files:`t`tMicrosoft PowerPoint
        Gui, c: Add, Edit, w%rw% ys vppt_exe,% apps[3]         
        
        Gui, c: Add, Text, section xm w%lw%,PDF files:`t`tAdobe Acrobat Reader DC
        Gui, c: Add, Edit, section w%rw% ys vpdf_exe,% apps[4]
        
        Gui, c: Add, Text, section xm w%lw%,HTML files:`t`tChrome Browser 
        Gui, c: Add, Edit, w%rw% ys vhtml_exe,% apps[5]         
    
        Gui, c: Add, Text, section xm w%lw%,Default editor:`t`tVisual Studio Code
        Gui, c: Add, Edit, w%rw% ys veditor_exe,% apps[6]         
        
        Gui, c: Add, Text, section xm w%lw%,
        Gui, c: Add, Button, w%rw% ys Default gSubmit_Button, submit            ; Gui, c: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter ;
        
        Gui, c: show, autosize 
        return
    
        Submit_Button:
            Gui, c: Submit
            exe["doc"] := doc_exe
            exe["xls"] := xls_exe
            exe["ppt"] := ppt_exe
            exe["pdf"] := pdf_exe
            exe["html"] := html_exe
            exe["editor"] := editor_exe
            CreateConfigINI(exe*)
            return
    } else {
        CreateEXEDict()
    }
  }

  CreateEXEDict() {
    apps := ["doc","xls","ppt","pdf","html","editor"]
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
    ; timecode()
    PATH := FindAppPath(exe*)
    CC("doc_path"      , PATH[exe["doc"]])
    CC("xls_path"      , PATH[exe["xls"]])
    CC("ppt_path"      , PATH[exe["ppt"]])
    CC("pdf_path"      , PATH[exe["pdf"]])
    CC("html_path"     , PATH[exe["html"]])
    CC("editor_path"   , PATH[exe["editor"]])
    CC("starting_icon" , "lg.ico", "settings")
    ; timecode(0)
    PopUp("Configuration complete`nYou are good to go!", C.lgreen, C.bgreen, "200", "60", "-1200", "15") 
    sleep, med*4
    ClosePopup()
    return
  }

  FindAppPath(app*) {
    global UProfile, PF_x86, C, winpath
    FOLDER := [A_ProgramFiles "\Microsoft Office*",PF_x86 "\Microsoft Office*",A_ProgramFiles "\Mozilla Firefox\firefox.exe"
        ,PF_x86 "\Google\Chrome\Application\chrome.exe",UProfile "\AppData\Local\Programs\Microsoft VS Code\Code.exe", 
        ,PF_x86 "\*",A_ProgramFiles "\*",UProfile "\AppData\Local\Programs\*",UProfile "\AppData\Local\*",winpath "\system32\*" ]
    PATH := {}
    for each, exe in APP
    {
        PopUp("Please wait`nWinGolems is searching for " exe,C.lblue,,, "60", "-10000", "15")
        for each, dir in FOLDER
        {
            Loop Files, %dir%%exe%, R
            {
                RegExMatch(A_LoopFileFullPath, "[^\\]+$", file_name)
                ; if (strlen(exe) = strlen(file_name)) {                        ; Equal (=), case-sensitive-equal (==)                       
                if (exe = file_name) {                                          ; Equal (=), case-sensitive-equal (==)                        
                    PATH[exe] := A_LoopFileFullPath
                    Continue
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
    CoordMode, Mouse, relative
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
            PopUp("Win+L Lock: ON",,C.bgreen,"200",, "-800")
        else
            PopUp("Win+L Lock: OFF", C.lpurple,,"200",, "-800")
    }
    return
  }

  GenerateHotkeyList() {
    ; generate a .txt list of all active hotkeys 
    ; then opens that .txt in the default editor (config.ini)
    ;ReleaseModifiers()
    global long, med
    run %A_ScriptDir%\golems\tools\Hotkey_Help.ahk                              ; Run modified version of original script
    sleep, long * 2
    DetectHiddenWindows On                                                      ; Allows a script's hidden main window to be detected.
    SetTitleMatchMode 2
    ; Orig_File = %A_WorkingDir%\golems\tools\HotKey Help - Dialog.txt
    FileLocation = %A_WorkingDir%\HotKey_List.txt
    ; FileMove, %Orig_File%, %New_Location%, 1
    SC_key_txt := AccessCache("sck",,False)
    FilePrepend(FileLocation, SC_key_txt)
    sleep, long 
    WinClose %A_ScriptDir%\golems\tools\Hotkey_Help.ahk
    MsgBox,% (4096 + 4), ,Open updated hotkey list in the command box?
    IfMsgBox Yes 
    {
        CC("CB_title", "..\HotKey_List.txt") 
        CC("CB_last_display", "..\HotKey_List.txt") 
        CB(GC("CB_sfx"), GC("CBw_color"), GC("CBt_color"), GC("CB_ProcessMod")) 
    }
    IfMsgBox No
        return
    ; 
  } ; generate a .txt list of all active hotkeys 
  
  ReleaseModifiersTest() {
    static aMod := ["Ctrl", "Alt", "lctrl", "rctrl", "lalt", "ralt", "Shift", "RShift", "LShift", "LWin", "PrintScreen"]
    for i in aMod
        Send % "{" aMod[i] " up}"
  }

  ReleaseModifiersOld(timeout := "") {                                             ; timeout in ms
    ; sometimes modifier keys get stuck while switching between programs
    ; this function call can be embedded in a function to fix that.
    static  aModifiers := ["Ctrl", "Alt", "lctrl", "rctrl", "lalt", "ralt", "Shift", "RShift", "LShift", "LWin", "RWin", "PrintScreen"]
    
    Send {blind}
    
    startTime := A_Tickcount
    while (isaKeyPhysicallyDown(aModifiers))
    {
        if (timeout && A_Tickcount - startTime >= timeout)
            return 1                                                            ; was taking too long
        sleep, 5
    }
    return
  } ; fix stuck modifier keys
 
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

 ; CAPSLOCK AS MODIFIER -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  global CMODE
  CMODE = false

  *capslock::
    EnableCMODE()
  return
  
  *capslock up::
    DisableCMODE()
    SI("{capslock up}")
  return
  
  EnableCMODE()
  {
      CMODE = true
  }
  
  DisableCMODE()
  {
      CMODE = false
  }
  
  IsCMODE()
  {
      return %CMODE% = true
  }


  

; FILE AND FOLDER ______________________________________________________________
  
  ToggleNavPane() {
    ControlFocus, DirectUIHWND2, ahk_class CabinetWClass
    KeyWait()
    Send {Alt}
    Send vn{enter}
    return
  }

  ToggleOpt(optn ="", e = 1 ) {
    ControlFocus, DirectUIHWND2, ahk_class CabinetWClass
    KeyWait()
    Send {Alt}
    Send %optn%
    sleep 200
    if e
        Send {enter}
    return
  }

  SP(key = "") {
    SavePath(key)
    return
  }

  savePath(key = "") {
    BlockInput, on
    settimer, BlockInputTimeOut,-1000
    if WinActive("ahk_exe Explorer.EXE")
        path := Explorer_GetSelection()
    else 
        path := clip()
    CC(key, path)
    PU(key ": " path "`nSAVED",C.lgreen,,,,-1200)   
    BlockInput, Off
    return               
  }

  OP(path = "") {
    OpenPath(path)
    return
  }

  OpenPath(path = "") {
    SplitPath, path, FileName, Dir, Extension, NameNoExt
    Sendinput {esc}
    if (path = "ERROR") {
        PU("No saved path found")
        return
    }
    try {
        if Extension {
            EditFile(path)
        } else {
            OpenFolder(path)
        }
    } catch e {
        PU("Invalid path")
    }
    return
  }

  Explorer_GetSelection() {
    ; Get path of selected files/folders                                        ; https://www.AutoHotkey.com/boards/viewtopic.php?style=17&t=60403
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
 

  ExpandCollapseAllGroups(PosKey = "FE_cg"){
    global med
    WinGetActiveStats, Title, Width, Height, X, Y
    CoordMode, Mouse, relative 
    MouseGetPos, StartX, StartY
    sleep, med * 1.5
    CursorRecall(PosKey, "1", "right", 0) 

    n := 0
    Loop {
        MouseGetPos,,,, fc
        Sleep, fc ? 25 : 0
    } Until !fc ||g_highlight ++n > 80
    sleep 100
    
    Send % (Instr(A_ThisHotkey, "^") ? "{down 3}" : "{down 2}") "{Enter}"       ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise       
    ; Send % (Instr(A_ThisHotkey, "^") ? "u" : "g") "{Enter}"                   ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise                 
    sleep, short
    DllCall("SetCursorPos", int, StartX, int, StartY) 
    ; MouseMove StartX, StartY
    Return
  }
 
  ToggleInvisible() {
    KeyWait()
    Send {alt down}{alt up}v
    sleep, 600
    Send {h 2}
    return
  }
 
  SortByDate(optn="modified") {
    switch optn 
    {
        case "modified" :
            Send {Ctrl Down}{NumpadAdd}{Ctrl up}
            Send !vo{Down}{enter}
        case "created" :
            Send {Ctrl Down}{NumpadAdd}{Ctrl up}
            Send !vo{Down 4}{enter}
        default:
            return
    }
    return
  }
 
  DetailedView() {
    
    Send {ctrl down}{shift down}6{ctrl up}{shift up}
    Send ^{NumpadAdd}
    return
  }
  
  CF(path, sys_dependent = False) {                                             
    ChangeFolder(path, sys_dependent)
  }

  ChangeFolder(path, sys_dependent = False) {
    ; this function instantiates a hotkey for changing the current folder
    ; in file explorer or windows "save as" type dialogue boxes
    global uprofile

    if InStr(path, "_path")                                                ; "_path" string match indicates a config.ini path reference                                         
        path := GC(path)

    SplitPath, path, oFileName, oDir, oExtension, oNameNoExt, oDrive

    if (sys_dependent = TRUE) {
        path := GC(path, "")
    } else if oExtension {
        EF(path)
        return
    } if !oExtension {
        try {
            if  WinActive("ahk_exe explorer.exe")
            and WinActive("ahk_class CabinetWClass")
            {
                NavRun(path)
            }
            else                                                                ; WinActive("ahk_class #32770") = class for "save" dialogue boxes                                                             
            {
                changeDialDir(path)
            }
        }
    }
    return
  }
 
  changeDialDir(path) {
    ; change directory of "save as" dialogue box                                ; https://www.reddit.com/r/AutoHotkey/comments/ce8mu3/changing_folders_in_save_as_dialogue_with_com/                       
    WinGet, hWnd, ID, A                                                         ; Get handle of active window
    Send ^l
    winget, Pname, ProcessName, A 
    ; app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
    switch Pname {
        case "excel.exe" : edit := "Edit3" 
        default:           edit := "Edit2"
    }
    ControlSetText, %edit%, %path%, ahk_id %hWnd%
    ControlSend, %edit%, {Enter}, ahk_id %hWnd%
    ; ControlSetText, Edit2, %path%, ahk_id %hWnd%
    ; ControlSend, Edit2, {Enter}, ahk_id %hWnd%
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
    ; change file explorer current folder path                                  ; https://AutoHotkey.com/board/topic/102127-navigating-explorer-directories/
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
  
  AA(app_path = "", arguments = "", optn = False, start_folder_toggle = False) {
    W("lw")
    ActivateApp(app_path,arguments,optn,start_folder_toggle)
  }

  ActivateApp(app_path = "", arguments = "", optn = False, start_folder_toggle = False) {
    ; wrapper for ActivateOrOpen to process ini file path references
    ; and arguments
    global config_path
    if InStr(app_path , "_path")                                                ; "_path" string match indicates a config.ini path reference                                         
    {
        ini_app_path := GC(app_path)
        RegExMatch(ini_app_path, "[^\\]+$", exe_name)                           ; file_name = everyting after the last \ 
        ActivateOrOpen(exe_name, ini_app_path, arguments)
    }
    else if app_path in cmd.exe,explorer.exe
    {
        if InStr(arguments , "_path") {
            IniRead, arguments, %config_path%, %A_ComputerName%, %arguments%
        }
        ActivateOrOpen(app_path,,arguments, start_folder_toggle)                ; only compatible options are file explorer or command window 
    }
    else if (optn == 1)
    {
        SetTitleMatchMode, 2                                                    ; match anywhere in title
        IfWinExist, %app_path%
            WinActivate, %app_path%
        sleep med
        CursorFollowWin()
        return
    }
    else if (optn == 2)
    {
        SetTitleMatchMode, 2                                                    ; match anywhere in title
        If WinExist("ahk_exe " arguments) {
            WinActivate
        } else {
            Run, %app_path%
        }
        sleep med
        CursorFollowWin()
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
    
    WinGet, wList, List, %grp_ID%,,% ((grp_ID = "ahk_exe chrome.exe") ? "Tabs Outliner" : "")        ; exclude tabs outliner tab management window if app is chrome

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
    global config_path, PF_x86
    RegExMatch(file_path, "[^\\]+$", file_name)                                 ; file_name = everyting after the last \
    file_name := rtrim(file_name,"""")
    RegExMatch(file_name, "[^.]+$", ext)                                        ; ext = everything after the last .
    formatted_path = "%file_path%"

    try
    {
        if WinExist(file_name) 
        {
            WinActivate
        } 
        else if (SubStr(file_path, 1,4) = "http") 
        {
            LURL(formatted_path)
        }
        else if ext in docm,doc,docx,dotx,dotm
        {
            Run, % "winword.exe " . formatted_path
        }
        else if ext in xlsx,xlsm,xltx,xltm
        {
            Run, % "excel.exe " . formatted_path
        } 
        else if ext in ppt,pptx,pptm
        {
            Run, % "powerpnt.exe " . formatted_path
        } 
        else if ext in png,jpeg,gif,bmp
        {
            try RunAsUser(GC("hypersnap_path"), formatted_path, A_ScriptDir)
        }
        else if ext in mp4,webm,avi,mkv
        {
            RunAsUser(GC("vlc_path", PF_x86 "\Windows Media Player\wmplayer.exe"), formatted_path, A_ScriptDir)
        } 
        else if ext in pdf,xcesession
        {
            RunAsUser(GC("pdf_path"), formatted_path, A_ScriptDir)
        } 
        else 
        {
            RunAsUser(GC(app_path), formatted_path, A_ScriptDir)
        }
        return
    } catch e {
        MsgBox, %  "Can't open — unrecognized filetype " . e
    }
    return
  }

  EF(file_path = "master.ahk", app_path = "editor_path") {
    EditFile(file_path,app_path)
    return
  }
 
  OpenFolder(folder_path = "") {
    if WinActive("ahk_group FileListers") {
        CF(folder_path)
    } else {
        try 
            RunAsUser("explorer.exe", folder_path, A_ScriptDir)
        catch
            Run, % winpath "\explorer.exe " folder_path
    }
    return
  } 
  
  FileAppend(path="", newtext="") {
    FileAppend, `n%newtext%, %path%
    return
  }
 
  FilePrepend(filename, atext) {
    FileRead fileContent, % filename
    FileDelete % filename
    FileAppend % atext . "`n" . filecontent, % filename
  }
 
; YOUTUBE-DL (Python Script Wrapper) ___________________________________________
  
  URLvidDL(path="") {
    global short, med
    sleep, med
    keywait()
    BlockInput, on
    settimer, BlockInputTimeOut,-1000
    Send !d
    url := clip()
    sleep med
    if (SubStr(url, 1,4) = "http") {
        ; code := "youtube-dl " """" url """" 
        ; code := "youtube-dl --no-check-certificate " """" url """"
        code := "yt-dlp --no-check-certificate " """" url """"
        Run cmd /K "cd /d " %path% 
        sleep med
        clip(code)
        Send {enter}
        sleep short
        WinMinimize,A
    } else 
        PU("invalid url: " clipboard,,,,,-1000)
    BlockInput, Off
    return
  }
  
  ClickVidDL(path=""){

    global short, med, CB_hwnd
    sleep, med
    keywait()
    BlockInput, on
    settimer, BlockInputTimeOut,-1500
    Click, Right
    sleep, med * 2
    winget, Pname, ProcessName, A 
    app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
    switch app {
        case "msedge.exe" : Send % "{down " GC("click_DL", 4) "}{enter}"
        case "chrome.exe" : Send e
        case "vivaldi.exe": Send e
        default:            Send e
    }
    sleep med 
    if !InStr(FileExist(path), "D") {
        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
        MsgBox,4100,Create Hotstring,%msg% 
        IfMsgBox Yes
            FileCreateDir, %path%
        return
    }
    if (SubStr(clipboard, 1,4) = "http") {
        ; code := "youtube-dl --no-check-certificate " """" clipboard """" 
        code := "yt-dlp --no-check-certificate " """" clipboard """" 
        ; code := "youtube-dl " """" clipboard """" 
        Run cmd /K "cd /d " %path% 
        sleep med * 2
        clip(code)
        Send {enter}
        sleep short
        WinMinimize,A
    } else 
        PU("invalid url: " clipboard,,,,,-800)
    BlockInput, Off
    return

  }

  ClickVidDL_old(path=""){
    global short, med, CB_hwnd
    keywait()
    BlockInput, on
    settimer, BlockInputTimeOut,-1500
    Click, Right
    sleep, med * 2
    winget, Pname, ProcessName, A 
    app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
    switch app {
        case "msedge.exe" : Send % "{down " GC("click_DL", 4) "}{enter}"
        case "chrome.exe" : Send e
        case "vivaldi.exe": Send e
        default:            Send e
    }
    sleep med 
    if !InStr(FileExist(path), "D") {
        msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
        MsgBox,4100,Create Hotstring,%msg% 
        IfMsgBox Yes
            FileCreateDir, %path%
        return
    }
    if (SubStr(clipboard, 1,4) = "http") {
        code := "youtube-dl --no-check-certificate " """" clipboard """" 
        ; code := "youtube-dl " """" clipboard """" 
        Run cmd /K "cd /d " %path% 
        sleep med * 2
        clip(code)
        Send {enter}
        sleep short
        WinMinimize,A
    } else 
        PU("invalid url: " clipboard,,,,,-800)
    BlockInput, Off
    return

  }

  ClickDL(path=""){
    global short, med, CB_hwnd
    keywait()
    wintitleOfActiveWindow:="ahk_id " WinActive("A")
    BlockInput, on
    settimer, BlockInputTimeOut,-1500
    Click, Right
    sleep, med * 2
    app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
    Send % "{down " GC("click_DL", 4) "}{enter}"
    sleep, long

    if (SubStr(clipboard, 1,4) = "http") {
        code := "youtube-dl " """" clipboard """" 
        Run cmd /K "cd /d " %path% 
        sleep med * 2
        clip(code)
    } else 
        PU("invalid url: " clipboard,,,,,-800)
    BlockInput, Off
    return

  }
    

; MOUSE FUNCTIONS ______________________________________________________________
 
  SaveMousPos(key = "A", n = "0") {
    global config_path
    ; CoordMode, Mouse, Screen
    CoordMode, Mouse, window
    ; CoordMode, Mouse, client
    loop % n
        click
    MouseGetPos, StartX, StartY
    vde := getCurrentDesktop()                                                  ; virtual desktop environment 
    IniWrite,%StartX% %StartY%, %config_path%, %A_ComputerName%, MPos_%vde%_%Key%
    PU("MPos_" vde "_" Key " saved")

    return
  }
  
  CursorRecall(key = "A", n = "1", lrm = "l", rtn_mouse = False, H=False, msg = 0) {
    global config_path, short
    CoordMode, Mouse, window
    ; CoordMode, Mouse, client
    vde := getCurrentDesktop()
    if (GC("MPos_" vde "_" Key) != "ERROR") {
        KeyWait()
        MouseGetPos, StartX, StartY
        vde := getCurrentDesktop()
        IniRead, mpos, %config_path%, %A_ComputerName%, MPos_%vde%_%Key%
        ; GC("MPos_" vde "_" Key) 
        pos_array := StrSplit(mpos, " ")
        ; DllCall("SetCursorPos", int, pos_array[1], int, pos_array[2]) 
        if (H) {
            pos_array[2] := StartY
        }
        MouseMove, pos_array[1], pos_array[2]
        sleep, short
        Clicks(n, lrm)
        msg ? pu("click recall") : ""
        if rtn_mouse
            MouseMove, StartX, StartY
        return
    } else {
        Click
    }
    return
  } ; clicks a previously mouse cursor position saved via SaveMousPos() 
 
  KW(k="") {
    keywait(k)
    ; switch k
    ; {
    ;     default:
    ; }
    return
  }


  W(keys*) {
    loop % keys.MaxIndex()  
    {
        switch keys[A_index]
        {
            case "alt","a":
                KeyWait, alt
            case "lalt","la":
                KeyWait, lalt
            case "ralt","ra":
                KeyWait, ralt
            case "ctrl","c":
                KeyWait, ctrl
            case "capslock","cl":
                KeyWait, capslock
            case "lctrl","lc":
                KeyWait, lctrl
            case "rctrl","rc":
                KeyWait, rctrl
            case "shift","s":
                KeyWait, shift
            case "lshift","ls":
                KeyWait, lshift
            case "rshift","rs":
                KeyWait, rshift
            case "lwin","lw":
                KeyWait, lwin
            case "printscreen","ps","p":
                KeyWait, printscreen
            default:
                msgbox % "not recognized"
        }
    }
    return
  }

  keyWait(k = "") {
    switch k
    {
        case "alt","a":
            KWalt:
            KeyWait, alt
            return
        case "ctrl","c":
            KWctrl:
            KeyWait, ctrl
            return
        case "shift","s":
            KWshift:
            KeyWait, shift
            return
        case "lwin","w":
            KWwin:
            KeyWait, lwin
            return
        case "printscreen","ps":
            KWps:
            KeyWait, printscreen
            return

        case default:
            gosub, KWalt 
            gosub, KWctrl 
            gosub, KWshift
            gosub, KWwin 
            gosub, KWps
            return
    }
    return
  }

  /*
    keyWait(k = "") {
        switch k
        {
            case "alt","a":
                KWalt:
                if (instr(A_ThisHotKey,"alt") or instr(A_ThisHotKey,"!") or instr(A_ThisHotKey,"lalt") or instr(A_ThisHotKey,"ralt")) 
                    KeyWait, alt
                return
            case "ctrl","c":
                KWctrl:
                if (instr(A_ThisHotKey,"ctrl") or instr(A_ThisHotKey,"^") or instr(A_ThisHotKey,"lctrl") or instr(A_ThisHotKey,"rctrl")) 
                    KeyWait, ctrl
                return
            case "shift","s":
                KWshift:
                if (instr(A_ThisHotKey,"shift") or instr(A_ThisHotKey,"+") or instr(A_ThisHotKey,"lshift") or instr(A_ThisHotKey,"rshift")) 
                    KeyWait, shift
                return
            case "lwin","w":
                KWwin:
                if (instr(A_ThisHotKey,"#") or instr(A_ThisHotKey,"lwin") or instr(A_ThisHotKey,"win")) 
                    KeyWait, lwin
                return
            case default:
                msgbox % A_ThisHotkey
                gosub, KWalt 
                gosub, KWctrl 
                gosub, KWshift
                gosub, KWwin 
                return
        }
        return
    }
  */

  CFW(Q = "center", offset_x = "100", offset_y = "100") {
    CursorFollowWin(Q, offset_x, offset_y) 
    return
  }      

  CursorFollowWin(Q = "center", offset_x = "100", offset_y = "100") {
    global config_path, short, med
    sleep, short
    if GC("T_CF",0)
        CursorJump(Q, offset_x, offset_y)
    return
  }
 
  Clicks(num = 2, lrm = "left") {
    ; temporarily blocks mouse movement for more consistent doubleclick to select word
    ;ReleaseModifiers()
    global short
    sleep, med
    BlockInput, On
    settimer, BlockInputTimeOut,-600
    Send {click %num% %lrm%}
    ; click, %num% %lrm%
    BlockInput, off
    return
  }
 
  CursorJump(Q = "center", offset_x = 0, offset_y = 0, ScreenDim = 0) {
    ; move mouse cursor to the middle of active window
    global short
    Sleep, short 
    BlockInput, Mousemove
    settimer, BlockInputTimeOut,-600
    CoordMode, Mouse, window
    ; CoordMode, Mouse, screen                                                    ; defines coordinates relative to active screen for multimonitor support
    if ScreenDim {
        winTopL_x := 0, winTopL_y := 0, width := A_ScreenWidth, height := A_ScreenHeight
    } else {
        WinGetPos, winTopL_x, winTopL_y, width, height, A
    }
    switch Q
    {
        case "T":                                                               ;top
            MouseGetPos, x 
            y := 0
        case "B":                                                               ;bottom
            MouseGetPos, x
            y := height
        case "L":                                                               ;left
            x := 0
            ; x := winTopL_x
            MouseGetPos,,y
        case "R":                                                               ;right
            x := width
            MouseGetPos,,y
        case "TL":
            x := 0
            y := 0
        case "TR":
            x := width
            y := 0
        case "BL":
            x := 0
            y := height
        case "BR":
            x := width
            y := height
        default:                                                                ; center
            x := width  * .5
            y := height * .5
    }
    ; DllCall("SetCursorPos", int, x + offset_x, int, y + offset_y) 
    MouseMove, x + offset_x, y + offset_y
    BlockInput, MousemoveOff
    return
  }

; BROWSERS _____________________________________________________________________
 
  LURL(URL, i = false, browser = "") {
    ; Browser path used to load urls dependent on computer
    global config_path, PF_x86, short
    ; ReleaseModifiers()
    sleep, short
    if browser
        Pname := browser
    Else
        winget, Pname, ProcessName, A 

    Switch Pname
    {
        case "vivaldi.exe": output := GC("vivaldi_path", GC("html_path")) 
        case "chrome.exe" : output := GC("chrome_path", GC("html_path")) . (i ? " -incognito " : "")
        case "msedge.exe" : output := GC("edge_path", GC("html_path")) . (i ? " -inprivate " : "")
        ; case "firefox.exe": output := GC("firefox_path", GC("html_path"))     ; look into firefox url syntax
        default: output := GC("html_path")
    }
    output := (output = "ERROR") ? GC("html_path") : output
    sleep 200
    Run, %output% "%URL%"
    return
  } ; load URL in web browser

  Search(prefix = "google.com/search?q=", var = "", suffix = "") {
    global short, med
    ; ReleaseModifiers()
    sleep, short
    var := (!var ? clip() : var)
    url := prefix . var . suffix
    sleep, med
    LURL(url)
    CursorFollowWin()
    return
  }
 
  OpenGoogleDrive(num) {
    ; Function for opening different google drive folders
    global config_path
    LURL("-incognito https://drive.google.com/drive/my-drive")                  ; icognito to avoid signing out of google account              
    MsgBox,4100, Accessing Google Drive, Enter login/pwd after page loads?
    IfMsgBox Yes
    {
        IniRead, output, %config_path%, PASSWORDS, gd%num%_login
        clip(output)
        Send {enter}
        sleep 2000
        SelectLine()
        IniRead, output, %config_path%, PASSWORDS, gd%num%_pwd
        clip(output)
        Send {enter}
        return
    }
    else
        return
  }

  tabsOutliner(){                                                               ; Tabs Outliner and pinned webpages
     SetTitleMatchMode, 2
     If WinExist("Tabs Outliner") {                                               
         WinActivate
     } else {
         AA("chrome_path")
         sleep 100
         Send ^.                                                                ; chrome shortcut to activate tabsoutliner
     }
     CFW()
     return
  }  ; activate Tabs Outliner 


; OFFICE _______________________________________________________________________
 
  SendEmail() {
    global email := "", subject := "", body := ""
    Gui, New, ,%title%
    Gui, Add, text, xs yp, To:
    Gui, Add, Edit, W300 vemail,
    Gui, Add, text, xs yp+30, Subject:
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
 
  RunExcelVBA(MacroName) { ; for AHK_L
    Try {
        ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN
        oExcel := Acc_ObjectFromWindow(hwnd, -16).Application
        try 
            oExcel.Run(MacroName) 
        catch
            try oExcel.Run("PERSONAL.XLSB!" MacroName)
        return 
    } catch e {
        MsgBox, something went wrong, check if you can execute macros within the workbook
        return
    }
  }

  HexToDec(Hex) {
      if (InStr(Hex, "0x") != 1)
          Hex := "0x" Hex
      return, Hex + 0
  }

  highlight_cell(C := 0) { ;http://www.databison.com/excel-color-palette-and-color-index-change-using-vba/
    Try {
        
        ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN
        oExcel := Acc_ObjectFromWindow(hwnd, -16).Application
        if (strlen(C) = 2) {
            if (C = oExcel.Selection.Interior.ColorIndex) 
                oExcel.Selection.Interior.ColorIndex := 0
            else 
                oExcel.Selection.Interior.ColorIndex := C
        } else {
            
            RegExMatch(oExcel.Selection.Interior.Color, ".[0-9]+", current_value)
            if (current_value = HexToDec(C)) 
                oExcel.Selection.Interior.Pattern := 0
            else 
                oExcel.Selection.Interior.Color := "&h" . C

        }



        return
    } catch e {
        ; MsgBox, something went wrong, check if you can execute macros within the workbook
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

  RunVBA(MacroName) {
    winget, Pname, ProcessName, A 
    ; https://www.autohotkey.com/boards/viewtopic.php?t=71148 another option to try if this method breaks
    try 
    {
        switch Pname 
        {
            case "excel.exe"   : ControlGet , Hwnd , hwnd ,, Excel71   , ahk_exe excel.exe
            case "winword.exe" : ControlGet , Hwnd , hwnd ,, _WwG1     , ahk_exe winword.exe
            case "powerpnt.exe": ControlGet , Hwnd , hwnd ,, mdiClass1 , ahk_exe powerpnt.exe
            default:            
        }
        oApp := Acc_ObjectFromWindow(Hwnd, -16).Application
        if (Pname = "excel.exe") {
            try 
                oApp.Run("PERSONAL.XLSB!" MacroName)
            catch 
                oApp.Run(MacroName)
        } else {
            oApp.Run(MacroName)
        }
    } catch {
        return
       ; MsgBox, something went wrong, check if you have permission to run macros 
    }
  }

  RunMSWordMacro(MacroName) { ; for AHK_L
    ; Retrieves a running object that has been registered with OLE.
    ; an inter-process communication mechanism. 
    ; Based on a subset of Component Object Model (COM) that 
    ; was intended for use by scripting languages
    try {
        ControlGet, Hwnd, Hwnd,, _WwG1, ahk_exe winword.exe
        oWord := Acc_ObjectFromWindow(hwnd, -16).Application                    ;https://autohotkey.com/board/topic/77303-acc-library-ahk-l-updated-09272012/  
        oWord.Run(MacroName)
    } catch e {
        MsgBox, something went wrong, check if you have permission to run macros 
        return
    }
    return
  }
 
  ToggleThesaurus(){ 
    t := !t
    if (t = true)
        Send +{F7}                                                              
    else
        RunMSWordMacro("thesaurus_close")   
    return
  }

  command(tgt, opt = "") {

    Send ^p
    clip(tgt)
    Send {Enter}%opt%
    return
  } ; run obsidian command corresponding to tgt string

  ObsidianQuickAdd(file_anchor, action = "open") {
    global short, med, long
    sleep, short
    keyWait()
    
    tgt_wID := WinExist()

    f_path := A_ScriptDir . "\mem_cache\qa.txt"
    ; ReleaseModifiers()
    ObsidianPath := GC("obsidian_path",UProfile "\AppData\Local\Obsidian\Obsidian.exe")  
    switch action 
    {
        case "file":
            OpenInObsidian("crypto")
        case "open":
            AA(ObsidianPath)
            Send %file_anchor%
        case "menu":
            If (strlen(clip()) > 0) {
                WriteToCache("qa")
            } else {
                FileDelete, %f_path%
            }

            sleep, long * 2
            ActivateWin("ahk_id " tgt_wID)
            sleep, med
            If WinActive("ahk_group browsers") {
                clipboard := "" 
                Sendinput !y
                sleep, long * 1.2
                while pos := RegExMatch(clipboard, "://\K([^/:\s]+)", m, A_Index=1?1:pos+StrLen(m))
                url := " | [" m1 "](" clipboard ")"
                FileAppend, %url%, %f_path%
            }
            
            AA(ObsidianPath)
            sleep, long * 1.2
            Sendinput %file_anchor%

            Input, UserInput, V, {enter}{esc} 
            if (ErrorLevel = "Timeout")
            {
                s("{esc}!{tab}")
                return
            }
            else If InStr(ErrorLevel, "Enter")
            {
                MsgBox,4100, Obsidian QuickAdd, add text?
                IfMsgBox Yes 
                {
                    sleep, short
                    AccessCache("qa")
                    sleep, short
                    Send ^{enter}
                    Sendinput !{tab}
                } else {
                    s("{esc}!{tab}")
                }
                return
            }
            else If InStr(ErrorLevel, "Esc")
            {
                s("{esc}!{tab}")
            }
            return

        case "url":
            ; Send !d
            ; url := clip()
            Send {esc}
            Send yy
            sleep med
            AA(ObsidianPath)
            sleep long
            Send %file_anchor%
            
            MsgBox,4100, Obsidian QuickAdd URL, Paste URL: "%clipboard%"  
            IfMsgBox Yes 
            {
                Send ^v
                Send ^{enter}
                Send !{tab}
            } else {
                s("{esc}!{tab}")
            }
                return
        case "text":
            st := clip()
            AA(ObsidianPath)
            sleep med
            Send %file_anchor%
            MsgBox,4100, Obsidian QuickAdd text, Paste text: "%clipboard%"
            IfMsgBox Yes
            {
                clip(st)
                Send ^{enter}
                Send !{tab}
            } else {
                s("{esc}!{tab}")
            }
            return
        default:
            return
    }
    return
  }   

  OpenInObsidian(FileName, ObsidianPath = "") { 
    
    ObsidianPath := !ObsidianPath 
                  ? (UProfile "\AppData\Local\Obsidian\Obsidian.exe")
                  : ObsidianPath
    AA(ObsidianPath)                                                            ; AA(UProfile "\AppData\Local\Obsidian\Obsidian.exe") 
    Send ^o                                                                     ; hotkey Ctrl+O set in Obsidian to open "QuickSwitcher"
    Sleep 100                                                                   ; maybe not needed
    clip(FileName)                                                              ; type in content of variable
    Sleep 100                                                                   ; maybe not needed
    Send {Enter}                                                                ; Ctrl+Enter opens in new pane. {Enter} would open in current pane
  } ; OpenInObsidian(FileName) ; opens specified note in Obsidian by simulating keystrokes into "QuickSwitcher"      


; VS CODE ______________________________________________________________________

  gotoLine(){
    BlockInput, on
    settimer, BlockInputTimeOut,-1000
    selectword()
    sleep 200
    var := trim(clip(), " `;")
    sleep 200
    s("^g"), clip(var), s("enter")
    BlockInput, Off
    return 
  } ; select number and go to that position in file  

  FocusResults() {
    sleep 300
    Send +!^m                                                                   ; shortcut in vscode for toggling "tab moves focus"
    sleep 200
    Send {shift down}{tab 7}{shift up}
    sleep 200
    Send +!^m
    return
  }

  commentSelected(pfx = "/*`r", sfx = "`r*/") {
    Send {tab}
    Clip(pfx clip() sfx)
    return
  }       

; TEXT MANIPULATION ____________________________________________________________
  
  sortArray(arr,options="") {   
    ; specify only "Flip" in the options to reverse otherwise unordered array items
    ; https://autohotkey.com/board/topic/93570-sortarray/

    if  !IsObject(arr)
        return  0
    new :=  []
    if  (options="Flip") {
        While   (i :=   arr.MaxIndex()-A_Index+1)
            new.Insert(arr[i])
        return  new
    }
    For each, item in arr
        list .= item "`n"
    list := Trim(list,"`n")
    Sort, list, %options%
    Loop, parse, list, `n, `r
        new.Insert(A_LoopField)
    return  new

  }

  HasVal(haystack, needle) {
    if !(IsObject(haystack)) || (haystack.Length() = 0)
        return 0
    for index, value in haystack
        if (value = needle)
            return index
    return 0
  }

  JEE_InStrEx(vText, vNeedle, vCaseSen=0, vPos=1, vOcc=1) {
    ;https://www.autohotkey.com/boards/viewtopic.php?style=7&t=34207
    ;same as InStr with some slight differences:
    ;- vPos specifies the start position, but not the search direction
    ;e.g. vPos := 3 means search from 3rd char (forwards/backwards depending on vOcc)
    ;e.g. vPos := -3 means search from 3rd-to-last char (forwards/backwards depending on vOcc)
    ;- AHK v2 style is used, so: -1 means last char, -2 means 2nd-to-last char
    ;- vOcc specificies the occurrence, and the search direction
    ;use positive vOcc to search forwards, use negative vOcc to search backwards
    ;e.g. vOcc := 3 means 3rd occurrence at/after position (search forwards)
    ;e.g. vOcc := -3 means 3rd occurrence at/before position (search backwards)

    if (vPos = 0) || (vOcc = 0)
        return ""
    vIsV1 := !!SubStr(1,0)
    if (vOcc < 0) && (vPos > 0)
        vPos := - StrLen(vText) - !vIsV1 + vPos
    else if (vOcc > 0) && (vPos < 0)
        vPos := StrLen(vText) + vIsV1 + vPos
    else if (vOcc < 0) && (vPos < 0)
        vPos += vIsV1
    return InStr(vText, vNeedle, vCaseSen, vPos, Abs(vOcc))
  }

  JEE_SubStrRange(vText, vPos1, vPos2="") {
    ;specify first and last chars of text to retrieve
    if (vPos2 = "")
        return SubStr(vText, vPos1)
    else
        return SubStr(vText, vPos1, vPos2-vPos1+1)
  }

  delLine() {
    SendInput {End}{ShiftDown}{Home 2}{Left}{ShiftUp}{Delete}{Right}            ; Delete current line of text
  }

  PasteClipboardAtMouseCursor() {
    Clicks(2)
    var := Clipboard
    var := trim(var, "`r`n`t")
    Clipboard := var
    sleep, short
    Send ^v
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
    ; Function to Join strings python style                                     ; https://www.AutoHotkey.com/boards/viewtopic.php?t=7124
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
    If !var                                                                     ; selects text to the left of cursor (if no text selected)
    {    
        Send +{home}
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
    Send {del}
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
    Send ^v
    return
  }
 
  RemoveBlankLines(reselect=False, input="") {
    ; Removes blank lines within a block of selected text
    BlockInput, on
    settimer, BlockInputTimeOut,-600
    var := input ? input : clip()
    if !ErrorLevel
    {
        var := RegExReplace(var, "^(`r`n)+")
        var := RegExReplace(var, "m)^ +$")
        var := RegExReplace(var, "\R+\R", "`r`n")
    }
    if !input
        clip(var)
    else 
        return % var

    BlockInput, Off
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
    ;ReleaseModifiers()
    ; BlockInput, on
    settimer, BlockInputTimeOut,-600
    var := !var ? clip() : var
    StringReplace, var, var, `r`n, `n, All
    StringUpper, var, var
    if !paste
        return %var%
    clip(var, True)
    ; BlockInput, Off
    return
  }
 
  ConvertLower(var = "", paste = True) {
    ; Convert selected text to lowercase
    ;ReleaseModifiers()
    ; BlockInput, on
    ; settimer, BlockInputTimeOut,-600
    var := !var ? clip() : var
    StringReplace, var, var, `r`n, `n, All
    StringLower, var, var
    if !paste
        return %var%
    clip(var, True)
    ; BlockInput, Off
    return
  }
 
  EveryCapitalize1stLetter(var = "", paste = True, other_letters_lowercase = True) {
    ; Every first letter of selected text is capitalized
    ; BlockInput, on
    ; settimer, BlockInputTimeOut,-600
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
    ; BlockInput, Off
    return
  }
 
  Capitalize1stLetter(var = "", paste = True, firstWord = True, LowerCaseOthers = True) {
    ; Capitalize just first letter of selected text
    ;ReleaseModifiers()
    ; BlockInput, on
    settimer, BlockInputTimeOut,-600
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
    ; BlockInput, Off
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
 
  FillChar(length = "80", char = " ", selected = True, out = false, buffer = 0) {
    ; Function to create borders and blank spaces of fixed length 
    try {
        ; BlockInput, on
        ; settimer, BlockInputTimeOut,-600
        var := (selected) ? rtrim(clip()) : ""
        num_char    := (StrLen(char) < length) 
                     ? (length - StrLen(var))/StrLen(char) 
                     : StrLen(char)
        string_char := RepeatString(char, num_char - buffer)                    ; -1 to account for 1 space after the heading string
        output      := var . ((buffer) ? A_space : "") . string_char
        output      := substr(output, 1, length)
        sleep 200
        if out
            return % output
        else
            clip(output)
        ; BlockInput, Off
    }
    return
  }

  AddSpaceBeforeComment(length = "80", char = " ", lines = 1) {
    global short,med,long 
    ; BlockInput, on
    ; settimer, BlockInputTimeOut,-600
    
    Send {space}{left}+{end}                                                    ; fixes issue in vscode where ^x on empty selection will cut the whole line                                                   
    end_txt := Trim(clip())
    Send {del}
    sleep, short
    
    Send {home}+{end} 
    h1 := rtrim(clip())
    sleep, short
    
    Send {left}+{home}
    h2 := clip()
    l2 := strlen(h2), l1 := strlen(h1)
    if (substr(h2,1,1) = A_space) {                                             ;  run if there's space(s) before the first character in a line       
        Sendinput % "{right "  (strlen(h1) + 1) "}"  
        space_btn := RepeatString(A_space, length - (l1 + l2))
        sleep, med*2
        clip(space_btn end_txt)
    } else {
        Sendinput % "{right "  (strlen(h1)) "}"                                 ; move cursor to end of first group of text   
        space_btn := RepeatString(A_space, length - l1)
        sleep, med*2
        clip(space_btn end_txt)
    }
    Sendinput % "{left "  (strlen(end_txt)) "}"
    ; BlockInput, off
    sleep short
    return      
  }
 
  AddBorder(length = "80", char = "_", prefix = "" )  {
    ; Add line border to separate code sections
    Send {home}
    Sendraw %prefix%
    if (prefix != "")
        Send {space}
    Send {home}
    Send {home}{shift down}{end}{shift up}
    FillChar(length, char,,,1)
    return
  }
 
  TrimText(cut = False, input = "", rtrim = false ) {
    ; cut/copy and trim selected text
    if !input {
        if !cut 
            Send ^c
        else 
            Send ^x
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

  PasteWithoutBreaks(NoParagraphs = False, input = "") {
    ; Format clipboard contents: remove double spaces and line breaks
    ; while keeping the empty lines between paragraphs
    var := (input) ? input : Clipboard
    global long
    var := RegExReplace(var, "(\S.*?)\R(.*?\S)", "$1 $2")           ; strip single line breaks + replace with single space
    var := NoParagraphs ? RegExReplace(var, "\R", A_space) : var    ; replace paragraph breaks with space
    var := RegExReplace(var, "S) +", A_Space)                       ; replace multiple spaces with single space
    var := RegExReplace(var, "(?<!<)-\s", "$1")                     ; <= remove "-" if not preceded by < ("<-")
    if !input {
        sleep, long * 0.8
        clipboard := var
        Send ^v                                                     ;    for stitching words back together if split by
    } 
    /*
    ; var := RegExReplace(var, "^(`r`n)+")
    ; var := RegExReplace(var, "(`r`n){2,}", "`r`n")
    ; var := RegExReplace(var, "(`r`n)+$")
    var := RegExReplace(var, "m)(*ANYCRLF)")
    ; var := RegExReplace(var, "m)^`t+")
    ; var := RegExReplace(var, "`t{2,}", "`t")
    ; var := RegExReplace(var, "m)`t+$")
    ; sleep, long * 0.8
    */
    return % var
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
    BlockInput, on
    settimer, BlockInputTimeOut,-600
    var := clip()
    clip(RepeatString(" ", strlen(var)))
    BlockInput, Off
    return
  }
 
  PasteOverwrite() {
    BlockInput, on
    global short
    settimer, BlockInputTimeOut,-600
    char_count := strlen(clipboard)
    Send ^v
    sleep short
    ; Sendevent {del %char_count%}
    Sendinput {del %char_count%}
    BlockInput, Off
    return
  }
  
  RAwB(A = "", B = "", var = "", paste = True, select = True, regex = false) {
    return ReplaceAwithB(A,B,var,paste,select,regex)    
  }
  ReplaceAwithB(A = "", B = "", var = "", paste = True, select = True, regex = false) {
    ; ReleaseModifiers()
    global short
    sleep, short
    BlockInput, on
    settimer, BlockInputTimeOut,-600
    var := (!var ? clip() : var)
    var := RegExReplace(var, "S) +", A_Space)
    if regex
        var := RegExReplace(var, A, B)
    else 
        var := StrReplace(var, A, B)
    if !paste
        return %var%
    clip(var, select)
    BlockInput, Off
    return
  }
 
  removeHtmlTags() {
    ; remove html tags from selected text
    BlockInput, on
    settimer, BlockInputTimeOut,-600
    cl := clip()
    LR:=RegExReplace( cl, "<.*?>","`r`n" )
    stringreplace,lr,lr,|`r`n,,all
    Loop                                                                        ; remove empty lines
    {
        StringReplace,lr,lr, `r`n`r`n, , UseErrorLevel
        if ErrorLevel = 0
            break
    }
    clip(lr)
    BlockInput, Off
    return
  } 
 
; EXPERIMENTAL _________________________________________________________________
 ; SWITCH APP INSTANCES WITH THUMBNAILS PREVIEW -- -- -- -- -- -- -- -- -- -- 
     
   ChgInstance(switch = "capslock") {
     global tabkey := switch
     gosub, chgInstance~win
     return
   }
 
   return ; END OF AUTOEXECUTION ... ... ... ... ... ... ... ... ... ... ... ...
 
   ChgInstance~win:                                                              ; https://superuser.com/questions/435602/shortcut-in-windows-7-to-switch-between-same-applications-windows-like-cmd
 
   WS_EX_TOOLWINDOW = 0x80
   WS_EX_APPWINDOW = 0x40000
   tw := []
   aw := []
 
   WinGet, processName, ProcessName, A
 
   DetectHiddenWindows, Off
   AltTab_window_list(1)
 
   Loop, %AltTab_ID_List_0%
   {
      wid := AltTab_ID_List_%A_Index%
      WinGet, processName2, ProcessName, ahk_id %wid%
      
      if (processName2 != processName)
      {
         WinGet, exStyle2, ExStyle, ahk_id %wid%
 
         if (!(exStyle2 & WS_EX_TOOLWINDOW))
         {
            tw.InsertAt(0, wid)
            WinSet, ExStyle, ^0x80, ahk_id %wid%
         }
 
         if ((exStyle2 & WS_EX_APPWINDOW))
         {
            aw.InsertAt(0, wid)
            WinSet, ExStyle, ^0x40000, ahk_id %wid%
         }
      }
   }
 
   Send {Alt Down}{Tab} ; Bring up switcher immediately
 
   ; KeyWait, sc029, T.25  ; Go to next window; wait .25s before looping         
   ; KeyWait, ``, T.25  ; Go to next window; wait .25s before looping
   KeyWait, %tabkey%, T.25  ; Go to next window; wait .25s before looping
   if (Errorlevel == 0)
   {
        While ( GetKeyState( "alt","P" ) )
        {
        ;   KeyWait, ``, D T.25
            ; KeyWait, sc029, D T.25
            KeyWait,%tabkey%, D T.25                                                ; Go to next window; wait .25s before looping
            if (Errorlevel == 0)
            {
                if (GetKeyState( "Shift","P" ))
                {
                Send {Alt Down}{Shift Down}{Tab}
                Sleep, 200
                }
                else
                {
                Send {Alt Down}{Tab}
                Sleep, 200
                }
            }
        }
    }
 
   Send {Alt Up}                                                                 ; Close switcher on hotkey release
 
   for index, wid in tw
   {
      WinSet, ExStyle, ^0x80, ahk_id %wid%
   }
 
   for index, wid in aw
   {
      WinSet, ExStyle, ^0x40000, ahk_id %wid%
   }
 
   return
 
     
   AltTab_window_list(excludeToolWindows)
   {
      global
      WS_EX_CONTROLPARENT =0x10000
      WS_EX_APPWINDOW =0x40000
      WS_EX_TOOLWINDOW =0x80
      WS_DISABLED =0x8000000
      WS_POPUP =0x80000000
      AltTab_ID_List_ =0
      WinGet, Window_List, List,,, Program Manager                               ; Gather a list of running programs
      id_list =
      Loop, %Window_List%
      {
         wid := Window_List%A_Index%
         winget, ProcName, ProcessName, ahk_id %wid%
 
         WinGetTitle, wid_Title, ahk_id %wid%
         WinGet, Style, Style, ahk_id %wid%
         If ((Style & WS_DISABLED) or !(wid_Title))                              ; skip unimportant windows
            Continue
         
         WinGet, es, ExStyle, ahk_id %wid%
         Parent := Decimal_to_Hex( DllCall( "GetParent", "uint", wid ) )
         WinGetClass, Win_Class, ahk_id %wid%
         WinGet, Style_parent, Style, ahk_id %Parent%
   
         If ((excludeToolWindows & (es & WS_EX_TOOLWINDOW))
            or ((es & ws_ex_controlparent) and ! (Style & WS_POPUP) and !(Win_Class ="#32770") and ! (es & WS_EX_APPWINDOW)) ; pspad child window excluded
            or ((Style & WS_POPUP) and (Parent) and ((Style_parent & WS_DISABLED) =0))) ; notepad find window excluded ; note - some windows result in blank value so must test for zero instead of using NOT operator!
            continue
 
         AltTab_ID_List_ ++
         AltTab_ID_List_%AltTab_ID_List_% :=wid
      }  
      
      AltTab_ID_List_0 := AltTab_ID_List_
    
   }
   
   Decimal_to_Hex(var)
   {
     SetFormat, integer, hex
     var += 0
     SetFormat, integer, d
     return var
   }
 
 ; COMMAND BOX ZOOM -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 ; too much of delay if wrapped in a function; gosub much faster 

  CBzoomOut:
    fsz := GC("CBfsz", "10")
    fsz -= 2
    fsz := (fsz < 5) ? 5 : (fsz > 20) ? 20 : fsz
    Gui, 2:font,% "c" GC("CBt_color") " s" fsz " w" GC("CBfwt", "500"), % GC("CBfnt", "Consolas")
    ; Gui, 2:Font, s%fsz%
    DllCall("EnumChildWindows", "Ptr", CB_hwnd, "Ptr", ChangeFont)
    CC("CBfsz", fsz)
    return

  CBzoomIn:
    fsz := GC("CBfsz", "10")
    fsz += 1
    fsz := (fsz < 5) ? 5 : (fsz > 20) ? 20 : fsz
    Gui, 2:font,% "c" GC("CBt_color") " s" fsz " w" GC("CBfwt", "500"), % GC("CBfnt", "Consolas")
    ; Gui, 2:Font, s%fsz%
    DllCall("EnumChildWindows", "Ptr", CB_hwnd, "Ptr", ChangeFont)
    CC("CBfsz", fsz)
    return

  ChangeFont(hwnd, l) {
    GuiControl Font, %hwnd%
    return true
  }


#IF