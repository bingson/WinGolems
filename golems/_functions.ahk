; GLOBAL VARIABLES _____________________________________________________________

    ;   CB_hwnd := ""
    ChangeFont := RegisterCallback("ChangeFont")
    short := 150, med := 300, long := 1000
    F   := { "mono1" : "Lucida Sans Typewriter"}

    C   := { "AliceBlue"    : "F0F8FF" , "LemonChiffon" : "FFFACD"
           , "Bgreen"       : "29524A" , "Lgreen"       : "CEDFBF"
           , "BGyellow"     : "FFFFE0" , "Linen"        : "FAF0E6"
           , "Black"        : "000000" , "Lorange"      : "FFDEAD"
           , "Blue"         : "0000FF" , "Lpurple"      : "CDC9D9"
           , "BurntUmber"   : "330000" , "Lsalmon"      : "ffc8b3"
           , "Buttercream"  : "EFE1CE" , "Lyellow"      : "FCE28A"
           , "EYellow"      : "FDFCA3" , "pdf"          : "ffcccb"
           , "Bwhite"       : "F6F7F1" , "Midnightblue" : "000033"
           , "Chrome"       : "E8F1D4" , "MintCream"    : "F5FFFA"
           , "Cornsilk"     : "FFF8DC" , "Navy"         : "000080"
           , "Cyan"         : "00FFFF" , "OldLace"      : "FDF5E6"
           , "Dblue"        : "093145" , "OldWhite"     : "FAEBD7"
           , "Dgreen"       : "013220" , "Onyx"         : "353839"
           , "Dgrey"        : "525252" , "Pbrown"       : "D4C4B5"
           , "Dpurple"      : "330033" , "Pink"         : "F6E1E0"
           , "Drkcherryred" : "330000" , "Purple"       : "800080"
           , "Dyellow"      : "ECC846" , "RawUmber"     : "333300"
           , "GhostWhite"   : "F8F8FF" , "Rblue"        : "165CAA"
           , "Green"        : "107A40" , "Red"          : "FF0000"
           , "KashmirGreen" : "003300" , "SeaGreen"     : "CFE2CF"
           , "Lblue"        : "BED7D6" , "Silver"       : "CCCCCC"
           , "Lbrown"       : "DFD0BF" , "Vlorange"     : "ffe4b3"
           , "Lcoral"       : "FFA07A" , "White"        : "FFFFFF"
           , "Ldaisy"       : "EFD469" , "WhiteSmoke"   : "F5F5F5"
           , "lgrey"        : "EDEDED" , "HLgreen"      : "BEF3B1"
           , "HLyellow"     : "FDFCA3" , "Dpurple"      : "D6C1D7"} ; www.color-name.com

    reChordMenuPattern := "i)^(\h*)?([=,\-\)\(\*A-Za-z0-9])\h+(\S+ ?)(\h*)?"           

    GroupAdd, FileListers, ahk_class CabinetWClass ; create reference group for file explorer and open + save dialogue boxes
    GroupAdd, FileListers, ahk_class WorkerW ; https://www.autohotkey.com/boards/viewtopic.php?t=28347
    GroupAdd, FileListers, ahk_class #32770, ShellView
    ;GroupAdd, FileListers, ahk_exe Explorer.EXE

    GroupAdd, browsers, ahk_exe vivaldi.exe
    GroupAdd, browsers, ahk_exe chrome.exe 
    GroupAdd, browsers, ahk_exe msedge.exe 
    GroupAdd, browsers, ahk_exe firefox.exe

    ChrCodes := {"!": Chr(33), """" : Chr(34),"$" : Chr(36) , "%" : Chr(37), "*" : Chr(42), "." : Chr(46),	"?" : Chr(63) , "@" : Chr(64) , "~" : Chr(126)}
; STARTUP ______________________________________________________________________
    
    KeePassStartup(title="ahk_exe KeePassXC.exe"){
        If IsWinInTray(title) OR WinExist(title)
            sleep, 0
        Else {
            ActivateApp("C:\Program Files\KeePassXC\KeePassXC.exe")
            sleep, 1000
            MsgBox,4100, Opening KeepassXC, Enter Master Password?
            IfMsgBox Yes 
            {
                ActivateApp("C:\Program Files\KeePassXC\KeePassXC.exe")
                sleep, 100
                clip(GC("master",,"PASSWORDS")),SI("{enter}")
                sleep, 300
                MinimizeWin("ahk_exe KeePassXC.exe")
            }
            Else    
                sleep 0
            
        }
    }

    CBstartup() {
        if GC("CB_persistent",0) { ;open command box if flag turned on
            global C
            winget, Pname, ProcessName, A

            switch Pname
            {
                case "Code.exe": sfx := "~code", clr := "CFE2CF"       ; RegExReplace(GC("editor_path"), "\\?([A-Za-z0-9\.]+)$","$1") 
                case "msedge.exe","chrome.exe": sfx := "~html", clr := "F6E1E0"
                case "Explorer.exe": sfx := "~fe", clr := "FCE28A"
                case "PDFXEdit.exe", "acrord32.exe": sfx := "~pdf", clr := "FFCCCB"
                default:
                    sfx := "~win",  clr := "F6F7F1"
            }
            sleep, 200
            CommandBox(sfx, clr)
            ActivateTgt()
        }
    }

; WINDOW MANAGEMENT ____________________________________________________________

    mw(Q){
        MoveWin(Q)
    }

    MoveWin(Q = "TL", xa=0,ya=5, ha=-50,wa=0) {

        global config_path, CB_hwnd
        static x, y, w, h
        WinRestore, A
        MI := StrSplit(GetMonInfo()," ") ;getmonitordimensions    
        x:=MI[1]+xa-wa 
        y:=MI[2]+ya-ha ;adjustments made to account for taskbar on top instead of taskbar on bottom 
        w:=MI[3]+wa
        h:=MI[4]+ha
        hw := w/2 , qw := w/4 
        hh := h/2 , qh := h/4 ;  1/4 = 0.25 ; 1//4 = 0 (truncates decimal)
        tw := w/3 , th := h/3
        ; hw:= w//2  , qw := w//4  , hh:= h//2  , qh := h//4                          ; // vs / 

        if (winactive("ahk_id " CB_hwnd) and !GC("CB_Display"))
            return

        switch Q
        {
            ;case "F"  ,"0Maximize"             : x := x      , y := y       , w := w  , h := h
            case "TL" ,"1TopLeft"              : x := x      , y := y       , w := hw , h := hh
            case "TR" ,"1TopRight"             : x := x+hw   , y := y       , w := hw , h := hh
            case "BL" ,"2BottomLeft"           : x := x      , y := y+hh    , w := hw , h := hh
            case "BR" ,"2BottomRight"          : x := x+hw   , y := y+hh    , w := hw , h := hh
            case "L"  ,"0LeftHalf"             : x := x      , y := y       , w := hw , h := h
            case "R"  ,"0RightHalf"            : x := x+hw   , y := y       , w := hw , h := h
            case "RL"  ,"0RightHalf"           : x := x+qw   , y := y       , w := hw+qw , h := h
            case "T"  ,"0TopHalf"              : x := x      , y := y       , w := w  , h := hh
            case "B"  ,"0BottomHalf"           : x := x      , y := y+hh    , w := w  , h := hh
            case "LS" ,"3LeftHalfSmall"        : x := x      , y := y       , w := qw , h := h
            case "RS" ,"3RightHalfSmall"       : x := x+3*qw , y := y       , w := qw , h := h
            case "TS" ,"4TopHalfSmall"         : x := x      , y := y       , w := w  , h := qh
            case "BS" ,"4BottomHalfSmall"      : x := x      , y := y+hh+qh , w := w  , h := qh
            case "MT" ,"MTS","4MiddleTopSmall"      : x := x      , y := y+qh    , w := w  , h := qh
            case "MB" ,"MBS","4MIddleBottomSmall"   : x := x      , y := y+hh , w := w  , h := qh
            case "L1" ,"L1TopLeftSmall"        : x := x      , y := y       , w := hw , h := qh
            case "L1v","L1vTopLeftSmall"       : x := x      , y := y       , w := qw , h := hh
            case "L1s","L1vhTopLeftSmall"      : x := x      , y := y       , w := qw , h := qh
            case "L2" ,"L2TopMidLeftSmall"     : x := x      , y := y+qh    , w := hw , h := qh
            case "L3" ,"L3BottomMidLeftSmall"  : x := x      , y := y+hh    , w := hw , h := qh
            case "L4" ,"L4BottomLeftSmall"     : x := x      , y := y+3*qh  , w := hw , h := qh
            case "L4v","L4vBottomLeftSmall"    : x := x      , y := y+hh    , w := qw , h := hh
            case "L4s","L4vhBottomLeftSmall"   : x := x      , y := y+3*qh  , w := qw , h := qh
            case "R1" ,"R1TopRightSmall"       : x := x+hw   , y := y       , w := hw , h := qh
            case "R1v","R1vTopRightSmall"      : x := x+3*qw , y := y       , w := qw , h := hh
            case "R1s","R1vhTopRightSmall"     : x := x+3*qw , y := y       , w := qw , h := qh
            case "R2" ,"R2TopMidRightSmall"    : x := x+hw   , y := y+qh    , w := hw , h := qh
            case "R3" ,"R3BottomMidRightSmall" : x := x+hw   , y := y+hh    , w := hw , h := qh
            case "R4" ,"R4BottomRightSmall"    : x := x+hw   , y := y+3*qh  , w := hw , h := qh
            case "R4v","R4vBottomRightSmall"   : x := x+3*qw , y := y+hh    , w := qw , h := hh
            case "R4s","R4vhBottomRightSmall"  : x := x+3*qw , y := y+3*qh  , w := qw , h := qh
            case "TS" ,"Top Small"             : x := x+th   , y := y+th    , w := tw , h := th
            default: 
                return
        }

        if (winactive("ahk_id " CB_hwnd)) {
            ; Gui, 2: +LastFound
            rows := 25
            if (GC("CB_last_display","list") = "list") {
                switch Q
                {
                    case "TS", "BS": CC("rowMax",6)
                    case "TL", "TR", "BL", "BR", "T", "B": rows := GC("rowMaxHalf",25)
                    case "L" ,"R", "LS", "RS", "RL": rows := GC("rowMaxFull",50)
                    default: CC("rowMax",15)
                }
                UpdateGUI(CreateCacheList(,rows),"list")
            }

            ;CommandBox(GC("CB_sfx"),GC("CB_clr"))
            if !GC("CB_ScrollBars", 0)
                GuiControl, 2: -HScroll +VScroll, CB_Display
            Gui, 2: show
            settimer, addHiddenScrollBar,-400
            CC("CB_position", "x" x " y" y " w" w " h" h)
        }

        WinMove,A,,x,y,w,h

    } ; move active window to different areas of the screen

    MaximizeWin(){
        global CB_hwnd

        if (GC("CB_last_display","list") = "list") AND WinActive("ahk_id " CB_hwnd) {
            UpdateGUI(CreateCacheList(,GC("rowMaxFull",50)),"list")
            ; update number of rows displayed in file listing 
        }

        WinMaximize,A 

    } 

    MinimizeWin(title="A"){
        ; ReleaseModifiers()
        WinMinimize,%title%
    } 

    moveWinBtnMonitors(D = "L") {
        if (D = "L") {
            SI("+#{Left}")
        } else {
            SI("+#{right}")
        }
        CFW()
        return
    }

    WinToDesktop(n = "2") { 
        VD.init()
        wintitleOfActiveWindow:="ahk_id " WinActive("A")
        ; VD.sendToDesktop(wintitleOfActiveWindow,n,0,0)                            ; VD.sendToDesktop(wintitle,whichDesktop, followYourWindow := false, activate := true)
        VD.MoveWindowToDesktopNum(wintitleOfActiveWindow, n)
        return 
    } ; move window between virtual desktops https://github.com/FuPeiJiang/VD.ahk

    CurrentDesktopNum() {
        VD.init()
        return % VD.getCurrentDesktopNum()
    } ; return virtual desktop numbers

    GotoDesktop(n = "2") { ; https://github.com/FuPeiJiang/VD.ahk
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
        global GUI_hwnd
        SetTitleMatchMode, 2 ; match anywhere in title
        IfWinExist, %title%
            WinActivate, %title%
        return
    } 

    SaveWinID(key = "L") {
        global config_path, C
        vde := CurrentDesktopNum() ; virtual desktop environment 
        WinID_%vde%_%key% := WinExist("A")
        IniWrite, % WinID_%vde%_%key%, %config_path%, %A_ComputerName%, WinID_%vde%_%key%
        switch key
        {
            case "SC033": display_key := ","
            case "SC034": display_key := "."
            case "SC035": display_key := "/"
            default: display_key := key
        }
        PU("WinID saved to`nprintscreen + " display_key, C.lgreen, C.bgreen, "300", "60", "-1000", "16", "610")
        keywait()
        ActivateWin("ahk_id " WinID_%vde%_%key%)
        return
    }

    ActivateWinID(key = "L") {
        global config_path
        vde := CurrentDesktopNum() ; virtual desktop environment 
        IniRead, output, %config_path%, %A_ComputerName%, WinID_%vde%_%key%
        ActivateWin("ahk_id " output)
        UpdateCBsfx()
        CFW()
        ; ActivateApp(GC("CB_tgtExe"))
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
        GroupAdd grp, ahk_class %class%
        WinClose ahk_group grp
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
                PU(Process_Name "`nalways on top: ON", C.lgreen, C.bgreen,"250","120", "-800")
        } else {
            Winset, Alwaysontop, OFF , A 
            if (!supress) 
                PU(Process_Name "`nalways on top: OFF", C.pink, C.red,"250","120","-800") 
        }
        return
    } ; toggle active window to be always on top

    ActivatePrevInstance() {
        WinGetClass, ActiveClass, A
        WinGet, p_name     , ProcessName , ahk_class %ActiveClass%
        WinGet, n_instances, List        , ahk_class %ActiveClass%
        ; BlockInput, Mousemove
        ; settimer, BlockInputTimeOut,-600
        if (n_instances > 1)
        {
            WinSet, Bottom,, A
            WinActivate, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner, ; excludes windows with "tabs outliner" in the title
        }
        CursorFollowWin()
        ; BlockInput, MousemoveOff
        return
    } ; activate newest instance of active program if multiple instances exist

    ActivateNextInstance() {
        WinGetClass, ActiveClass, A
        WinGet, p_name, ProcessName , ahk_class %ActiveClass%
        WinGet, n_instances, List, ahk_class %ActiveClass%
        SetStoreCapsLockMode, Off
        ; BlockInput, MouseMove
        settimer, BlockInputTimeOut,-600
        if (n_instances > 1) {
            WinActivateBottom, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,
        } 
        CursorFollowWin()
        ; BlockInput, MouseMoveOff
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
        #SingleInstance Force ; Allow only one instance off this app]                           
        ; #NoTrayIcon                                                               ; remove SystemTray icon                                  
        ; read the System lightmode from the registry 
        RegRead,L_LightMode,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme
        If L_LightMode { ; if the mode was Light                            
            ; write both system end App lightmode to the registry
            RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,0
            RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme ,0
        }
        else { ; if the mode was dark                                         
            RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,1
            RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme ,1
        }
        ; tell the system it needs to refresh the user settings
        run,RUNDLL32.EXE USER32.DLL`, UpdatePerUserSystemParameters `,2 `,True
    } ; toggle dark/light mode for windows apps https://www.autohotkey.com/boards/viewtopic.php?t=73967

; SYSTEM APPS __________________________________________________________________

    IsWinInTray(title) {
        dhw = % a_detectHiddenWindows
        DetectHiddenWindows Off
        If WinExist(title) {
                inTray = 0
            } else {
                DetectHiddenWindows On
                If WinExist(title)
                    inTray = 1
            }
        DetectHiddenWindows % dhw
        return inTray
    } ; detect if window is running in system tray

    clearQuickAccessHistory() {
        Run, control.exe folders
        WinWait, ahk_class #32770
        WinActivate, ahk_class #32770
        WinWaitActive, ahk_class #32770
        Send, !c {Esc}
    } ; clear file explorer quick access file/folder history

    screenShot() {
        switch A_ComputerName
        {
            case "DESKTOP-0B51G3O": send +#s
            case "DESKTOP-MVS0AMH": send {printscreen}
        } 
    }

    PowerOptions(s = "") {
        switch s 
        {
            case "sleep": DllCall("PowrProf\SetSuspendState","int",0,"int",0,"int",0)
            case "hybernate": DllCall("PowrProf\SetSuspendState","int",1,"int",0,"int",0)
            case "shutdown": ShutDown, 9
            case "restart": ShutDown, 2
        }
        return
    }

    ActivateExplorer := Func("ActivateApp").Bind("explorer.exe")

    ActivateCalc() {
        global winpath
        IfWinNotExist, Calculator
            run, %winpath%\system32\calc.exe
        else
        {
            WinGet, CalcIDs, List, Calculator
            If (CalcIDs = 1) ; Calc is NOT minimized                                                  
                CalcID := CalcIDs1
            else
                CalcID := CalcIDs2 ; Calc is Minimized use 2nd ID
            winActivate, ahk_id %CalcID%
        }
        CFW()
        return
    } ; activate windows calculator app

    ActivateMail() {
        IfWinExist, Inbox - Gmail
            WinActivate ; use the window found above                                                     
        else
            Run % A_ScriptDir "\assets\win\Mail.lnk"
        return
    } ; activate windows mail app

    TskMgrExt(max=FALSE) {
        global long
        sleep, long
        if max
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

    WinTimer() {
        Run assets\win\Alarms & Clock.lnk ;SC: alarm clock
        sleep, 900
        send {down}{enter}
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

    GetGUIFocus() {
        GuiControlGet, control, 2:FocusV
        return % control
    }

    SendToCBdisplay(key,DisplayFocus=0) {
        global CB_DisplayVar, UserInput
        GuiControl 2:Focus, CB_DisplayVar            
        SI(key)                               ;replacement for using PgDn key as a modifier key
        if !DisplayFocus
            GuiControl 2:Focus, UserInput
        return
    }

    ReplaceAlias(input) {
        Input := strReplace(Input, ".txt")
        Input := strReplace(Input, ".", GC("PeriodAlias"))
        Input := strReplace(Input, ",", GC("CommaAlias"))
        Input := strReplace(Input, ";", GC("SemicolonAlias"))
        Input := strReplace(Input, "[", GC("LSBracketAlias"))
        Input := strReplace(Input, "]", GC("RSBracketAlias"))
        Input := strReplace(Input, "{", GC("LCBracketAlias"))
        Input := strReplace(Input, "}", GC("RCBracketAlias"))
        sleep, 100
        return % input
    }
    
    runLastLinkFn() {        
        path = %A_ScriptDir%\mem_cache\_lhist.txt
        key := trim(TF_ReadLines(path, 1, 1)," `t`r`n")
        RunLinkFn(key,GC("mode","W")) 
    }

    ActivateTgt() {
        if !WinActive("ahk_exe " GC("CB_tgtExe")) && WinExist("ahk_exe " GC("CB_tgtExe")) {
            ActivateApp("ahk_exe " GC("CB_tgtExe"))
            ; ActivateWin("ahk_id " tgt_hwnd)
        }
    }

    updateClipboardCBDisplay() {
        global CB_hwnd
        if ((GC("CB_last_display") == "Clipboard Contents") AND !WinActive("ahk_id " CB_hwnd)) OR  (GC("CB_last_display") == "First lines of 0-9.txt") OR (GC("CB_last_display") == "First lines of 1 character files") 
            UpdateDisplay()                                           ;Update Command Box display of clipboard contents in Command Box
            return
    }

    
    SubmitIB(prefix = "L",clear = 0,closeAfter=0) {
        ChgFocus("IB"),SI("^a") 
        if clear  
            SI("{del}")
        input := clip()
        sleep, 50
        if (substr(input,1,1) ~= "[A-Z]")
            input :=  substr(input,2)
        sleep, 50            
        ProcessCommand(prefix input,GC("CB_sfx"),GC("CB_clr"))                      
        sleep, 50
        if closeAfter
            Gui, 2:Cancel
    }

    SubmitIB_Edit(prefix = "L",clear = 0,closeAfter=0) {
        ChgFocus("IB"),SI("^a") 
        if clear  
            SI("{del}")
        input := trim(clip())
        sleep, 50

        if (substr(input,1,1) ~= "[A-Z]") {
            input := substr(input,2)
        } 
        
        prefix := (input == "") ? "E" : prefix
        sleep, 50       
        ProcessCommand(prefix input,GC("CB_sfx"),GC("CB_clr"))                      
        sleep, 50
        if closeAfter
            Gui, 2:Cancel
    }

    closeCB() {
        Gui, 2:Cancel
    }
    
    UpdateGUIRowHeight() {
        global CB_hwnd
        if (winactive("ahk_id " CB_hwnd)) {
            if (GC("CB_last_display") = "list") {
                CC("rowMax",33)
                UpdateGUI(CreateCacheList(,GC("rowMax")),"list")
            }
        }
        return
    }

    GetCurrentGUIoptions() {
        optn := " "
        if GC("CommaAlias") or GC("PeriodAlias") or GC("SemicolonAlias") or GC("LSBracketAlias") or GC("RSBracketAlias") or GC("LCBracketAlias") or GC("RCBracketAlias")
        or GC("CB_persistent") or GC("CB_Wrap") or GC("CB_alwaysOnTop") or GC("CB_appActive") {
            if GC("CommaAlias") or GC("PeriodAlias") or GC("SemicolonAlias") or GC("LSBracketAlias") or GC("RSBracketAlias") or GC("LCBracketAlias") or GC("RCBracketAlias") {
                optn := (GC("CommaAlias") ? " ," GC("CommaAlias") " " : "") 
                      . (GC("PeriodAlias") ? "." GC("PeriodAlias") " " : "")
                      . (GC("SemicolonAlias") ? ";" GC("SemicolonAlias") " " : "")
                      . (GC("LSBracketAlias") ? "[" GC("LSBracketAlias") " " : "")
                      . (GC("RSBracketAlias") ? "]" GC("RSBracketAlias") " " : "")
                      . (GC("LCBracketAlias") ? "{" GC("LCBracketAlias") " " : "")
                      . (GC("RCBracketAlias") ? "}" GC("RCBracketAlias") " " : "")
                    ;   . " | "
            } if GC("CB_persistent") or GC("CB_Wrap") or GC("CB_alwaysOnTop") or GC("CB_appActive") {
                optn .= (GC("CB_persistent") ? " P " : "")
                      . (GC("CB_appActive") ? " A " : "") 
                      . (GC("CB_Wrap") ? " W " : "")
                      . (GC("CB_alwaysOnTop") ? " OT " : "") 
                      
            }
            optn .= " | "
            optn := RegExReplace(optn, "S) +", A_Space A_Space ) 
            return optn
        }
    }

    SetCursorWidth(width){
        CARETWIDTH := width
        SPI_SETCARETWIDTH := 0x2007
        SPIF_UPDATEINIFILE := 0x01
        SPIF_SENDCHANGE := 0x02
        FWININI := SPIF_UPDATEINIFILE | SPIF_SENDCHANGE
        DllCall( "SystemParametersInfo", UInt,SPI_SETCARETWIDTH, UInt,0, UInt,CARETWIDTH, UInt,FWININI)
    }

    resetGUIposition() {
        MI := StrSplit(GetMonInfo()," ") ; get monitor dimensions
        hh := MI[4]*.455
        hw := MI[3]*.495
        d := "x" MI[1]+hw " y" MI[2]+hh " w" hw " h" hh ;(2) calc default window dimensions to load when saved position data is not valid
        CC("CB_position", d)
        
        CC("CB_persistent" , 0) 
        CC("CB_Wrap" , 0) 
        CC("CB_alwaysOnTop", 0)
        CC("CB_appActive" , 0)

        CC("CB_ScrollBars" , 0) 
        CC("CB_Titlebar" , 1) 
        CB(GC("CB_sfx"),GC("CB_clr")) 
    } 

    GetLastDisplayedText(ndspl="") {
        switch trim(ndspl) 
        {
            case "First lines of 0-9.txt" : txt := See1stLines(,"^[0-9]\.txt",,GC("MemSummaryLines", 1)) 
            case "First lines of 1 character files": txt :=  See1stLines(,"^[0-9a-zA-Z]\.txt",,GC("MemSummaryLines", 1))
            case "First lines of " GC("PeriodAlias"): txt :=  See1stLines(GC("PeriodAlias"),,,GC("MemSummaryLines", 1))
            case "First lines of " GC("CommaAlias"): txt :=  See1stLines(GC("CommaAlias"),,,GC("MemSummaryLines", 1))
            case "Saved " GC("mode") "_LINKS" : txt := GetIniSect(GC("mode") "_LINKS")
            case "Clipboard Contents" : 
                try {
                    txt := Clipboard
                } catch e {
                    txt := GetIniSect(GC("mode") "_LINKS")
                }
            case "list.txt", "list" : txt := CreateCacheList(,GC("rowMax",26))
            default :
                if instr(ndspl, "*") or !IfMemFileExist(A_ScriptDir "\mem_cache\" ndspl) {
                    ndspl := RegExReplace(ndspl, "\.\txt")
                    ndspl := !RegExMatch(ndspl,"\*$") ? ndspl . "*" : ndspl

                    txt := (ndspl == "*")
                    ? CreateCacheList(,GC("rowMax",26))
                    : CreateCacheList(ndspl, GC("rowMax",26))
                    if !txt {
                        CC("CB_last_display","list")
                        txt := CreateCacheList(, GC("rowMax",26))
                    } else if (TF_CountLines(txt) == 1) {
                        file_name := LineStr(txt, 1, 1)
                        txt := AccessCache(file_name,dir,0)
                        CC("CB_last_display",dir file_name)
                    }
                } else {
                    txt := AccessCache(ndspl,, False)
                }
        }
        return % txt
    }

    IfMemFileExist(path="") {
        If regexmatch(path, "\S+(\.txt)$"){
            IF fileExist(path)
                return 1
        } else if fileExist(path ".txt") or fileExist(path ".ini") {
            return 1
        } Else
            return 0
    }

    SeePastEntries(UD="U") {
        global ChrCodes
        GuiControl, 2: Focus, UserInput 
        send ^a
        hist_pos := GC("CB_hist_counter",0)
        If (UD == "U")
            hist_pos += 1
        else
        { 
            if (hist_pos > 0)
                hist_pos -= 1
            else 
                hist_pos := 0
        }

        CC("CB_hist_counter",hist_pos)
        entry := TF_ReadLines(A_ScriptDir "\mem_cache\_hist.txt", hist_pos, hist_pos)
        clip(entry)

    } ; cycle through CB submission history

    RunCmd(Prefix="",sfx="~win", n = 1, autoSelect = True){
        global med
        sleep, med

        if autoSelect
        {
            ;Send % "+^{left " . n . "}"
            SelectWord()
        }

        U_input := clip()
            
        if (substr(Prefix,1,1) == "V") {
            Prefix := LTrim(Prefix, "V"), U_input := trim(U_input)
            AccessCache(U_input,(U_input ~= "\b[0-9]\b") ? ("") : Prefix)
        } else {
            Send {del}
            RunLabel(U_input, sfx, WinExist("A")) 
        }
    }

    Capitalize1stSubmit(commandkey = ">!space") {
        global short, med, long
        Gui 2: +LastFound
        GuiControl, 2: Focus, UserInput
        if Instr(A_ThisHotkey, commandkey) {
            Send ^a
            Capitalize1stLetter()
        }
        Send {enter}
        return
    } ; submit GUI userinput; commandkey -> submit also capitalizes first letter of user input 

    addHiddenScrollBar() {
        GuiControl, 2: +HScroll +VScroll, CB_DisplayVar
        resetModifiers()
        ; SendToCBdisplay("^{end}")
        ; SendToCBdisplay("^{home}")
        return
    }

    ToggleDisplay(set = ""){
        static fszDisplay := 11

        if (GC("CB_Display") or (set = "Minimal")) {
            fszDisplay := GC("CBfsz")
            CC("CBfsz", "11")
            CC("CB_Titlebar",0), CC("CB_Display",0) ,CC("CB_persistent",0),CC("CB_Wrap",0),CC("CB_reenterInput",1) 
            , IBw := round(A_ScreenWidth//4)
            , MI := StrSplit(GetMonInfo()," ") 
            , cX := (MI[3] - IBw) // 2
            , mw := IBw
            , mh := (3.5 * GC("CBfsz", "11"))
            ; , mh := 20 + (2 * GC("CBfsz", "11"))
            , bY := MI[4] - mh - (2.1 * GC("CBfsz", "11"))
            , CC("CB_position","x" cX " y" bY " w" mw " h" mh)
            GuiControl, 2: Hide, CB_Display
        } else if (!GC("CB_Display") or (set = "Display")) {
            CC("CBfsz", fszDisplay)
            CC("CB_Display", 1), CC("CB_Titlebar", 1), CC("CB_ScrollBars", 0),CC("CB_persistent",0),CC("CB_Wrap",0),CC("CB_reenterInput",1)
            , MI := StrSplit(GetMonInfo()," ") 
            , d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2 
            , CC("CB_position", d)
            GuiControl, 2: show, CB_Display
        }
        CB(GC("CB_sfx"), GC("CB_clr"), GC("CBt_color"), GC("CB_ProcessMod"))
        return
    }

    RunOtherCBsfx(C_input = "", Chr = "W") {
        C_1stchr := SubStr(C_input, 1, 1)
        if (SubStr(C_input, 1, 1) = ":") 
        {
            CC("CB_" Chr "sfx", SubStr(C_input, 2))
            PU(Chr "suffix: " C_input)
            Gui, 2: Cancel
            return
        } else {
            sfx := GC("CB_" Chr "sfx", "~win") 
            RunLabel(C_input, sfx, tgt_hwnd)
        }
        return
    }

    ReplaceFnAlias(arr*) {
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
        p := ReplaceFnAlias(p*)

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
                PU("Sorry can't find function",C.lpurple,,,,-2000)
            }
        }
        return
    }

    RunLabel(UserInput="", suffix = "", tgt_winID ="", base_sfx = "~win") { 
        suffix := suffix ? suffix : GC("CB_sfx")
        UserInput := trim(UserInput)
        Switch 
        {
            Case IsLabel( UserInput . suffix) : UserInput := UserInput . suffix 
            Case IsLabel(":X:" . UserInput . suffix) : UserInput := ":X:" . UserInput . suffix 
            Case IsLabel(":*:" . UserInput . suffix) : UserInput := ":*:" . UserInput . suffix 
            Case IsLabel(":X*:" . UserInput . suffix) : UserInput := ":X*:" . UserInput . suffix ; suffix = ""
            Case IsLabel( UserInput . base_sfx) : UserInput := UserInput . base_sfx
            Case IsLabel(":X:" . UserInput . base_sfx) : UserInput := ":X:" . UserInput . base_sfx
            Case IsLabel(":*:" . UserInput . base_sfx) : UserInput := ":*:" . UserInput . base_sfx
            Default:
                CB(GC("CB_sfx"), GC("CB_clr"), GC("CBt_color"), GC("CB_ProcessMod"))
                return
        } 

        if !WinActive("ahk_exe " GC("CB_tgtExe"))
            ActivateApp(GC("CB_tgtExe"))
        
        sleep 50
        Gosub, %UserInput% 
        sleep 50
        return
    }

    CB( sfx = "~win", w_color = "F6F7F1", t_color = "000000", ProcessMod = "ProcessCommand") {
        CommandBox(sfx, w_color, t_color, ProcessMod)
        ChgFocus("IB"),SI("^a")
    }

    CreateCacheList(path = "", rowMax = 26, ShowExt = 0) {
        ; global strFile := A_ScriptDir . "\mem_cache\" . name . ".txt"
        global strDir := A_ScriptDir . "\mem_cache\" . path
        global cacheListA := cacheListB := buffer_list := ""
        global config_path
        ; FileDelete %strFile%
        CC("CB_display", 1)
        max_len := max_colwidth := cnt := 0
        rePath := strReplace(path,"\","\\")
        ; msgbox % "^\S+\\mem_cache\\(?=" . trim(rePath,"*") . ")\S*$"
        Loop Files, %strDir%*.*, R ; R: Recurse into subfolders.
        { 
            if RegExMatch(A_LoopFilePath, "i)^\S+\\mem_cache\\(?=" . trim(rePath,"*") . ")\S*$") {
                item := RegExReplace(A_LoopFilePath, "^\S+\\mem_cache\\(\S*$)", "$1") 
            } else {
                Continue
            }

            if (substr(item,1,5) == ".tmp.") or (substr(item,-3) == ".csv")
                Continue

            if !ShowExt
                item := StrReplace(item,".txt")
            ; item := rtrim(item,".txt")
            file := item . "`n"
            max_len := max(strlen(file) + 2, max_len)
            cnt += 1

            ; if (file = "z\cmd_del.txt`n") {
            ;     msgbox % file . " " . max_len . " " . strlen(file) " " max_colwidth
            ; }

            if (cnt > rowMax) {
                cacheListB .= file
                if (mod(cnt,rowMax) = 0) {
                    max_colwidth += max_len
                    ; max_colwidth += max_len + 2
                    loop, parse, cacheListA,`n 
                    {
                        buffer_list .= format("{:-" . max_colwidth . "s}", A_LoopField) . "`n"
                    }

                    cacheListA := TF_concat(buffer_list, cacheListB)
                    cacheListB := buffer_list := ""
                }
            } else {
                cacheListA .= file
            }
        }
        max_colwidth += max_len
        loop, parse, cacheListA,`n 
        {
            buffer_list .= format("{:-" . max_colwidth . "s}", A_LoopField) . "`n"
        }
        cacheList := TF_concat(buffer_list, cacheListB)
        ; FileDelete, mem_cache\%name%.txt
        ; FileAppend, %cacheList%, mem_cache\%name%.txt

        return % trim(cacheList," `t`n`r")
    }

    String_Columns(String, Columns) {
        Lines := {}
        Loop, Parse, String, `n
            Lines.Push(A_LoopField)
        Loop, % Ceil(Lines.MaxIndex() / Columns)
        {
            x := A_Index
            Loop, % Columns
                Result .= Lines[(x-1)*Columns+A_Index]"`t"
            Result .= "`n"
        }
        return Trim(Result,"`n`t ")
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

    ChgFocus(t = "IB") {
        global CB_hwnd, FB_hwnd, short, UserInput, tgt_hwnd, CB_DisplayVar
        static GUI_hwnd := ""

        switch t
        {
        Case "IB","input box": 
            WinActivate, ahk_id %CB_hwnd%
            GuiControl, 2: Focus, UserInput 
        Case "DB","display": 
            WinActivate, ahk_id %CB_hwnd%
            GuiControl, 2: Focus, CB_DisplayVar
        Case "TGT","target application": 
            WinActivate, ahk_id %tgt_hwnd%
        }
        ; SetTimer, CFW, -200
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
                    Sendinput % "+^!{" . d . " " . n . "}" ; multi cursor selection for VScode                   
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
        ; BlockInput, Mousemove
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
        CleanedHist := TF_RemoveDuplicateLines(AccessCache("_hist",,False),,,1,false)
        CleanedHist := TF_RemoveBlankLines(CleanedHist)
        CleanedHist := TF_RemoveLines(CleanedHist, lines)
        
        CleanedLHist := TF_RemoveDuplicateLines(AccessCache("_lhist",,False),,,1,false)
        CleanedLHist := TF_RemoveBlankLines(CleanedLHist)
        CleanedLHist := TF_RemoveLines(CleanedLHist, lines)

        FileDelete, mem_cache\_hist.txt
        WriteToCache("_hist.txt",,,CleanedHist,1,1)
        FileDelete, mem_cache\_lhist.txt
        WriteToCache("_hist.txt",,,CleanedLHist,1,1)

    } ; remove duplicates and truncate CB history file

    getKeyLength(txt="") {

        keyMaxLen := 0
        loop,parse, txt, `n
        { 
            RegExMatch(A_LoopField, "O)^([0-9A-Za-z]+)*", keys)
            keyMaxLen := max(keys.Len(1),keyMaxLen)
        }
        return keyMaxLen
    } ;get length of longest key

  ; input box focus color change ---------------------------------------------
    SetFocusedBkColor(W, L := "", M := "", H := "") {
        Static Controls := {}
        If (M && H) { ; system call: W = HDC, L = HWND
            If Controls.HasKey(L) {
                If (L = DllCall("GetFocus", "UPtr")) {
                    Controls[L, "Invalidated"] := False
                    DllCall("SetBkColor", "Ptr", W, "UInt", Controls[L, "Color"])
                    Return Controls[L, "Brush"]
                }
                Else If !Controls[L, "Invalidated"] {
                    Controls[L, "Invalidated"] := True
                    DllCall("InvalidateRect", "Ptr", L, "Ptr", 0, "UInt", 1)
                }
            }
        }
        Else { ; setup call: W = HWND, L = color
            If DllCall("IsWindow", "Ptr", W) {
                If Controls.HasKey(W) {
                    DllCall("DeleteObject", "Ptr", Controls[W, "Brush"])
                    Controls.Delete(W)
                }
                If (L <> "") && ((EditColor := SwapRB(L)) <> "") {
                    Controls[W, "Color"] := EditColor
                    Controls[W, "Brush"] := DllCall("CreateSolidBrush", "UInt", EditColor, "Uptr")
                    Controls[W, "Invalidated"] := True
                }
                DllCall("RedrawWindow", "Ptr", W, "Ptr", 0, "Ptr", 0, "UInt", 0x0405, "UInt")
            }
        }
    }

    SwapRB(Color) { ; converts RGB to BGR and vice versa
        Return ((Color & 0xFF0000) >> 16) | (Color & 0x00FF00) | ((Color & 0x0000FF) << 16)
    }

; LINK OPERATIONS ______________________________________________________________

    SetModeQuickSlot(prefix="PrintScreen & ") {
        slot := StrReplace(A_thishotkey, prefix)
        , CC( slot "_mode",GC("mode"))
        , PU("Bookmark " GC("mode") " mode to " slot)
    }

    LoadModeQuickSlot(prefix="ralt & ") {
        WinID := WinExist("A")
        slot := trim(StrReplace(A_thishotkey, prefix),"$")
        switchMode(GC(slot "_mode","1"))
        ActivateWin("ahk_id " WinID)
    }

    SubmitLinkCommand(CBcloseAfter=0) {
        ; if CB_last_display
        ChgFocus()
        SI("^a",200)
        userInput := clip()
        GC("CB_hist",1) ? FilePrepend(A_ScriptDir "\mem_cache\_lhist.txt", UserInput) : ("")
        RunLinkFn(userInput,GC("mode","W")) 
        if CBcloseAfter
            Gui, 2: Cancel

    } ; adds link letter prefix W|U|B 

    GetIcoPathExt(ico_file = "") {
        if !RegExMatch(ico_file,"(\.[a-zA-Z]{3})$") { ;if no extension in icon path
            If FileExist(ico_file ".ico")
                ico_path := ico_file ".ico"
            else if FileExist(ico_file ".png") 
                ico_path := ico_file ".png"
        } else 
            ico_path := ico_file
        return ico_path
    }

    SwitchMode(mode = "",updateGUI=1) {
        global CB_hwnd, short
        W("ESC")
        if mode
            A := mode
        else {
            if (substr(A_ThisHotkey,0) ~= "[A-Z]")
                A := ConvertUpper(substr(A_ThisHotkey,0), 0)
            else
                A := substr(A_ThisHotkey,0)
        }
        sleep, short
        CC("mode", A)
        ico_file := A_ScriptDir "\assets\Aikawns\" GC("mode") "\" (GC("T_x") ? "black" : "lg")
        SetTrayIcon(ico_file) ; set tray icon to the desired color

        IF WinActive("ahk_id " CB_hwnd) or (updateGUI and WinExist("ahk_id " CB_hwnd)) {
            RunLinkFn(, A) ; show mode Saved Links
            ; change mode icon of ahk GUI: https://www.autohotkey.com/boards/viewtopic.php?t=72727
            hIcon := DllCall("LoadImage", uint, 0, str, GetIcoPathExt(ico_file)
            , uint, 1, int, 0, int, 0, uint, 0x10) ; Type, Width, Height, Flags
            Gui, 2: +LastFound ; Set the "last found window" for use in the next lines.
            SendMessage, 0x80, 0, hIcon 
            SendMessage, 0x80, 1, hIcon 
        }
    }

    GetIniSect(sect = "PATHS", format = True, groupNums = 1) {
        txt := GC(,,sect) ? GC(,,sect) : "-=empty=-"
        keylen := getKeyLength(txt)
        prev_line_letter := ""
        txt_formatted := ""
        sort, txt, C
        txt := CS(txt,,"`am)^([0-9A-Za-z]+)(=)(https?:\/\/)?(www\.)?", "$1`t") ; CS = CleanString ; `a = recognizes any type of newline
        GroupPattern := groupNums ? "[A-Z]" : "[0-9A-Z]"
        standardPattern := groupNums ? "[0-9a-z]" : "[a-z]" 

        if Format {
            loop, parse, txt, `n, ; adds blank line between lines with the same capitalized first letters or numbers; lines with lowercase 1st letters are grouped together
            {
                ARR := StrSplit(A_LoopField,"`t")
                paddingNum := keylen - StrLen(ARR[1]) + 2
                if (prev_line_letter != substr(ARR[1],1,1)) AND (substr(ARR[1],1,1) ~= GroupPattern) {
                    txt_formatted .= "`n"
                    prev_line_letter := substr(ARR[1],1,1)
                } else if prev_line_letter ~= GroupPattern AND substr(ARR[1],1,1) ~= standardPattern {
                    txt_formatted .= "`n" 
                    prev_line_letter := substr(ARR[1],1,1)
                }
                txt_formatted .= format("{:}{:" paddingNum "}{:}",ARR[1]," ",ARR[2]) "`n"
            }
            txt := trim(txt_formatted,"`n") 
        }
        ; return % txt 
        return % txt
    } ; show paths saved in ini file

    GotoLink(key = "",sect = "", link = "") {
        try {
            if instr(key, ",") {
                ARR := StrSplit(key, ",")
                loop % ARR.MaxIndex() {
                    link := GC(ARR[A_index],,sect)
                    if RegExMatch(link,"^(https?:\/\/)") or instr(link,"/") or !instr(link,"\")
                        LURL(link)
                    else
                        OP(link)
                }
            } else {
                link := link ? link : GC(key,,sect)
                if RegExMatch(link,"^(https?:\/\/)") or instr(link,"/") or !instr(link,"\") {
                    LURL(link)
                } else {
                    OP(link)
                }
            }
        } Catch e {
            PU("No valid links found")
        }
        return
    }

    RunLinkFn(input="",sect="B") {
        Global short, med, CB_hwnd
        
        sect := ConvertUpper(sect,0) "_LINKS"
        title:= "Saved " . sect

        sleep, med 
        if (RegExMatch(input, "^(\:[0-9A-Za-z]+)(?!\s[0-9A-Za-z]+)$")) { ;save URL or file/folder path
            
            If (GetGUIFocus() == "UserInput") {
                ActivateApp(GC("CB_tgtExe"))
                sleep, 200
            }

            winget, Pname, ProcessName, A

            RegExMatch(GC("edge_path"), "[^\\]+$", edge_exe) ; get application.exe name
            RegExMatch(GC("chrome_path"), "[^\\]+$", chrome_exe) ; get application.exe name 

            Pname := (Pname = "AutoHotkey.exe") ? GC("CB_tgtExe") : Pname

            Switch Pname
            { 
                case edge_exe : 
                    link := GetURL("Ahk_exe " edge_exe)
                    if !RegExMatch(link,"^(https?:\/\/)") {
                        link := "https://" . link
                    }
                case chrome_exe : 
                    link := GetURL("Ahk_exe " chrome_exe)
                    if !RegExMatch(link,"^(https?:\/\/)")
                        link := "https://" . link
                case "Explorer.EXE": 
                    link := Explorer_GetSelection()
                default:
                    link := "_" clip()
                    ; PU("invalid URL|FILE|FOLDER path"); 
            }
            key := substr(input,2)
            if GC(key,,sect) {
                msgbox, 4100, Save Link, % "Do you want to replace `n" GC(key,,sect)
                IfMsgBox Yes
                    CC(key,link,sect)
                Else
                    return
            } else {
                CC(key,link,sect)
            }

            IF (WinExist("ahk_id " CB_hwnd) AND (GC("CB_last_display",0) == "Saved " sect)) {
                UpdateGUI(GetIniSect(sect) , title)
            }
            PU("Saved")
        } Else if (instr(input, "*") OR input = "") { ;load saved link list/menu
            UpdateGUI(GetIniSect(sect) , title)
        } Else if instr(input, "!") { ;delete link
            ; PU("DELETING KEY")
            input := CS(input,{"!":""}) ; CS: Clean String
            if (instr(input, ",")) {
                ARR := StrSplit(input, ",")
                loop % ARR.MaxIndex() 
                {
                    DC(ARR[A_index],sect)
                }
            } Else {
                DC(input,sect)
            }
            UpdateGUI(GetIniSect(sect) , title)
        } Else if (RegExMatch(input, "(^[\:0-9A-Za-z]+)(\s)([0-9A-Za-z]+)$")) { ; rename key
            ; PU("RENAMING KEY")
            input := trim(input,":")
            ARR := StrSplit(input, " ")
            olink := GC(ARR[1],,sect)

            if GC(ARR[2],,sect) {
                msgbox, 4100, Save Link, % "Do you want to replace `n" GC(ARR[2],,sect)
                IfMsgBox Yes
                {
                    DC(ARR[1],sect)
                    CC(ARR[2],olink,sect)
                }
                Else
                    return
            } else {
                DC(ARR[1],sect)
                CC(ARR[2],olink,sect)
            }
            UpdateGUI(GetIniSect(sect), title)
        } Else if (input ~= "[A-Z]") and (StrLen(input) = 1) { ; load group
            ; txt := GetIniSect(sect)
            ; PU("LOADING SAVED GROUP")
            txt := GC(,,sect)
            loop, parse, txt, `n,
            { 
                if (input == substr(A_LoopField,1,1)) { ; case sensitive
                    link := RegExReplace(A_LoopField, "^([A-Za-z]+)=(.*)", "$2")
                    if RegExMatch(link,"^(https?:\/\/)") 
                        LURL(link)
                    else {
                        OP(link)
                    }
                }
            }
        } Else { ;load simple link

            if (substr(GC(input,,sect),1,1) == "_") {
                clip(substr(GC(input,,sect),2))
            } else {
                if WinActive("ahk_group FileListers") and !instr(input, ",") { ; for "save as" dialogue change folder to saved folder path
                    ; msgbox % "`ninput: " . input . "`n sect: " .  sect
                    try {
                        changeDialDir(GC(input,,sect))
                    } catch e {
                        CF(GC(input,,sect))
                    }
                } else {
                    GotoLink(input,sect)
                }
            }
            if !GC("CB_persistent", 0)
                Gui, 2: Cancel
        }

        if GC("CB_persistent", 0)
            ActivateApp(GC("CB_tgtExe"))
            ; Commandbox(GC("CB_sfx"),GC("CB_clr")), ActivateApp(GC("CB_tgtExe"))
            
    }

    saveLink(key = "", default_sect = "1") {

        section := GC("mode", default_sect)
        RunLinkFn(":" key,section)
    }

    LoadLink(key = "", default_sect = "B") {
        RunLinkFn(key,GC("mode", default_sect))
        resetModifiers()
    }

; MEMORY SYSTEM ________________________________________________________________

    GetFirstLines(startline=1,endline=1,dir="") {
        output := ""
        dir := ((substr(dir,0) != "\") and dir) ? dir . "\" : dir 
        path = %A_ScriptDir%\mem_cache\%dir%*.txt
        border := RepeatString("-", 40)
        MaxNameLen := 0

        Loop, Files, %path%
        { 
            MaxNameLen := max(StrLen(rtrim(A_LoopFileName,".txt")),MaxNameLen)
        }

        Loop, Files, %path%
        {
            lines := TF_ReadLines(A_LoopFilePath, StartLine, EndLine) ; FileReadLine, first_line, % A_LoopFilePath, 1       
            splitpath, A_LoopFileName,,,,NameNoExt
            fl := lines
            ; fl := trim(lines, " `t`r`n")

            1stpadding := MaxNameLen - StrLen(NameNoExt) + 2
            1stline := TF_InsertPrefix(TF_ReadLines(A_LoopFilePath, 1, 1), 1, 1, RepeatString(" ",1stpadding))

            remainingLines := (endline > 1) ? TF_InsertPrefix(TF_ReadLines(A_LoopFilePath, 2, endline), 1, endline, RepeatString(" ",MaxNameLen + 2)) : ""
            ; msgbox % remainingLines
            result =%border%`n%NameNoExt%%1stline%`n%remainingLines%`n 
            output .= result
        }
        CC("MemSummaryLines", endline)
        Return % output
    } 

    SeeFirstLines(startline=1,endline=1,blen=30, alpha = 0){
        output := ""
        border := RepeatString("-", blen)
        Loop, Files, %A_ScriptDir%\mem_cache\?.txt
        {
            if regexmatch(A_LoopFileName, "\d\.txt") or alpha {
                lines := TF_ReadLines(A_LoopFilePath, StartLine, EndLine) ; FileReadLine, first_line, % A_LoopFilePath, 1       
                splitpath, A_LoopFileName,,,,NameNoExt
                fl := trim(lines, " `t`r`n")
                result =%border%`n[%NameNoExt%] %fl%`n 
                output .= result
            }
        }
        CC("MemSummaryLines", endline) ; record last entered number of lines displayed for GUI update
        line := TF_ReadLines(clipboard, StartLine, EndLine)
        CBresult =%border%`n[CB] %line%
        output := output  CBresult
        Return % output
    }

    See1stLines(dir="", rePattern="\S+", startline=1,endline=1,blen=30){
        output := ""
        border := RepeatString("-", blen)
        Loop, Files, %A_ScriptDir%\mem_cache\%dir%*.*
        {   
            ; msgbox % A_LoopFileName
            if regexmatch(A_LoopFileName, rePattern) {
                lines := TF_ReadLines(A_LoopFilePath, StartLine, EndLine) ; FileReadLine, first_line, % A_LoopFilePath, 1       
                splitpath, A_LoopFileName,,,,NameNoExt
                fl := trim(lines, " `t`r`n")
                result =%border%`n[%NameNoExt%] %fl%`n 
                output .= result
            }
        }
        CC("MemSummaryLines", endline) ; record last entered number of lines displayed for GUI update
        line := TF_ReadLines(clipboard, StartLine, EndLine)
        CBresult =%border%`n[CB] %line%
        output := output  CBresult
        Return % output
    }

    CompareMemFiles(dir="", rePattern="\S+", startline=1,endline=1,blen=30){
        output := ""
        border := RepeatString("-", blen)
        Loop, Files, %A_ScriptDir%\mem_cache\%dir%*.*
        {   
            ; msgbox % A_LoopFileName
            if regexmatch(A_LoopFileName, rePattern) {
                lines := TF_ReadLines(A_LoopFilePath, StartLine, EndLine) ; FileReadLine, first_line, % A_LoopFilePath, 1       
                splitpath, A_LoopFileName,,,,NameNoExt
                fl := trim(lines, " `t`r`n")
                result =%border%`n[%NameNoExt%] %fl%`n 
                output .= result
            }
        }
        CC("MemSummaryLines", endline) ; record last entered number of lines displayed for GUI update
        line := TF_ReadLines(clipboard, StartLine, EndLine)
        CBresult =%border%`n[CB] %line%
        output := output  CBresult
        Return % output
    }

    WriteToCache(key, del_toggle = False, mem_path = "", input = "", append = false, supress = False) {
        ; creates a txt file in \mem_cache from selected text
        global C
        ; Critical
        if !RegExMatch(key,"(\.[a-zA-Z]{3})$")
            key .= ".txt"
        if (SubStr(mem_path, 2, 1) = ":") ; check if second character is ":" to test if absolute path given 
            key_path := mem_path . key . RetrieveExt(tgt)
        else if (SubStr(key, 2, 1) = ":")
            key_path := key . RetrieveExt(tgt) ; check if memory key is actually a path to a file, instead of just the file
        else
            key_path := A_ScriptDir . "\mem_cache\" mem_path . key . RetrieveExt(tgt)

        if !input
            input := clip() ; captures selected text if no input given 

        if (input = "") { ; do nothing if no text selected and no input file given 

        } else {
            if !append
                FileDelete, %key_path%
            FileAppend, %input%, %key_path%
            if !supress
                PU("Written to " key, C.lgreen)
        }
        if (del_toggle = TRUE)
            Send {del}
        return
    } ; creates a txt file in \mem_cache from selected text

    RetrieveExt(tgt) {
        out := ""
        if !RegExMatch(tgt,"(\.[a-zA-Z]{3})$") { ; if no 3 character file extension given 
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
        ; msgbox % key mem_path
        if (SubStr(mem_path, 2, 1) = ":") ; check if second character is ":" to test if absolute path given 
            input = %mem_path%%key%
        else if (SubStr(key, 2, 1) = ":")
            input = %key% ; check if memory key is actually a path to a file, instead of just the file
        else
            input = %A_ScriptDir%\mem_cache\%mem_path%%key%

        if !RegExMatch(input,"(\.[a-zA-Z]{3})$") ; check if there's a file extension
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
        clip(output) ; clip(output, True)
        return
    } ; paste contents of txt|ini file or assign to variable

    OverwriteMemory(del_toggle = false) {
        global C, CB_hwnd, short
        WinID := WinExist("A") 
        slot := substr(A_ThisHotkey, 0) 
        WriteToCache(slot, del_toggle) ; note: if no text selected, no overwrite will occur                                        
        
        If ((WinExist("ahk_id " CB_hwnd)) 
        and (slot = substr(GC("CB_last_display"),1,1) or GC("CB_last_display") = "First lines of 0-9.txt" or GC("CB_last_display") = "First lines of 1 character files")) 
        or (GC("CB_persistent",0)) 
        {
            UpdateDisplay()
        }
        return
    }

    AddToMemory(slot = "", input = "", del_after_copy = "0", del_breaks = 0, del_blank_lines = 0, del_leading_spaces = 0){
        global C, CB_hwnd, short
        ;BlockInput, on
        ;settimer, BlockInputTimeOut,-600
        slot := slot ? slot : substr(A_ThisHotkey, 0)
        input := input ? input : clip()
        input := clip()
        input := del_breaks ? FormatBreaks("no break",input) : input
        var := del_blank_lines ? RemoveBlankLines(0,var) : var
        input := del_leading_spaces ? RegExReplace(input, " [ `t]+", " ") : input
        new_text_to_add := Input
        FileAppend % "`n" . new_text_to_add, mem_cache\%slot%.txt 
        PU("added to bottom of " slot ".txt",C.lgreen)
        UpdateDisplay()
        if (cut = true)
            Send {del}
        ;BlockInput, Off
        return
    } ; appends selected text to single digit memory file

    RetrieveMemory(mpaste = "^#LButton", mprompt="#!LButton", pasteOvr="PrintScreen", mpasteNum = "0" ) {
        global med, short, C
        WinID := WinExist("A") 
        ; BlockInput, mousemove
        ; settimer, BlockInputTimeOut,-600
        if (Instr(A_ThisHotkey, mprompt)) {
            Clicks(2)
            PU("PASTE WHICH SLOT #?",C.lpurple,"000000", "230", "75", "-5000", "14", "610")
            input, mem_slot, L1 T5
            Gui, PopUp: Destroy
        } else if Instr(A_ThisHotkey, mpaste) {
            Clicks(2)
            mem_slot := mpasteNum
            ; PU(mpasteNum " PASTED", C.lgreen, , "230", "75", "-600", "14", "610")
        } else {
            mem_slot := substr(A_ThisHotkey, 0) ; store last key pressed in hotstring/hotkey as memory slot selection                             
        } 

        ActivateWin("ahk_id " WinID)
        ; PU(A_ThisHotkey,,,,, -2000)
        AccessCache(mem_slot)
        if Instr(A_ThisHotkey, pasteOvr) { 
            del_char := strlen(AccessCache(mem_slot, ,False))
            del_char := (del_char < 200) ? del_char : "" ; delete after paste inconsistent with large blocks of multi-line text                  
            Sendinput {del %del_char%}
            return
        }
        ; BlockInput, Off
        SendInput {Lwin up}
        return
    } ; retrieves text to single digit memory file

; AHK/INI UTILITIES ____________________________________________________________
  ; stuck modifier key reset -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    StuckModKeyIndicator()
    {
        Global check_key 
        key_list := ["RSHIFT","LSHIFT","LWIN","LALT","RALT","RCTRL","LCTRL"
                    ,"ESCAPE","F1","F2","HOME","END","INSERT","PRINTSCREEN", "CAPSLOCK"]

        loop % key_list.MaxIndex()
        {
            state := (GetKeyState(key_list[A_Index]) OR GetKeyState(key_list[A_Index],"P")) ? 1 : 0
            if state
            {
                width := strlen(key_list[A_Index]) * 10, y_coord := A_ScreenHeight - 20, x_coord := A_ScreenWidth - strlen(key_list[A_Index]) * 10, check_key := key_list[A_Index]
                SplashImage,,b x%x_coord% y%y_coord% H20 W%width% ZY0 ZX0 fs9 ct1C3DB8 cwFFFFE0, % key_list[A_Index], , ,Arial
                SetTimer, CheckIfKeyUp, 600
            }
        }
    } 

    CheckIfKeyUp()
    {
        Global check_key
        state := GetKeyState(check_key)
        if !state
        {
            SplashImage, Off
            SetTimer, CheckIfKeyUp, Off
        }

    }


    resetModifiers(supressPopUp=1) {
        if !supressPopUp
            PU("modifier keys reset")

        
        SendEvent {rShift Up}{rCtrl Up}{rAlt Up}{lShift Up}{lCtrl Up}{lAlt Up}{lwin up}{esc up}{pgdn up}{pgup up}
        return
    }
    
    ToggleStuckKeyResetLoop(fnTimer:=3000, idletimer:=777)
    {
        static Toggle
        resetModifiers(1)
        SetTimer, KeyStuckFix, % (Toggle:=!Toggle) ? fnTimer : "Off" 
        PU("Set stuck modifier key reset loop:" toggle)
        KeyStuckFix: 
            if (A_TimeIdlePhysical > idletimer) {
                resetModifiers(1)
            }
            Return
    } ; toggle repeating loop timer that sends up presses to modifier keys

    KeyCombination(ExcludeKeys:="") { 
        ;All pressed keys and buttons will be listed   
        ;source: https://www.autohotkey.com/boards/viewtopic.php?style=7&t=98624

        ExcludeKeys .= "{Shift}{Control}{Alt}{WheelUp}{WheelDown}"
        Loop, 0xFF
        { 
            IF !GetKeyState(Key:=Format("VK{:02X}",0x100-A_Index))
                Continue
            If !InStr(ExcludeKeys,Key:="{" GetKeyName(Key) "}")
                KeyCombination .= RegexReplace(Key,"Numpad(\D+)","$1")
        }
        Return, KeyCombination
    } ; show which keys are being pressed in a tooltip popup

  ; VSCODE-LIKE COORD COMBINATIONS -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    
    KeyWaitHook(Options:= "",EndKeys:="{esc}",MatchList:="") {
        ih := InputHook(Options, EndKeys, MatchList)
        ih.Start()
        ErrorLevel := ih.Wait()
        if (ErrorLevel = "EndKey")
            ErrorLevel .= ":" ih.EndKey

        OutputVar := ih.EndMods . ih.Input 
        return OutputVar
        /* The characters Ctrl+A through Ctrl+Z correspond to Chr(1) through Chr(26)
            CtrlC := Chr(3)
            if (ih.Input = CtrlC)
                MsgBox, You pressed Control-C.
            
        */
    } 
    

  ; WRAP NATIVE AHK COMMANDS INTO FUNCTIONS -- -- -- -- -- -- -- -- -- 

    S(k = "down", sleep = "100", n = 1, SendInput ="") { 
        ; function wrapper to chain line commands using the comma operator
        ; also contains shorter aliases for frequently performed send operations
        ; si := SendInput
        switch k 
        {
            case "suspend" : suspend
            case "e", "enter": Send % "{enter}"
            case "u", "up" : Send % "{ up " n "}"
            case "d", "down" : Send % "{ down " n "}"
            case "l", "left" : Send % "{ left " n "}"
            case "r", "right": Send % "{ right " n "}"
            Default : Send % k
        }
        if sleep 
            sleep, %sleep%
        return
    } ; Send namespace alias/function wrapper to chain line commands using the comma operator

    SI(k = "down", sleep = 0 , si=True, n = 1) { 
        ; function wrapper to chain line commands using the comma operator
        ; also contains shorter aliases for frequently performed send operations

        switch k 
        {
            case "suspend" : suspend
            case "enter" : % (si ? Sendinput : Send) "{enter}"
            case "u", "up" : % (si ? Sendinput : Send) "{up " n "}"
            case "d", "down" : % (si ? Sendinput : Send) "{down " n "}"
            case "l", "left" : % (si ? Sendinput : Send) "{left " n "}"
            case "r", "right": % (si ? Sendinput : Send) "{right " n "}"
            Default : Sendinput % k
            ; Default          : Sendinput % k
        }
        if sleep {
            sleep, %sleep%
        }
        keywait()
        return
    } ; SendInput namespace alias/function wrapper to chain line commands using the comma operator

    reloadWG() { 
        Global config_path
        TF_RemoveBlankLines(config_path)
        W("lw","s")
        CC("CBfsz", "11")
        ; Gui, 2: Destroy
        if (!WinExist("ahk_exe chrome.exe") AND GC("IncogWinID",""))
            DC("IncogWinID")
        Reload
    } ; reload WinGolems

    SaveReloadAHK() {
        KeyWait, ctrl
        SendInput, ^s
        sleep, 300
        WinGetTitle, WindowTitle
        If (InStr(WindowTitle, ".ahk")){
            Reload
        }
        Return
    } ; Ctrl and S → Save changes and, if an AutoHotkey script, reload it

  ; MODIFY/ACCESS CONFIG.INI -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    DC(key = "", sect = "") {
        global config_path
        section := sect ? sect : A_ComputerName
        IniDelete, %config_path%, %Section% , %Key%
    } ; Delete config.ini entry   

    CC(key = "", nval = "", sect = "") { ; Change Config.ini
        global config_path
        section := sect ? sect : A_ComputerName

        if (nval = "!") {
            IniRead, state, %config_path%,%section%,%key%, 0
            IniWrite, % !state, %config_path%,%section%,%key%
        } else { 
            IniWrite, %nval%, %config_path%,%section%, %key%
        }
        return
    } ; (C)hange (C)onfig.ini entry

    GC(key = "", d = "", sect = "") { ; Get Config.ini value
        global config_path

        if (!sect AND key) {
            sect := A_ComputerName
        } 

        d := !d ? A_space : d
        try {
            IniRead, val, %config_path%, %sect%, %key%, %d%
        } catch {
                /*  loop other sections of config.ini 
                    IniRead, SectionNames, %config_path%
                    arr := StrSplit(SectionNames, "`n")
                    loop 
            */
            return
        }

        ; arr := StrSplit(SectionNames, "`n")
        return % val
    } ; Get Config.ini value ; d = default value if config.ini entry not found

    TC(sect = "T_CF", msg = "") {

        global config_path, C
        msg := msg ? msg : (sect . ":") 
        IniRead, state, %config_path%, %A_ComputerName%, %sect%, 0
        IniWrite, % !state, %config_path%, %A_ComputerName%, %sect%

        if msg 
        {
            if !state
                PU( msg "True",C.lgreen,,"300","90", "-1000")
            else if state
                PU( msg "False",C.pink,,"300","90", "-1000")
            sleep, 250
            return
        }
    } ; (T)oggle (C)onfig.ini variable with 1 or 0, sets to 1 if no variable found

    renameINIsect(oldName = "", newName = "") {
        Global config_path
        oldName := "[" oldName "]"
        newName := "[" newName "]"
        FileRead, iniData, %config_path% 
        if (ErrorLevel) { 
            MsgBox, File read of %config_path% failed... 
        } else {
            UpdatedData := StrReplace(iniData,oldName,newName)
            ; WriteToCache(1,,,UpdatedData)
            FileDelete, %config_path% 
            FileAppend, %UpdatedData%, %config_path% 
            MsgBox, %config_path% has been updated. 
        }
    } 

  ; POPUPS GUI positioning info -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    ShowTime(paste_key="", show_key = "", msgbox_key = ""){
        FormatTime, MyTime,, hh:mm:ss tt
        switch A_ThisHotkey
        {
            case show_key: PU(MyTime,,,,,"-1500")
            case paste_key: clip(MyTime)
            case msgbox_key: msgbox % MyTime
        }
        return
    } 

    PU(msg, w_color = "F6F7F1", ctn = "000000", wn = "400", hn = "75", drtn = "-600", fsz = "16", fwt = "610", fnt = "Gaduigi", alignL = 0) {
        WinID := WinExist("A")
        WinGetPos, winX, winY, winWidth, winHeight, A
        ; WinGetTitle, Title, A

        global config_path, C, bgreen
        Gui, PopUp: destroy
        Gui, PopUp: New
        IniRead, CB_WinID, %config_path%, %A_ComputerName%, CB_hwnd

        if WinExist("ahk_id " CB_WinID) 
            Gui, PopUp:+Owner2 ; PopUp always on top of command box

        Gui, -Caption ; To remove the border and title bar from a window with a transparent background, use the following after the window has been made transparent:
        Gui, font ,s%fsz% W%fwt%, %fnt%
        center := alignL ? "" : "center"
        Gui, PopUp: Add, Text, c%ctn% xm ym-1 %Center%, %msg%
        Gui, PopUp: Color, %w_color%
        GetGUIWinCoords(GUI_X, GUI_Y) ; get coordinates for positioning PopUp in center of screen
        GUI_Y := GUI_Y + (GUI_Y*0.85) ; move y coordinate to bottom half of screen
        Gui, PopUp: Show, Autosize, 
        Gui, PopUp: Show, % "x" GUI_X " y" GUI_Y 
        Gui, PopUp: +LastFound +AlwaysOnTop
        SetTimer TimeOut, %drtn%
        ActivateWin("ahk_id " WinID)
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
    } ; alias for PopUp 

    BlockInputTimeOut() {
        SetTimer,, Off
        ; BlockInput, MouseMoveOff
        BlockInput, default
        Send {shift up} ; corrects sticky key problem
        Send {ctrl up} ; drawing of the CB sometimes interferes
        Send {lwin up} ; with key up signals, making windows believe the keys is still pressed
        ; BlockInput, Off
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
        CurrentMonitorIndex := GetCurrentMonitorIndex() ; get current monitor index
        DetectHiddenWindows On ; get Hwnd of current GUI
        Gui +LastFound +OwnDialogs +AlwaysOnTop
        GUI_Hwnd := WinExist()
        Gui, Show, Hide
        GetClientSize(GUI_Hwnd,GUI_Width,GUI_Height) ; Calculate size of GUI
        DetectHiddenWindows Off
        GUI_X := CoordXCenterScreen(GUI_Width, CurrentMonitorIndex) ; Calculate where the GUI should be positioned
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

    GetMonInfo(type = "Monitor", wa = 0, ha = 0) {
        n := GetCurrentMonitorIndex()
        CC("CBtgt_MonIdx",n)
        SysGet, XY, %type% , %n% ; SysGet, XY, MonitorWorkArea , %n%
        x := XYLeft 
        y := XYtop
        w := Abs(XYLeft-XYRight)+wa , h := Abs(XYtop-XYbottom)+ha
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
            SGw := Abs(SGLeft - SGRight) , SGh := Abs(SGtop - SGbottom)
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
            PU("config.ini updated",C.lgreen,,,,-2000)
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
        winHandle := WinExist("A") ; The window to operate on
        VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
        monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)
        DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo)
        Left := NumGet(monitorInfo, 20, "Int") ; Left
        Top := NumGet(monitorInfo, 24, "Int") ; Top
        Right := NumGet(monitorInfo, 28, "Int") ; Right
        Bottom := NumGet(monitorInfo, 32, "Int") ; Bottom
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
            msg := "around " Sec " sec have elapsed!`n" "(" round(TimedDuration) " ms)"
            . "`n WinDelay: " A_winDelay
            . "`n BatchLines: " A_BatchLines 
            . "`n ListLines: " A_ListLines 
            if !PU
                MsgBox % msg
            else
                PU(msg,,,,,-9000)

            Return TimedDuration
        }
        Else
            StartTimer := A_TickCount
    }

  ; CONFIGURATION/SETUP -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    ConfigureWinGolems(config_path = "", apps*) {
        global C, exe := {}
        static doc_exe, xls_exe, ppt_exe, pdf_exe, html_exe, editor_exe

        ; path := RetrieveINI(A_ComputerName, "editor_path")
        path := GC("editor_path",,A_ComputerName)
        if (!FileExist(config_path) or path = "ERROR") {
            Gui, c: +LastFound
            Gui, c: Destroy 
            Gui, c: New,,% " (-(-_(-_-)_-)-) WinGolems Configuration"
            Gui, c: +LastFound +OwnDialogs +Owner -DPIscale +Resize +AlwaysOnTop ; +E0x08000000 +Resize  +E0x00200 (border)
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
            Gui, c: Add, Button, w%rw% ys Default gSubmit_Button, submit ; Gui, c: Add, Button, ys h35 x+5 w80 Default gEnter_Button, Enter ;

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
        CC("doc_exe" , exe["doc"])
        CC("xls_exe" , exe["xls"])
        CC("ppt_exe" , exe["ppt"])
        CC("pdf_exe" , exe["pdf"])
        CC("html_exe" , exe["html"])
        CC("doc_path" , PATH[exe["doc"]])
        CC("xls_path" , PATH[exe["xls"]])
        CC("ppt_path" , PATH[exe["ppt"]])
        CC("pdf_path" , PATH[exe["pdf"]])
        CC("html_path" , PATH[exe["html"]])
        CC("editor_path" , PATH[exe["editor"]])
        CC("starting_icon" , "lg.ico", "settings")
        ; timecode(0)
        PU("Configuration complete`nYou are good to go!", C.lgreen, C.bgreen, "200", "60", "-1200", "15") 
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
            PU("Please wait`nWinGolems is searching for " exe,C.lblue,,, "60", "-10000", "15")
            for each, dir in FOLDER
            {
                Loop Files, %dir%%exe%, R
                {
                    RegExMatch(A_LoopFileFullPath, "[^\\]+$", file_name)
                    ; if (strlen(exe) = strlen(file_name)) {                        ; Equal (=), case-sensitive-equal (==)                       
                    if (exe = file_name) { ; Equal (=), case-sensitive-equal (==)                        
                        PATH[exe] := A_LoopFileFullPath
                        Continue
                    }
                }
            }
        }
        return % PATH
    }

    SetTrayIcon(ico_file) {
        Menu, Tray, Icon, % GetIcoPathExt(ico_file)
    }

    ChangeTrayIcon(ico_path) {
        global config_path
        FileList := []
        FileCount := 0

        starting_icon := GC("starting_icon",,"settings")
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
                PU("Win+L Lock: ON",,C.bgreen,"200",, "-800")
            else
                PU("Win+L Lock: OFF", C.lpurple,,"200",, "-800")
        }
        return
    }

    GenerateHotkeyList() {
        ; generate a .txt list of all active hotkeys 
        ; then opens that .txt in the default editor (config.ini)
        ;ReleaseModifiers()
        global long, med
        run %A_ScriptDir%\golems\tools\Hotkey_Help.ahk ; Run modified version of original script
        sleep, long * 2
        DetectHiddenWindows On ; Allows a script's hidden main window to be detected.
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
            ;CC("CB_title_file", "..\HotKey_List.txt") 
            CC("CB_last_display", "..\HotKey_List.txt") 
            CB(GC("CB_sfx"), GC("CB_clr"), GC("CBt_color"), GC("CB_ProcessMod")) 
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

    ReleaseModifiersOld(timeout := "") { ; timeout in ms
        ; sometimes modifier keys get stuck while switching between programs
        ; this function call can be embedded in a function to fix that.
        static aModifiers := ["Ctrl", "Alt", "lctrl", "rctrl", "lalt", "ralt", "Shift", "RShift", "LShift", "LWin", "RWin", "PrintScreen"]

        Send {blind}

        startTime := A_Tickcount
        while (isaKeyPhysicallyDown(aModifiers))
        {
            if (timeout && A_Tickcount - startTime >= timeout)
                return 1 ; was taking too long
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

    EnableCMODE() {
        CMODE = true
    }

    DisableCMODE() {
        CMODE = false
    }

    IsCMODE() {
        return %CMODE% = true
    }

    /*
        global LaltMODE
        LaltMODE = false

        *lalt::
            EnableLAltMODE()
        return

        *lalt up::
            DisableLaltMODE()
            SI("{lalt up}")
        return

        EnableLaltMODE() {
            LaltMode = true
        }

        DisableLaltMode() {
            LaltMode = false
        }

        IsLaltMODE() {
            return %LaltMODE% = true
        }

        global LctrlMODE
        LctrlMODE = false

        *Lctrl::
            EnableLctrlMODE()
        return

        *Lctrl up::
            DisableLctrlMODE()
            SI("{lctrl up}")
        return

        EnableLctrlMODE() {
            LctrlMode = true
        }

        DisableLctrlMode() {
            LctrlMode = false
        }

        IsLctrlMODE() {
            return %LctrlMODE% = true
        }
    */
  ; Debugging

    Log(input,logFile="1",pop=1) {
        writetocache(logFile,,,input,1,pop) ; log(GetURL("Ahk_exe chrome.exe"))    
        return
    } ; append variable value to a file

; FILE AND FOLDER ______________________________________________________________

    CopyFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false)
    {
        ; https://www.autohotkey.com/docs/commands/FileCopy.htm
        ; Copies all files and folders matching SourcePattern into the folder named DestinationFolder and
        ; returns the number of files/folders that could not be copied.

        ; First copy all the files (but not the folders):
        FileCopy, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
        ErrorCount := ErrorLevel
        ; Now copy all the folders:
        Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
        {
            FileCopyDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
            ErrorCount += ErrorLevel
            if ErrorLevel  ; Report each problem folder by name.
                MsgBox Could not copy %A_LoopFileFullPath% into %DestinationFolder%.
        }
        return ErrorCount
    }

    copyFiles(dest_path="", F*) {
        loop % F.MaxIndex()
        { 
            FileCopy,% A_ScriptDir "\" F[A_Index],% dest_path F[A_Index], 1
        }

        return
    }

    StorePath(key = "", sect = "PATHS") {
        PU("saving path to " substr(A_ThisHotkey,0))
        if WinActive("ahk_group FileListers") {
            CC(key,Explorer_GetSelection(),sect)
        }
    }

    RecallPath(key = "", sect = "PATHS") {
        ; WriteToCache(1,,,substr(A_ThisHotkey,0),,1)
        if WinActive("ahk_group FileListers") {
            path := GC(key,,sect)
            if RegExMatch(path,"(\.[a-zA-Z]{3})$") {
                OP(path)
            } Else {
                CF(path)
            }
        }
    }

    deletePath(sect = "PATHS") {
        if WinActive("ahk_group FileListers") {
            DC(substr(A_ThisHotkey,0),sect)
        }
    }

    ToggleNavPane() {
        ControlFocus, DirectUIHWND2, ahk_class CabinetWClass
        KeyWait()
        Send {Alt}
        Send vn{enter}
        return
    }

    SP(key = "") {
        SavePath(key)
        return
    }

    savePath(key = "") {
        ;BlockInput, on
        settimer, BlockInputTimeOut,-1000
        if WinActive("ahk_exe Explorer.EXE")
            path := Explorer_GetSelection()
        else 
            path := clip()
        CC(key, path)
        PU(key ": " path "`nSAVED",C.lgreen,,,,-1200) 
        ;BlockInput, Off
        return 
    }

    OP(path = "") {
        OpenPath(path)
        return
    }

    OpenPath(path = "") {
        global short, med
        sleep short
        SplitPath, path, FileName, Dir, Extension, NameNoExt
        Sendinput {esc}
        if (path = "") {
            PU("No saved path found")
            return
        ; } else if (WinActive("ahk_exe Explorer.EXE") or (GC("CB_sfx") = "~fe")) {
        ;     sleep, 200
        ;     AA("explorer.exe")
        ;     sleep, 200
        ;     CF(A_script "\mem_cache")
        ;     return
        } else {
            try {
                sleep, short 
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
        CoordMode, Mouse, screen ;use "screen" for saving and returning mouse positions and "window" for saving and recalling clicks relative to an app window 
        MouseGetPos, StartX, StartY
        ControlFocus, DirectUIHWND2, ahk_class CabinetWClass ;move focus to current folder contents pane
        SendInput ^{home}
        sleep, med * 1.5
        CursorRecall(PosKey, "1", "right", 0) 

        n := 0
        Loop {
            MouseGetPos,,,, fc
            Sleep, fc ? 25 : 0
        } Until !fc ||g_highlight ++n > 80
        sleep 100

        ; Send % (Instr(A_ThisHotkey, "^") ? "{down 3}" : "{down 2}") "{Enter}"       ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise       
        Send % (Instr(A_ThisHotkey, "^") ? "u" : "g") "{Enter}" ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise                 
        sleep, short
        DllCall("SetCursorPos", "int", StartX, "int", StartY) ; used instead of MouseMove for multi-monitor setups 
        ; MouseMove StartX, StartY
        Return
    }

    ToggleInvisible() {
        global short
        if (A_OSVersion >= 10.0.22000) { ;windows 11
            AA("explorer.exe"),
            SI("{alt}{right 2}{enter}",100),
            SI("{up}{right}{up}{enter}") 
        } else {
            KeyWait()
            Send {alt down}{alt up}v
            sleep, 600
            Send {h 2}
        }
        sleep, short
        PU("Toggle hide/show hidden files")
    }

    GroupBy(category="",win11=FALSE) {
        global short
        sleep, 200
        SI("{alt}",100), SI("vg",100)
        switch category
        {
            case "name":          S("{enter}")
            case "date modified": S("{down 1}{enter}") 
            case "file type":     S("{down 2}{enter}")
            case "size":          S("{down 3}{enter}") 
            case "date created":  S("{down 4}{enter}")
            case "none":          S("{up 4}{enter}")
            default:
            return 
        }
        /*
            if (win11 AND A_OSVersion >= 10.0.22000) { ;windows 11
                AA("explorer.exe"),
                SI("{alt}{right}{enter}",100),
                SI("{up}{enter}",100)
                switch category
                {
                    case "name":          SI("{enter}")
                    case "date modified": SI("{down}{enter}")
                    case "file type":     SI("{down 2}{enter}")
                    case "size":          SI("{down 3}{enter}")
                    case "date created":  SI("{down 4}{enter}")
                    default:
                    return 
                }
            } else {
                
            }
        */
    }

    SortBy(category="",win11=FALSE) {
        global short
        SI("{alt}",100), SI("vo",100)
        switch category
        {
            case "name":          SI("{enter}")
            case "date modified": SI("{down}{enter}")
            case "file type":     SI("{down 2}{enter}")
            case "size":          SI("{down 3}{enter}")
            case "date created":  SI("{down 4}{enter}")
            default:
            return 
        }
        /*
            If (win11 AND A_OSVersion >= 10.0.22000) {
                AA("explorer.exe"),
                SI("{alt}{right}{enter}",100),
                switch category
                {
                    case "name":          SI("{enter}")
                    case "date modified": SI("{down}{enter}")
                    case "file type":     SI("{down 2}{enter}")
                    case "size":          SI("{down 3}{right}{enter}")
                    case "date created":  SI("{down 3}{right}{down}{enter}")
                    default:
                    return 
                }
            } else {
            }
        */
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

        if InStr(path, "_path") ; "_path" string match indicates a config.ini path reference                                         
            path := GC(path)

        SplitPath, path, oFileName, oDir, oExtension, oNameNoExt, oDrive

        ; if (sys_dependent = TRUE) {
        ;     path := GC(path, "")
        ; } 
        
        if oExtension {
            EF(path)
        } if !oExtension {
            if WinActive("ahk_exe explorer.exe") and WinActive("ahk_class CabinetWClass")
            {
                NavRun(path)
            }
            else ; WinActive("ahk_class #32770") = class for "save" dialogue boxes                                                             
            {
                changeDialDir(path)
            }
        }
        return
    }

    changeDialDir(path) {
        ; change directory of "save as" dialogue box                                ; https://www.reddit.com/r/AutoHotkey/comments/ce8mu3/changing_folders_in_save_as_dialogue_with_com/                       
        WinGet, hWnd, ID, A ; Get handle of active window
        Sendinput ^l
        winget, Pname, ProcessName, A 
        ; app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
        switch Pname {
            case "excel.exe" : edit := "Edit3" 
            default: edit := "Edit2"
        }
        ControlSetText, %edit%, %path%, ahk_id %hWnd%
        ControlSend, %edit%, {Enter}, ahk_id %hWnd%
        ; ControlSetText, Edit2, %path%, ahk_id %hWnd%
        ; ControlSend, Edit2, {Enter}, ahk_id %hWnd%
    }

    GetActiveExplorer() {
        ; get file explorer window ID
        static objShell := ComObjCreate("Shell.Application")
        WinHWND := WinActive("A") ; Active window                                             
        for Item in objShell.Windows
            if (Item.HWND = WinHWND)
                return Item
        return -1 ; No explorer windows match active window
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

    UpdateCBsfx() {
        global exe, C, CB_hwnd, tgt_hwnd
        sleep 50
        tgt_hwnd := WinExist("A")
        WinGet, Process_Name, ProcessName, A
        if (Process_Name != GC("CB_tgtExe")) AND WinExist("ahk_id " CB_hwnd) {

            switch Process_Name
            {
                case exe["editor"], "Code.exe": sfx := "~code", clr := "CFE2CF"       ; RegExReplace(GC("editor_path"), "\\?([A-Za-z0-9\.]+)$","$1") 
                case exe["html"], "msedge.exe","chrome.exe": sfx := "~html", clr := "F6E1E0"
                case exe["pdf"], "PDFXEdit.exe", "acrord32.exe": sfx := "~pdf", clr := "FFCCCB"
                case exe["xls"], "excel.exe": sfx := "~xls",  clr := C.lgreen
                case exe["doc"], "winword.exe": sfx := "~doc",  clr := C.dblue, t_clr := C.white
                case exe["ppt"]: sfx := "~ppt",  clr := C.Lorange, t_clr := C.white
                case "Explorer.exe": 
                    WinGetClass, class_n, A
                    if (class_n == "CabinetWClass") 
                        sfx := "~fe", clr := "FCE28A"
                    else 
                        sfx := "~win",  clr := C.white
                case "obsidian.exe": sfx := "~o", clr := C.lpurple
                case "AutoHotkey.exe": return
                ; case "qbittorrent.exe":  sfx := "~trnt",  clr := C.Cornsilk  ;, t_clr := C.white
                ; case "i_view32.exe":     sfx := "~ivw",  clr := C.Lcoral ;, t_clr := C.white
                default:
                    sfx := "~win",  clr := C.white ;, t_clr := C.white
                    ; sfx := "~win",  clr := "F6F7F1"
            }

            CC("CB_tgtExe",Process_Name)
            CC("CB_clr",clr)
            CC("CBt_color",t_clr)
            CC("CB_sfx",sfx)
            
            GuiMinState := DllCall("IsIconic", "Ptr", CB_hwnd, "UInt") ; GUI minimized = 1
            
            if (sfx != "~win") ;AND !GuiMinState
                UpdateGUI()
            
            ActivateWin("ahk_id " tgt_hwnd)

        }
    }

    AA(app_path = "", arguments = "", optn = False, start_folder_toggle = False) {
        global med
        ActivateApp(app_path,arguments,optn,start_folder_toggle)
        UpdateCBsfx()
        ; if !WinActive("ahk_exe " GC("CB_tgtExe"))
        ; ActivateApp(app_path) ; AA() = infinite loop
        CFW(,200,250)
        ;sendinput {lwin up}

    }

    ActivateApp(app_path = "", arguments = "", optn = False, start_folder_toggle = False) {
        ; wrapper for ActivateOrOpen to process ini file path references
        ; and arguments
        ; sleep, 100
        keywait, lwin
        global config_path, short, med, long
        if InStr(app_path , "_path") ; "_path" string match indicates a config.ini path reference                                         
        {
            ini_app_path := GC(app_path)
            RegExMatch(ini_app_path, "[^\\]+$", exe_name) ; file_name = everyting after the last \ 
            ActivateOrOpen(exe_name, ini_app_path, arguments)
        }
        else if app_path in cmd.exe,explorer.exe
        {
            if InStr(arguments , "_path") {
                IniRead, arguments, %config_path%, %A_ComputerName%, %arguments%
            }
            ActivateOrOpen(app_path,,arguments, start_folder_toggle) ; only compatible options are file explorer or command window 
        }
        else if (optn == 1)
        {
            SetTitleMatchMode, 2 ; match anywhere in title
            IfWinExist, %app_path%
                WinActivate, %app_path%
        }
        else if (optn == 2)
        {
            SetTitleMatchMode, 2 ; match anywhere in title
            If WinExist("ahk_exe " arguments) {
                WinActivate
            } else {
                Run, %app_path%
                ; RunAsUser(app_path, arguments, A_ScriptDir)
            }
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
            ? "ahk_class CabinetWClass ahk_exe " exe_name ; after start folder first opening, make #b key activate last explorer window               
            : win_title " ahk_class CabinetWClass ahk_exe " exe_name
        } else {
            grp_ID := "ahk_exe " exe_name
            ; grp_ID := arguments "ahk_exe " exe_name
        }

        WinGet, wList, List, %grp_ID%,,% ((grp_ID = "ahk_exe chrome.exe") ? "Tabs Outliner" : "") ; exclude tabs outliner tab management window if app is chrome

        if !wList 
        {
            app_path := (exe_name = "explorer.exe" or exe_name = "cmd.exe") ? exe_name : app_path ; cmd.exe and explorer.exe do not need filepaths
            try {
                RunAsUser(app_path, arguments, A_ScriptDir)
            }

        } else {
            WinActivate, % "ahk_id " wList1
        }
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
        RegExMatch(file_path, "[^\\]+$", file_name) ; file_name = everyting after the last \
        file_name := rtrim(file_name,"""")
        RegExMatch(file_name, "[^.]+$", ext) ; ext = everything after the last .
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
            MsgBox, % "Can't open — unrecognized filetype " . e
        }
        return
    }

    EF(file_path = "master.ahk", app_path = "editor_path") {
        EditFile(file_path,app_path)
        return
    }

    OpenFolder(folder_path = "") {
        global short, long
        ; WinGet, hWnd, ID, A 
        ; WinGet, Process_Name, ProcessName, A
        ; msgbox % Process_Name
        sleep, 100
        try {
            CF(folder_path)
        } catch e {
            try 
                RunAsUser("explorer.exe", folder_path, A_ScriptDir)
            catch
                Run, % winpath "\explorer.exe " folder_path
        
        }
        return
    } 

    OpenFolderBU(folder_path = "") {
        global short, long
        ; WinGet, hWnd, ID, A 
        ; WinGet, Process_Name, ProcessName, A
        ; msgbox % Process_Name
        
        if WinActive("ahk_group FileListers") {
            CF(folder_path)
        } else if WinExist("ahk_exe Explorer.EXE") { 
            AA("explorer.exe") 
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

    VidDLFile(DL_pth="", List_pth="") {
        Run cmd.exe /K "cd /d " %DL_pth%
        sleep 300
        clip("yt-dlp --no-check-certificate --verbose -c -i --download-archive " """" DL_pth "YTDL_Log.txt""" " --batch-file=" List_pth)
        sleep 300
        send {enter}
    }

    URLvidDL(path="",source = "altD") {
        global short, med
        sleep, med
        keywait()
        ; BlockInput, on
        settimer, BlockInputTimeOut,-1000
        ; If WinActive("ahk_group browsers")
        if (source = "altD")
            Send !d
        url := (source = "CB") ? Clipboard : clip()
        sleep med
        if (SubStr(url, 1,4) = "http") {
            ; code := "youtube-dl " """" url """" 
            ; code := "youtube-dl --no-check-certificate " """" url """"
            code := "yt-dlp --no-check-certificate " """" url """"
            switch := RegExMatch(path,"^[A-Z]+") ? "cd /d " : "pushd "
            Run cmd /K %switch%%path% 
            sleep med
            clip(code)
            Send {enter}
            sleep short
            ;WinMinimize,A
        } else 
            PU("invalid url: " clipboard,,,,,-1000)
        ; BlockInput, Off
        return
    }

    ClickVidDL(path="",ListNum=0){

        global short, med, CB_hwnd
        sleep, med
        keywait()
        ;BlockInput, on
        ;settimer, BlockInputTimeOut,-1500
        Click, Right
        sleep, med * 2
        winget, Pname, ProcessName, A 
        app := WinExist("ahk_id " CB_hwnd) ? GC("CB_tgtExe") : Pname
        switch app {
            case "msedge.exe" : Sendinput % "{down " GC("click_DL", 4) "}{enter}"
            case "chrome.exe" : Send e
            case "vivaldi.exe": Send e
            default: Send e
        }
        sleep med 
        if !InStr(FileExist(path), "D") and !ListNum {
            msg := "WinGolems can't find the folder`n`n" . dir . "`n`nWould you like to create it?"
            MsgBox,4100,Create Hotstring,%msg% 
            IfMsgBox Yes
                FileCreateDir, %path%
            return
        } 
        if (SubStr(clipboard, 1,4) = "http") && !ListNum {
            code := "yt-dlp --no-check-certificate " """" clipboard """" 
            switch := RegExMatch(path,"^[A-Z]+") ? "cd /d " : "pushd "
            Run, cmd /K %switch%%path% 
            sleep med * 2
            clip(code)
            Send {enter}
            sleep short
            WinMinimize,A
        } else if (SubStr(clipboard, 1,4) = "http") && ListNum {
            Log("`n" clipboard,ListNum,1)
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
            Run, cmd /K "cd /d " %path% 
            sleep med * 2
            clip(code)
        } else 
            PU("invalid url: " clipboard,,,,,-800)
        BlockInput, Off
        return

    }

; MOUSE FUNCTIONS ______________________________________________________________

    resetMousPos(key="") {
        DC("MPos_" CurrentDesktopNum() "_" key)
        PU("Click reset") 
        return
    } ;MouseFn: erase saved curor position

    SaveMousPos(key = "A", n = "0") {
        global config_path
        CoordMode, Mouse, window ;default
        ; CoordMode, Mouse, client
        ; CoordMode, Mouse, Screen

        loop % n
            click

        MouseGetPos, StartX, StartY
        WinGetPos, winX, winY, winWidth, winHeight, A
        ;Msgbox % "`nStartX: " . StartX . "`nStartY: " . StartY . "`nwinWidth: " . winWidth . "`nwinHeight: " . winHeight . "`nwinX: " . winX . "`nwinY: " . winY
        vde := CurrentDesktopNum() ; virtual desktop environment 
        IniWrite,%StartX% %StartY% %winWidth% %winHeight% %winX% %winY%
        ,%config_path%,%A_ComputerName%,MPos_%vde%_%Key%

        PU("MPos_" vde "_" Key " saved")

        return
    }

    CursorRecall(key = "A", n = "1", lrm = "l", rtn_mouse = False, H=False, msg = 0) {
        global config_path, short
        CoordMode, Mouse, window ;default
        ; CoordMode, Mouse, client
        ; CoordMode, Mouse, Screen
        vde := CurrentDesktopNum()
        if (GC("MPos_" vde "_" Key)) {
            KeyWait()
            MouseGetPos, StartX, StartY
            vde := CurrentDesktopNum()
            IniRead, mpos, %config_path%, %A_ComputerName%, MPos_%vde%_%Key%
            pos_array := StrSplit(mpos, " ")
            ; DllCall("SetCursorPos", int, pos_array[1], int, pos_array[2]) 

            mouseX_O := pos_array[1]
            mouseY_O := pos_array[2]
            winW_O := pos_array[3]
            winH_O := pos_array[4]

            WinGetPos, winX_tgt, winY_tgt, winW_tgt, winH_tgt, A

            MouseX_tgt := mouseX_O
            MouseY_tgt := mouseY_O

            if (mouseX_O > winW_O/2) 
            MouseX_tgt := winW_tgt - (winW_O - mouseX_O)

            if (mouseY_O > winH_O/2)
            MouseY_tgt := winH_tgt - (winH_O - mouseY_O)

            if (H) { 
                MouseY_tgt := StartY ; don't change current vertical position of cursor upon recall                                             
                ; pos_array[2] := StartY
            }

            MouseMove, MouseX_tgt, MouseY_tgt
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
        return
    }

    W(keys*) {
        loop % keys.MaxIndex() 
        {
            switch keys[A_index]
            {
                case "alt","a":
                    KeyWait, alt
                case "esc","e":
                    KeyWait, esc
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
                case "lwin","lw","w":
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
        Sendinput {click %num% %lrm%}
        ; click, %num% %lrm%
        BlockInput, off
        return
    }

    CursorJump(Q = "center", offset_x = 0, offset_y = 0, ScreenDim = 0) {
        ; move mouse cursor to the middle of active window
        global short
        Sleep, short 
        ; BlockInput, Mousemove
        settimer, BlockInputTimeOut,-600
        CoordMode, Mouse, window  ;usual  ; defines coordinates relative to active screen for multimonitor support
        if ScreenDim {
            winTopL_x := 0, winTopL_y := 0, width := A_ScreenWidth, height := A_ScreenHeight
        } else {
            ; MouseGetPos , , , OutputVarWin
            WinGetPos, winTopL_x, winTopL_y, width, height, A
            ; MI := StrSplit(GetMonInfo()," ")                                            ; get monitor dimensions
            ; d := "x" MI[3] // 2 " y0 w" MI[3] // 2 " h" MI[4] // 2  
            ; msgbox % GetMonInfo() "`n x:" winTopL_x " y" winTopL_y " w:" width " h:" height
            ; WinGetPos(WinExist("A"), x, y, w, h, 0)
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
        ; BlockInput, MousemoveOff
        return
    }


; BROWSERS _____________________________________________________________________
    
    setRightClickMenuChoice() {
        ;used in other functions as a fix for when right-click menu changes 
        ;depending on context and plugins

        PU("Enter menu option number",C.pink,,,,100000)
        Moption :=  KeyWaitHook("L1 M",escape)
        Gui, PopUp: cancel
        if Moption ~= "[0-9]"
            CC("click_DL", Moption), PU(Moption,C.lgreen)    
        Else
            PU("Must be a number input", C.pink)   
    } ;sets right click menu choice used in other functions 

    EncodeDecodeURI(str, encode := true, component := true) {
        Static Doc, JS
        str := RegExReplace(str, "\R++(?<!\n\n|\r\n\r\n)"," ")
        If !Doc
            Doc := ComObjCreate("htmlfile"), Doc.write("<meta http-equiv=""X-UA-Compatible"" content=""IE=9"">")
            , JS := Doc.parentWindow       , (Doc.documentMode < 9 && JS.execScript())
        Return JS[(encode ? "en" : "de") "codeURI" (component ? "Component" : "")](str)
    } ;converts raw text string into valid URI or vice versa

    CheckIncogWinID() {

        ; winID := WinExist("A")
        WinGet, winID, ID ,ahk_exe chrome.exe
        SavedIDs := GC("IncogWinID","")
        ARR := StrSplit(SavedIDs, ",")
        loop % ARR.MaxIndex() {
            if (ARR[A_index] = winID) 
                return 1
        }

    } ;check if active window is a chrome incognito window

    SaveIncogWinID() {
        sleep, 300
        NewID := WinExist("A")
        GC("IncogWinID","") := SavedIDs
        if SavedIDs
            SavedIDs .= "," . WinExist("A")
        else 
            SavedIDs := WinExist("A")
        CC("IncogWinID", SavedIDs)
    } ;save window ID of chrome incognito window

    LURLotherBrowser(close = 1, i = 0) {
        global short
        
        winget, Pname, ProcessName, A
        URL := GetURL("Ahk_exe " Pname) 

                
        WinGetTitle, title, ahk_exe msedge.exe   ; active msedge window title
        i := instr(title,"[InPrivate]") ? 1 : i  
        
        sleep, 100

        if close 
            Sendinput ^w 
        
        sleep, 300

        switch Pname
        {
            case "msedge.exe": LURL(URL,i,"chrome.exe")
            case "chrome.exe": LURL(URL,i,"msedge.exe")
        }

        ; ActivateApp(Pname)
        ; 1Format_Line()SetTimer, CFW, -200
        return 
    } 

    LURL(URL, i = false, browser = "") {
        ; Browser path used to load urls dependent on computer
        global config_path, PF_x86, short
        
        WinGetTitle, title, ahk_exe msedge.exe   ; active msedge window title
        i := (instr(title,"[InPrivate]") or CheckIncogWinID() or GC("T_x")) ? 1 : i  

        sleep, med
        if browser
            Pname := browser
        else if (WinActive("ahk_exe " GC("html2_path")) or WinActive("ahk_exe " GC("html_path"))) {
            winget, Pname, ProcessName, A 
        } Else {
            pname := RegexReplace(GC("html_path"),"(.*\\)([a-zA-Z0-9]+\.(exe|EXE))$", "$2")
        }
        
        Switch Pname
        {
            case "vivaldi.exe": output := GC("vivaldi_path", GC("html_path")) 
            case "chrome.exe" : output := GC("chrome_path", GC("html_path")) . (i ? " -incognito " : "")
            case "msedge.exe" : output := GC("edge_path", GC("html_path")) . (i ? " -inprivate " : "")
            ; case "firefox.exe": output := GC("firefox_path", GC("html_path"))     ; look into firefox url syntax
            default: output := GC("html_path")
        }
        output := !output ? GC("html_path") : output
        sleep, 100
        Run, %output% "%URL%"
        return
    } ; load URL in web browser (optional: i = toggle incognito mode, browser = processName of desired browser)

    Search(prefix = "google.com/search?q=", var = "", suffix = "", i=false, browser = "") {
        global short, med, C
        keywait()
        sleep, short

        if GC("TCB",0) 
            var := Clipboard ; clipboard
        else 
            var := (!var ? trim(clip()) : var) ; selected text

        sleep, short 
        var := EncodeDecodeURI(var) ;replace special characters
        WinGetActiveTitle, title
        if instr(title,"[InPrivate]")
            i=1
        url := prefix . var . suffix
        sleep, short

        LURL(url,i,browser)
        CursorFollowWin()
        ; PU("Running search",C.lgreen)
        return
    }

    CS(string="",swapDct="",RegexNeedle="", replacement="") {

        if (RegexNeedle AND replacement) { ; regex pattern
            string := RegExReplace(string, RegexNeedle, replacement) 
        } else if (RegexNeedle AND !replacement) { ; remove characters from word
            string := RegExReplace(string, RegexNeedle)
        } 

        if swapDct {
            For what,with in swapDct 
                string := StrReplace(string,what,with)
        }
        return % string

    } ; Clean String (for search)

    OpenGoogleDrive(num) {
        ; Function for opening different google drive folders
        global config_path
        LURL("https://drive.google.com/drive/my-drive",1)                ; icognito to avoid signing out of google account              
        
        MsgBox,4100, Accessing Google Drive, Enter login?
        IfMsgBox Yes
        {
            AA("html_path")
            sleep, 300
            clip(GC("gd" num "_login",,"PASSWORDS")),S("{enter}")
        }
        else 
            return
        
        sleep, 1000
        
        MsgBox,4100, Accessing Google Drive, Enter password?
        IfMsgBox Yes
        {
            AA("html_path")
            sleep, 300
            SelectLine(), clip(GC("gd" num "_pwd",,"PASSWORDS")),S("{enter}")
        }
            ; IniRead, output, %config_path%, PASSWORDS, gd%num%_pwd
        else
            return
    }

    tabsOutliner(){ ; Tabs Outliner and pinned webpages
        SetTitleMatchMode, 2
        If WinExist("Tabs Outliner") { 
            WinActivate
        } else {
            AA("chrome_path")
            sleep 100
            Send ^. ; chrome shortcut to activate tabsoutliner
        }
        CFW()
        return
    } ; activate Tabs Outliner 

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

    ObsidianQuickAdd(file_anchor, action = "menu") {
        global short, med, long
        ; sleep, short
        ;selected_text := trim(clip(),"`r`n")
        ;f_path := A_ScriptDir . "\mem_cache\qa.txt"
        ;sleep, short
        ObsidianPath := GC("obsidian_path",UProfile "\AppData\Local\Obsidian\Obsidian.exe") 

        switch action 
        {
            case "menu":
                ; If (strlen(selected_text) > 0) {
                ;     var := clip()
                ; } 
                var := clipboard 
                

                sleep, short
                If WinActive("ahk_group browsers") {

                    winget, Pname, ProcessName, A
                    URL_string := GetURL("Ahk_exe " Pname)
                    sleep, short
                    domain := RegexReplace(URL_string, "`am)^(https?:\/\/)?([A-Za-z0-9\-\.]+)(\/\S.*)?", "$2")
                    sleep, short
                    URL_string := !regexmatch(URL_string,"^https?:\/\/") ? "https://" . URL_string : URL_string       
                    sleep, short
                    url := " | [" domain "](" URL_string ")"
                    var .= url
                }
                If WinExist("ahk_exe Obsidian.exe")
                    AA(ObsidianPath)
                else {
                    AA(ObsidianPath)
                    MsgBox,4100, Opening Obsidian, Has Obsidian finished opening?
                    IfMsgBox Yes
                    {
                        AA(ObsidianPath)
                    } else
                        return
                }
                sleep, med
                Send %file_anchor%
                ; Sendinput %file_anchor%
                sleep, med
                Input, UserInput, V, {enter}{esc} 
                if (ErrorLevel = "Timeout")
                {
                    s("{esc}!{tab}")
                }
                else If InStr(ErrorLevel, "Enter")
                {
                    MsgBox,4100, Obsidian QuickAdd, add text?
                    IfMsgBox Yes 
                    {
                        sleep, med
                        clip(var)
                        sleep, short
                        MsgBox,4100, Obsidian QuickAdd, Finished editing text?
                        IfMsgBox Yes 
                        {
                            Send ^{enter}
                            ; Sendinput !{tab}
                            activateApp("html_path")
                        } else {
                            Send {esc}
                            ; Sendinput !{tab}
                            activateApp("html_path")
                        }
                    } else {
                        s("{esc}")
                        activateApp("html_path")
                    }
                }
                else If InStr(ErrorLevel, "Esc")
                {
                    s("{esc}")
                    activateApp("html_path")
                }
                settimer, CFW,-200

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
                    activateApp("html_path")
                    ; Send !{tab}
                } else {
                    s("{esc}")
                    activateApp("html_path")
                }
                return
            default:
                return
        }
        return
    }   

    OpenInObsidian(FileName,newpane := FALSE) { 

        If WinExist("ahk_exe Obsidian.exe")
            AA("obsidian_path")
        else {
            AA("obsidian_path")
            MsgBox,4100, Opening Obsidian, % "Open " FileName " ?"
            IfMsgBox Yes
                sleep, 0
            else {
                send !{tab}
                return
            }
        } 
        WinGetActiveTitle, title
        FileName := StrReplace(FileName, ".md")
        MDfile := RegExReplace(FileName,"\S+\/([A-Za-z0-9]+)$","$1")
        if (MDfile == substr(title,1,strlen(MDfile))) {
            return
        } else {
            Send ^o                                                             ; hotkey Ctrl+O set in Obsidian to open "QuickSwitcher"
            Sleep 100                                                           ; maybe not needed
            clip(FileName)                                                      ; type in content of variable
            Sleep 100                                                           ; maybe not needed
            Send % (newpane ? "^" : "") "{Enter}"                                                        ; Ctrl+Enter opens in new pane. {Enter} would open in current pane
        }
    } ; OpenInObsidian(FileName) ; opens specified note in Obsidian by simulating keystrokes into "QuickSwitcher"      

; VS CODE ______________________________________________________________________

    FormatAHKcodeBlock(CspaceLen = 80) {
        var := clip()
        whitespace := "( +)?"
        hot_key :=    "(?P<Hotkey>[+#!A-Za-z0-9<>?&`\%\- \[\]\(\);\*$\\\/:\|\._\?=,\^''""``~]+::)"        
        Command :=   "(?P<Command>[+#!A-Za-z0-9<>?&`\%\- \[\]\(\)\{\}\\\/:\|\._\?=,\^''""``\S]+)?"
        Comment :=  "(?P<Comment>;[+#!A-Za-z0-9<>?&`\%\- \[\]\(\)\{\}\\\/:\|\._\?=,\^''""``;\S]*)$" 
        
        hotkeyPattern = ^%whitespace%%hot_key%%whitespace%%Command%%Comment%
        altPattern := "^( *)?(?P<expression>[+#!A-Za-z0-9<>?&`\%\- \[\]\(\)\{\}\*$\\\/:\|\._\?=,\^''""``~]+)( *)?(?P<comment>;[+#!A-Za-z0-9<>?&`\%\- \(\)\{\}\\\/:\|\._\?=,\^""\S]+)?"

        maxHotkeyLen = 0
        maxCommandLen = 0
        IndexLen = 0
        Loop, parse, var, `n, `r
        {
            RegExMatch(A_LoopField, hotkeyPattern, o)
            if (strlen(oHotkey) > 0) {
                IndexLen := max(IndexLen, A_Index)
                maxHotkeyLen := max(maxHotkeyLen,strlen(oHotkey))
                maxCommandLen := max(maxCommandLen,strlen(rtrim(oCommand)))
            } else {
                RegExMatch(A_LoopField, altPattern, o)
                ; msgbox % "`no1: " . o1 . "`n oexpression: " .  oexpression . "`n oComment: " .  oComment
            }
            if (A_Index = 1) {
                frontPadding := strlen(o1)
                ; msgbox % "`nfrontPadding: " . frontPadding 
            }

        }
        formatted := ""
        Loop, parse, var, `n, `r
        {
            RegExMatch(A_LoopField, hotkeyPattern, f)
            if (strlen(fHotkey) > 0) { 
                hotkeyPadding := (maxHotkeyLen - strlen(fHotkey) + 1)  
                fCommand := rtrim(fCommand)
                CommandPadding := (maxCommandLen - strlen(fCommand) + 1) 
                NewPadding := max(0,CspaceLen - (strlen(fHotkey) + strlen(fCommand) + frontPadding + hotkeyPadding + CommandPadding))
                ; if strlen(fComment) = 0
                ; Msgbox % "`nfHotkey: " . fHotkey . "`nfCommand: " . fCommand . "`nfComment: " . fComment
                formatted .= format( "{1:" frontPadding "}{2:}{1:" hotkeyPadding "}{3:}{1:" CommandPadding + NewPadding "}{4:}"," ",fHotkey,fCommand,fComment) . "`n"
            } else {
                RegExMatch(A_LoopField, altPattern, f)
                fexpression := rtrim(fexpression)
                NewPadding := max(0,CspaceLen - (strlen(fexpression) + frontPadding))
                formatted .= format( "{1:" frontPadding "}{2:}{1:" NewPadding "}{3:}"," ",fexpression, fComment) . "`n"
                ; Msgbox % "`nNewPadding: " . NewPadding . "`nfexpression: " . fexpression . "`nfComment: " . fComment
            }
        }
        clip(formatted)
        return

    }
    /*
    
  #If GetKeyState("esc", "P")                                              ;

    */

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
        Send +!^m ; shortcut in vscode for toggling "tab moves focus"
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

    SortSelectedText(order = "") {
        text := Clip()
        sort, text, C %order%
        clip(text)
    }

    LineStr(ByRef S, P, C:="", D:="") { ;  LineStr v0.9d,   by SKAN on D341/D449 @ tiny.cc/linestr
        ; S = Source Text
        ; P = Starting line
        ; C = Line count
        ; D = Delimiter
        Local L := StrLen(S), DL := StrLen(D:=(D ? D : Instr(S,"`r`n") ? "`r`n" : "`n") ), F, P1, P2
        Return SubStr(S,(P1:=L?(P!=1&&InStr(S,D,,0))?(F:=InStr(S,D,,P>0,Abs(P-1)))?F+DL:P-1<1?1:0:(F:=1)
        :0),(P2:=(P1&&C!=0)?C!=""?(F:=InStr(S,D,,(C>0?F+DL:0),Abs(C)))?F-1:C>0?L:1:L:0)>=P1?P2-P1+1:0)
    } ; extract lines from variable

    addtoCB(AP="A", text_to_add="") {
        global short, med, long, CB_hwnd, C
        WinID := WinExist("A")
        var := clipboard ; [stability] placeholder var allows usage of clipwait errorLevel
        clipboard := "" 

        text_to_add := !text_to_add ? rtrim(clip()," `t`n`r") : text_to_add

        % (AP == "A") 
        ? (var .= "`n" text_to_add) 
        : (var := text_to_add "`n" var) 

        clipboard := var
        clipwait 
        sleep, 200
        while (ErrorLevel)
            sleep 10 

        if WinExist("ahk_id " CB_hwnd) { 
            UpdateDisplay()
        }

        % (AP == "A") 
        ? PU("Appended",C.Lgreen)
        : PU("Prepended",C.Lpurple) 

        ActivateWin("ahk_id " WinID)
    } ; append or prepend text to windows clipboard

    UpdateDisplay() {
        global CB_hwnd, short, med, long
        WinID := WinExist("A")

        sleep, short
        ; while (ErrorLevel)
        ;     sleep 10
        
        switch % GC("CB_last_display") 
        {
            case "First lines of 0-9.txt" : UpdateGUI(See1stLines(,"^[0-9]\.txt",,GC("MemSummaryLines", 1)), "First lines of 0-9.txt") 
            case "First lines of 1 character files": UpdateGUI(See1stLines(,"^[0-9a-zA-Z]\.txt",,GC("MemSummaryLines", 1)), "First lines of 1 character files") 
            case "1.txt","2.txt","3.txt","4.txt","5.txt","6.txt","7.txt","8.txt","9.txt","0.txt":
                UpdateGUI(AccessCache(GC("CB_last_display"),,0), GC("CB_last_display"))
            case "Clipboard Contents" : UpdateGUI(clipboard, "Clipboard Contents")
            default:
                sleep,0
        }
        if (WinID != CB_hwnd) {
            ActivateApp(GC("CB_tgtExe"))
        }


        /*
            if (WinExist("ahk_id " CB_hwnd) or GC("CB_persistent",0)) 
            && (instr(GC("CB_last_display"), "First lines of ")
                OR GC("CB_last_display") = "Clipboard Contents"
                OR RegexMatch(GC("CB_last_display"),"\d\.txt")) {
                switch % GC("CB_last_display") 
                {
                    case "First lines of 0-9.txt" : UpdateGUI(See1stLines(,"^[0-9]\.txt",,GC("MemSummaryLines", 1)), "First lines of 0-9.txt") 
                    case "First lines of 1 character files": UpdateGUI(See1stLines(,"^[0-9a-zA-Z]\.txt",,GC("MemSummaryLines", 1)), "First lines of 1 character files") 
                    case "1.txt","2.txt","3.txt","4.txt","5.txt","6.txt","7.txt","8.txt","9.txt","0.txt":
                        UpdateGUI(AccessCache(GC("CB_last_display"),,0), GC("CB_last_display"))
                    case "Clipboard Contents" : UpdateGUI(clipboard, "Clipboard Contents")
                    default:
                        sleep,0
                }

                if (WinID != CB_hwnd) {
                    ActivateApp(GC("CB_tgtExe"))
                }

            } 
        */
        
        
        
        ; PU("copied")
    }

    sortArray(arr,options="") { 
        ; specify only "Flip" in the options to reverse otherwise unordered array items
        ; https://autohotkey.com/board/topic/93570-sortarray/

        if !IsObject(arr)
            return 0
        new := []
        if (options="Flip") {
            While (i := arr.MaxIndex()-A_Index+1)
                new.Insert(arr[i])
            return new
        }
        For each, item in arr
            list .= item "`n"
        list := Trim(list,"`n")
        Sort, list, %options%
        Loop, parse, list, `n, `r
            new.Insert(A_LoopField)
        return new

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
        SendInput {End}
        SendInput +{Home}
        If get_SelectedText() = "" {
            ; On an empty line.
            SendInput {Delete}
        } Else {
            SendInput ^+{Left}
            SendInput {Delete}
        }
    }

    get_SelectedText() {

        ; See if selection can be captured without using the clipboard.
        WinActive("A")
        ControlGetFocus ctrl
        ControlGet selectedText, Selected,, %ctrl%

        ;If not, use the clipboard as a fallback.
        If (selectedText = "") {
            originalClipboard := ClipboardAll ; Store current clipboard.
            Clipboard := ""
            SendInput ^c
            ClipWait .2
            selectedText := ClipBoard
            ClipBoard := originalClipboard
        }

        Return selectedText
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
        If !var ; selects text to the left of cursor (if no text selected)
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

    FormatCodeBU() {
        ; Adds formatting for math operators and code syntax
        var := clip()
        If !var ; selects text to the left of cursor (if no text selected)
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
        Unwrapped := RegExReplace(Clipboard, "(\S.*?)\R(.*?\S)", "$1 $2") ; strip single line breaks + replace with single space
        Unwrapped := RegExReplace(Unwrapped, "(?<!<)-\s", "$1") ; Join words split by hyphen on line break
        Unwrapped := RegExReplace(Unwrapped, "[0-9]+:[0-9]+") ; replace time stamps
        Unwrapped := RegExReplace(Unwrapped, "\S\s\K\s+(?=\S)") ; replace multiple consecutive spaces with single space
        clipboard := Unwrapped
        ClipWait
        Send ^v
        return
    }

    RemoveBlankLines(reselect=False, input="") {
        ; Removes blank lines within a block of selected text
        ; BlockInput, on
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

        ; BlockInput, Off
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
            num_char := (StrLen(char) < length) 
            ? (length - StrLen(var))/StrLen(char) 
            : StrLen(char)
            string_char := RepeatString(char, num_char - buffer) ; -1 to account for 1 space after the heading string
            output := var . ((buffer) ? A_space : "") . string_char
            output := substr(output, 1, length)
            sleep 300
            if out
                return % output
            else
                clip(output)
            ; BlockInput, Off
        }
        ; return
    }

    AddSpaceBeforeComment(length = "", char = " ", lines = 1) {
        global short,med,long 
        Send {space}{left}+{end} ; fixes issue in vscode where ^x on empty selection will cut the whole line
        end_txt := Trim(clip())
        Send {del}
        sleep, short
        Send {home 2}+{end} 
        ls_beg_txt := clip()
        sleep, short
        send {right}
        sleep, short
        w := length - strlen(ls_beg_txt)
        clip(Format("{:" w "}{:}"," ",end_txt))
        sleep, short
        Sendinput % "{left " (strlen(end_txt)) "}"
        return 
    }

  ; test -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

    AddBorder(length = "80", char = "_", prefix = "" ) {
        ; Add line border to separate code sections
        WinID := WinExist("A")
        Send {home}
        if (prefix) {
            Sendraw %prefix%
            Send {space}
        }
        Send {home}
        Send {home}{shift down}{end}{shift up}
        FillChar(length, char,,,1)
        ActivateWin("ahk_id " WinID)
        ;return
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
        ; var := RegExReplace(var, "\R", " ") ; strip single line breaks + replace with single space
        var := RegExReplace(var, "(\S.*?)\R(.*?\S)", "$1 $2") ; strip single line breaks + replace with single space
        var := NoParagraphs ? RegExReplace(var, "\R", A_space) : var ; replace paragraph breaks with space
        var := RegExReplace(var, "S) +", A_Space) ; replace multiple spaces with single space
        var := RegExReplace(var, "(?<!<)-\s", "$1") ; <= remove "-" if not preceded by < ("<-")
        if !input {
            sleep, long * 0.8
            clipboard := var
            Send ^v ;    for stitching words back together if split by
        } 
        return % var
    }

    FormatBreaks(mode = "no break", input = "") {
        ; Format clipboard contents: remove double spaces and line breaks
        ; while keeping the empty lines between paragraphs
        global long
        var := (input) ? input : Clipboard
        Switch mode 
        {
            case "no break":                                                    ; replace each line break with single space
                var := RegExReplace(var, "\R", A_space)                         
                var := RegExReplace(var, "(?<!<)-\s", "$1")                     ; <= remove "-" if not preceded by < ("<-")
                                                                                
            case "1 break": 
                var := RegExReplace(RegExReplace(var, "m)^\h+$"), "\n\v+", "`n`n")
            default:
                sleep, 0
        }
        var := RegExReplace(var, "S) +", A_Space)                               ; replace multiple spaces with single space
        
                                                                                
        if !input {
            sleep, long * 0.8
            clipboard := var
            Send ^v ;    for stitching words back together if split by
        } 
        return % var
    }

    SelectLine() {
        Sendinput {home}{shift down}{end}{shift up}
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
        ; BlockInput, on
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
        ; BlockInput, Off
        return
    }

    removeHtmlTags() {
        ; remove html tags from selected text
        BlockInput, on
        settimer, BlockInputTimeOut,-600
        cl := clip()
        LR:=RegExReplace( cl, "<.*?>","`r`n" )
        stringreplace,lr,lr,|`r`n,,all
        Loop ; remove empty lines
        {
            StringReplace,lr,lr, `r`n`r`n, , UseErrorLevel
            if ErrorLevel = 0
                break
        }
        clip(lr)
        BlockInput, Off
        return
    } 

    ; OCR (VIS2.1)__________________________________________________________________
    ; OCR (UWP)_____________________________________________________________________
    ; https://www.autohotkey.com/boards/viewtopic.php?t=72674  

        OCRtoClipboard(mode = "", Type = "UWP") { 
        switch Type
        {
            case "UWP":
                UWP:
                Try 
                {
                    hBitmap := HBitmapFromScreen(GetArea()*)
                    pIRandomAccessStream := HBitmapToRandomAccessStream(hBitmap)
                    DllCall("DeleteObject", "Ptr", hBitmap)
                    if (mode = "A") {
                        addtoCB("A",OCR_UWP(pIRandomAccessStream, "en"))
                    } else {
                        Clipboard := OCR_UWP(pIRandomAccessStream, "en")
                    }
                    global short, med
                    sleep, med
                    UpdateDisplay()
                    Return
                } catch e {
                    PU("error, try again")
                }
            Case "V2":
            
                Try 
                {
                    if (mode = "A") {
                        buffer := clipboard
                        OCR()
                        addtoCB("P",buffer)
                    } else {
                        OCR()
                    }
                } catch e {
                    PU("error, try again")
                }

            Default: 
                goto, UWP
        }
    }
    GetArea() {
        area := []
        StartSelection(area)
        while !area.w
            Sleep, 100
        Return area
    }
    
    StartSelection(area) {
        handler := Func("Select").Bind(area)
        Hotkey, LButton, % handler, On
        ReplaceSystemCursors("IDC_CROSS")
    }

    Select(area) {
        static hGui := CreateSelectionGui()
        Hook := new WindowsHook(WH_MOUSE_LL := 14, "LowLevelMouseProc", hGui)
        Loop {
            KeyWait, LButton
            WinGetPos, X, Y, W, H, ahk_id %hGui%
        } until w > 0
        ReplaceSystemCursors("")
        Hotkey, LButton, Off
        Hook := ""
        Gui, %hGui%:Show, Hide
        for k, v in ["x", "y", "w", "h"]
            area[v] := %v%
    }

    ReplaceSystemCursors(IDC = "") {
        static IMAGE_CURSOR := 2, SPI_SETCURSORS := 0x57
                , exitFunc := Func("ReplaceSystemCursors").Bind("")
                , SysCursors := { IDC_APPSTARTING: 32650
                                , IDC_ARROW      : 32512
                                , IDC_CROSS      : 32515
                                , IDC_HAND       : 32649
                                , IDC_HELP       : 32651
                                , IDC_IBEAM      : 32513
                                , IDC_NO         : 32648
                                , IDC_SIZEALL    : 32646
                                , IDC_SIZENESW   : 32643
                                , IDC_SIZENWSE   : 32642
                                , IDC_SIZEWE     : 32644
                                , IDC_SIZENS     : 32645 
                                , IDC_UPARROW    : 32516
                                , IDC_WAIT       : 32514 }
        if !IDC {
            DllCall("SystemParametersInfo", UInt, SPI_SETCURSORS, UInt, 0, UInt, 0, UInt, 0)
            OnExit(exitFunc, 0)
        }
        else  {
            hCursor := DllCall("LoadCursor", Ptr, 0, UInt, SysCursors[IDC], Ptr)
            for k, v in SysCursors  {
                hCopy := DllCall("CopyImage", Ptr, hCursor, UInt, IMAGE_CURSOR, Int, 0, Int, 0, UInt, 0, Ptr)
                DllCall("SetSystemCursor", Ptr, hCopy, UInt, v)
            }
            OnExit(exitFunc)
        }
    }

    CreateSelectionGui() {
        Gui, New, +hwndhGui +Alwaysontop -Caption +LastFound +ToolWindow +E0x20 -DPIScale
        WinSet, Transparent, 130
        Gui, Color, FFC800
        Return hGui
    }

    LowLevelMouseProc(nCode, wParam, lParam) {
        static WM_MOUSEMOVE := 0x200, WM_LBUTTONUP := 0x202
                , coords := [], startMouseX, startMouseY, hGui
                , timer := Func("LowLevelMouseProc").Bind("timer", "", "")
        
        if (nCode = "timer") {
            while coords[1] {
                point := coords.RemoveAt(1)
                mouseX := point[1], mouseY := point[2]
                x := startMouseX < mouseX ? startMouseX : mouseX
                y := startMouseY < mouseY ? startMouseY : mouseY
                w := Abs(mouseX - startMouseX)
                h := Abs(mouseY - startMouseY)
                try Gui, %hGUi%: Show, x%x% y%y% w%w% h%h% NA
            }
        }
        else {
            (!hGui && hGui := A_EventInfo)
            if (wParam = WM_LBUTTONUP)
                startMouseX := startMouseY := ""
            if (wParam = WM_MOUSEMOVE)  {
                mouseX := NumGet(lParam + 0, "Int")
                mouseY := NumGet(lParam + 4, "Int")
                if (startMouseX = "") {
                    startMouseX := mouseX
                    startMouseY := mouseY
                }
                coords.Push([mouseX, mouseY])
                SetTimer, % timer, -10
            }
            Return DllCall("CallNextHookEx", Ptr, 0, Int, nCode, UInt, wParam, Ptr, lParam)
        }
    }

    class WindowsHook {
        __New(type, callback, eventInfo := "", isGlobal := true) {
            this.callbackPtr := RegisterCallback(callback, "Fast", 3, eventInfo)
            this.hHook := DllCall("SetWindowsHookEx", "Int", type, "Ptr", this.callbackPtr
                                                    , "Ptr", !isGlobal ? 0 : DllCall("GetModuleHandle", "UInt", 0, "Ptr")
                                                    , "UInt", isGlobal ? 0 : DllCall("GetCurrentThreadId"), "Ptr")
        }
        __Delete() {
            DllCall("UnhookWindowsHookEx", "Ptr", this.hHook)
            DllCall("GlobalFree", "Ptr", this.callBackPtr, "Ptr")
        }
    }

    HBitmapFromScreen(X, Y, W, H) {
        HDC := DllCall("GetDC", "Ptr", 0, "UPtr")
        HBM := DllCall("CreateCompatibleBitmap", "Ptr", HDC, "Int", W, "Int", H, "UPtr")
        PDC := DllCall("CreateCompatibleDC", "Ptr", HDC, "UPtr")
        DllCall("SelectObject", "Ptr", PDC, "Ptr", HBM)
        DllCall("BitBlt", "Ptr", PDC, "Int", 0, "Int", 0, "Int", W, "Int", H
                        , "Ptr", HDC, "Int", X, "Int", Y, "UInt", 0x00CC0020)
        DllCall("DeleteDC", "Ptr", PDC)
        DllCall("ReleaseDC", "Ptr", 0, "Ptr", HDC)
        Return HBM
    }

    HBitmapToRandomAccessStream(hBitmap) {
        static IID_IRandomAccessStream := "{905A0FE1-BC53-11DF-8C49-001E4FC686DA}"
                , IID_IPicture            := "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
                , PICTYPE_BITMAP := 1
                , BSOS_DEFAULT   := 0
                
        DllCall("Ole32\CreateStreamOnHGlobal", "Ptr", 0, "UInt", true, "PtrP", pIStream, "UInt")
        
        VarSetCapacity(PICTDESC, sz := 8 + A_PtrSize*2, 0)
        NumPut(sz, PICTDESC)
        NumPut(PICTYPE_BITMAP, PICTDESC, 4)
        NumPut(hBitmap, PICTDESC, 8)
        riid := CLSIDFromString(IID_IPicture, GUID1)
        DllCall("OleAut32\OleCreatePictureIndirect", "Ptr", &PICTDESC, "Ptr", riid, "UInt", false, "PtrP", pIPicture, "UInt")
        ; IPicture::SaveAsFile
        DllCall(NumGet(NumGet(pIPicture+0) + A_PtrSize*15), "Ptr", pIPicture, "Ptr", pIStream, "UInt", true, "UIntP", size, "UInt")
        riid := CLSIDFromString(IID_IRandomAccessStream, GUID2)
        DllCall("ShCore\CreateRandomAccessStreamOverStream", "Ptr", pIStream, "UInt", BSOS_DEFAULT, "Ptr", riid, "PtrP", pIRandomAccessStream, "UInt")
        ObjRelease(pIPicture)
        ObjRelease(pIStream)
        Return pIRandomAccessStream
    }

    CLSIDFromString(IID, ByRef CLSID) {
        VarSetCapacity(CLSID, 16, 0)
        if res := DllCall("ole32\CLSIDFromString", "WStr", IID, "Ptr", &CLSID, "UInt")
            throw Exception("CLSIDFromString failed. Error: " . Format("{:#x}", res))
        Return &CLSID
    }

    OCR_UWP(file, lang := "FirstFromAvailableLanguages") {
        static OcrEngineStatics, OcrEngine, MaxDimension, LanguageFactory, Language, CurrentLanguage, BitmapDecoderStatics, GlobalizationPreferencesStatics
        if (OcrEngineStatics = "")
        {
            CreateClass("Windows.Globalization.Language", ILanguageFactory := "{9B0252AC-0C27-44F8-B792-9793FB66C63E}", LanguageFactory)
            CreateClass("Windows.Graphics.Imaging.BitmapDecoder", IBitmapDecoderStatics := "{438CCB26-BCEF-4E95-BAD6-23A822E58D01}", BitmapDecoderStatics)
            CreateClass("Windows.Media.Ocr.OcrEngine", IOcrEngineStatics := "{5BFFA85A-3384-3540-9940-699120D428A8}", OcrEngineStatics)
            DllCall(NumGet(NumGet(OcrEngineStatics+0)+6*A_PtrSize), "ptr", OcrEngineStatics, "uint*", MaxDimension)   ; MaxImageDimension
        }
        if (file = "ShowAvailableLanguages")
        {
            if (GlobalizationPreferencesStatics = "")
                CreateClass("Windows.System.UserProfile.GlobalizationPreferences", IGlobalizationPreferencesStatics := "{01BF4326-ED37-4E96-B0E9-C1340D1EA158}", GlobalizationPreferencesStatics)
            DllCall(NumGet(NumGet(GlobalizationPreferencesStatics+0)+9*A_PtrSize), "ptr", GlobalizationPreferencesStatics, "ptr*", LanguageList)   ; get_Languages
            DllCall(NumGet(NumGet(LanguageList+0)+7*A_PtrSize), "ptr", LanguageList, "int*", count)   ; count
            loop % count
            {
                DllCall(NumGet(NumGet(LanguageList+0)+6*A_PtrSize), "ptr", LanguageList, "int", A_Index-1, "ptr*", hString)   ; get_Item
                DllCall(NumGet(NumGet(LanguageFactory+0)+6*A_PtrSize), "ptr", LanguageFactory, "ptr", hString, "ptr*", LanguageTest)   ; CreateLanguage
                DllCall(NumGet(NumGet(OcrEngineStatics+0)+8*A_PtrSize), "ptr", OcrEngineStatics, "ptr", LanguageTest, "int*", bool)   ; IsLanguageSupported
                if (bool = 1)
                {
                    DllCall(NumGet(NumGet(LanguageTest+0)+6*A_PtrSize), "ptr", LanguageTest, "ptr*", hText)
                    buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
                    text .= StrGet(buffer, "UTF-16") "`n"
                }
                ObjRelease(LanguageTest)
            }
            ObjRelease(LanguageList)
            return text
        }
        if (lang != CurrentLanguage) or (lang = "FirstFromAvailableLanguages")
        {
            if (OcrEngine != "")
            {
                ObjRelease(OcrEngine)
                if (CurrentLanguage != "FirstFromAvailableLanguages")
                    ObjRelease(Language)
            }
            if (lang = "FirstFromAvailableLanguages")
                DllCall(NumGet(NumGet(OcrEngineStatics+0)+10*A_PtrSize), "ptr", OcrEngineStatics, "ptr*", OcrEngine)   ; TryCreateFromUserProfileLanguages
            else
            {
                CreateHString(lang, hString)
                DllCall(NumGet(NumGet(LanguageFactory+0)+6*A_PtrSize), "ptr", LanguageFactory, "ptr", hString, "ptr*", Language)   ; CreateLanguage
                DeleteHString(hString)
                DllCall(NumGet(NumGet(OcrEngineStatics+0)+9*A_PtrSize), "ptr", OcrEngineStatics, ptr, Language, "ptr*", OcrEngine)   ; TryCreateFromLanguage
            }
            if (OcrEngine = 0)
            {
                msgbox Can not use language "%lang%" for OCR, please install language pack.
                ExitApp
            }
            CurrentLanguage := lang
        }
        IRandomAccessStream := file
        DllCall(NumGet(NumGet(BitmapDecoderStatics+0)+14*A_PtrSize), "ptr", BitmapDecoderStatics, "ptr", IRandomAccessStream, "ptr*", BitmapDecoder)   ; CreateAsync
        WaitForAsync(BitmapDecoder)
        BitmapFrame := ComObjQuery(BitmapDecoder, IBitmapFrame := "{72A49A1C-8081-438D-91BC-94ECFC8185C6}")
        DllCall(NumGet(NumGet(BitmapFrame+0)+12*A_PtrSize), "ptr", BitmapFrame, "uint*", width)   ; get_PixelWidth
        DllCall(NumGet(NumGet(BitmapFrame+0)+13*A_PtrSize), "ptr", BitmapFrame, "uint*", height)   ; get_PixelHeight
        if (width > MaxDimension) or (height > MaxDimension)
        {
            msgbox Image is to big - %width%x%height%.`nIt should be maximum - %MaxDimension% pixels
            ExitApp
        }
        BitmapFrameWithSoftwareBitmap := ComObjQuery(BitmapDecoder, IBitmapFrameWithSoftwareBitmap := "{FE287C9A-420C-4963-87AD-691436E08383}")
        DllCall(NumGet(NumGet(BitmapFrameWithSoftwareBitmap+0)+6*A_PtrSize), "ptr", BitmapFrameWithSoftwareBitmap, "ptr*", SoftwareBitmap)   ; GetSoftwareBitmapAsync
        WaitForAsync(SoftwareBitmap)
        DllCall(NumGet(NumGet(OcrEngine+0)+6*A_PtrSize), "ptr", OcrEngine, ptr, SoftwareBitmap, "ptr*", OcrResult)   ; RecognizeAsync
        WaitForAsync(OcrResult)
        DllCall(NumGet(NumGet(OcrResult+0)+6*A_PtrSize), "ptr", OcrResult, "ptr*", LinesList)   ; get_Lines
        DllCall(NumGet(NumGet(LinesList+0)+7*A_PtrSize), "ptr", LinesList, "int*", count)   ; count
        loop % count
        {
            DllCall(NumGet(NumGet(LinesList+0)+6*A_PtrSize), "ptr", LinesList, "int", A_Index-1, "ptr*", OcrLine)
            DllCall(NumGet(NumGet(OcrLine+0)+7*A_PtrSize), "ptr", OcrLine, "ptr*", hText) 
            buffer := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", length, "ptr")
            text .= StrGet(buffer, "UTF-16") "`n"
            ObjRelease(OcrLine)
        }
        Close := ComObjQuery(IRandomAccessStream, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
        DllCall(NumGet(NumGet(Close+0)+6*A_PtrSize), "ptr", Close)   ; Close
        ObjRelease(Close)
        Close := ComObjQuery(SoftwareBitmap, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
        DllCall(NumGet(NumGet(Close+0)+6*A_PtrSize), "ptr", Close)   ; Close
        ObjRelease(Close)
        ObjRelease(IRandomAccessStream)
        ObjRelease(BitmapDecoder)
        ObjRelease(BitmapFrame)
        ObjRelease(BitmapFrameWithSoftwareBitmap)
        ObjRelease(SoftwareBitmap)
        ObjRelease(OcrResult)
        ObjRelease(LinesList)
        return text
    }

    CreateClass(string, interface, ByRef Class) {
        CreateHString(string, hString)
        VarSetCapacity(GUID, 16)
        DllCall("ole32\CLSIDFromString", "wstr", interface, "ptr", &GUID)
        result := DllCall("Combase.dll\RoGetActivationFactory", "ptr", hString, "ptr", &GUID, "ptr*", Class)
        if (result != 0)
        {
            if (result = 0x80004002)
                msgbox No such interface supported
            else if (result = 0x80040154)
                msgbox Class not registered
            else
                msgbox error: %result%
            ExitApp
        }
        DeleteHString(hString)
    }

    CreateHString(string, ByRef hString) {
        DllCall("Combase.dll\WindowsCreateString", "wstr", string, "uint", StrLen(string), "ptr*", hString)
    }

    DeleteHString(hString) {
        DllCall("Combase.dll\WindowsDeleteString", "ptr", hString)
    }

    WaitForAsync(ByRef Object) {
        AsyncInfo := ComObjQuery(Object, IAsyncInfo := "{00000036-0000-0000-C000-000000000046}")
        loop
        {
            DllCall(NumGet(NumGet(AsyncInfo+0)+7*A_PtrSize), "ptr", AsyncInfo, "uint*", status)   ; IAsyncInfo.Status
            if (status != 0)
            {
                if (status != 1)
                {
                    DllCall(NumGet(NumGet(AsyncInfo+0)+8*A_PtrSize), "ptr", AsyncInfo, "uint*", ErrorCode)   ; IAsyncInfo.ErrorCode
                    msgbox AsyncInfo status error: %ErrorCode%
                    ExitApp
                }
                ObjRelease(AsyncInfo)
                break
            }
            sleep 10
        }
        DllCall(NumGet(NumGet(Object+0)+8*A_PtrSize), "ptr", Object, "ptr*", ObjectResult)   ; GetResults
        ObjRelease(Object)
        Object := ObjectResult
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
                or ((es & ws_ex_controlparent) and ! (Style & WS_POPUP) and !(Win_Class ="#32770") and ! (es & WS_EX_APPWINDOW)) 
                ; pspad child window excluded
                
                or ((Style & WS_POPUP) and (Parent) and ((Style_parent & WS_DISABLED) =0))) 
                ; notepad find window excluded ; note - some windows result in blank value so must test for zero instead of using NOT operator!
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
        fsz := (fsz < 5) ? 5 : (fsz > 30) ? 30 : fsz
        Gui, 2:font,% "c" GC("CBt_color") " s" fsz " w" GC("CBfwt", "500"), % GC("CBfnt", "Consolas")
        DllCall("EnumChildWindows", "Ptr", CB_hwnd, "Ptr", ChangeFont)
        CC("CBfsz", fsz)
        return

    CBzoomIn:
        fsz := GC("CBfsz", "10")
        fsz += 1
        fsz := (fsz < 5) ? 5 : (fsz > 30) ? 30 : fsz
        Gui, 2:font,% "c" GC("CBt_color") " s" fsz " w" GC("CBfwt", "500"), % GC("CBfnt", "Consolas")
        DllCall("EnumChildWindows", "Ptr", CB_hwnd, "Ptr", ChangeFont)
        CC("CBfsz", fsz)
        return

    ChangeFont(hwnd, l) {
        GuiControl Font, %hwnd%
        return true
    }


#IF
