
; APP MANAGEMENT _______________________________________________________________
  
 TabCondition(tab_name="MISC.txt", exact = False) { 
    ; checks if tab_name occurs somewhere in the window title
    if (exact = True) {
        SetTitleMatchMode, 3
        return % WinActive(tab_name)
    }
    SetTitleMatchMode 2
    WinGetActiveTitle, title
    return % InStr(title, tab_name)
 }

 MoveCMDToOtherDesktop(title = "jupyter") {
        SetTitleMatchMode, 2
        ; TabCondition(tab_name="MISC.txt", exact = False)
        global long
        if (WinExist("ahk_class ConsoleWindowClass") and WinExist(title)) {
            WinActivate
            sleep, long
            MoveWindowToOtherDesktop()
        }
        return
 }

 ActivateWindow(title="Chrome") {        
    ; activate window that contains title string
    SetTitleMatchMode,2                                                         ; match anywhere in title
    IfWinExist, %title%
        WinActivate 
    return
 
 }
 
 SaveWinID(key = "L") {
    ; writes the Y
    global config_path
    WinID_%key% := WinExist("A")
    IniWrite, % WinID_%key%, %config_path%, %A_ComputerName%, WinID_%key%
    ShowPopup("Window shortcut assigned", "405d27", "300", "70", "-1000", "16", "610")
    return
 }

 
 ActivateWinID(key = "L") {
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, WinID_%key%
    ActivateWindow("ahk_id" output)
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
 
 AlwaysOnTop(state = "ON") {
    ; toggle active window to be always on top
    WinGet, Process_Name, ProcessName, A
    WinGetTitle, Title, A
    WinGetClass, class, A
    if (state = "ON") {
        Winset, Alwaysontop, ON , A                                             
        ShowPopup(Process_Name "`nalways on top: ON",,"240","80", "-800")
    } else {
        Winset, Alwaysontop, OFF , A                                            ; A stands for active window
        ShowPopup(Process_Name "`nalways on top: OFF", "FF0000","240","80","-800")
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
    return  
 }
 
 ActivateNextInstance() {
    ; activate oldest instance of active program if multiple instances exist
    WinGetClass, ActiveClass, A
    WinGet,      p_name,      ProcessName , ahk_class %ActiveClass%
    WinGet,      n_instances, List,         ahk_class %ActiveClass%
    
    if (n_instances > 1)
        WinActivateBottom, ahk_class %ActiveClass% ahk_exe %p_name%,,Tabs Outliner,
    return  
 }
 
 CloudSync(state="ON") {
    ; Turn ON/OFF google cloud sync  
    global med
    if (state = "ON") {
        try {
            ActivateApp("sync_path")           
            ShowPopup("cloud sync initiated",,"300", "50", "-2000")
            return 
        } catch e {
            msgbox can't open cloud cloud sync app.
        }
    } else {
        if WinExist("ahk_exe googledrivesync.exe"){
            WinClose, ahk_exe googledrivesync.exe
            ShowPopup("closing cloud sync", "FF0000", "300", "50", "-2000")
        } else {
            ShowPopup("cloud sync not running", "008080", "300", "50", "-2000")
        }
        return
    } 
 }
 
 ActivateCalc() {
    ; activate windows calculator app
    IfWinNotExist,  Calculator
        run, C:\Windows\system32\calc.exe
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
 
 MoveWindowToOtherDesktop() {
    global med
    send #{tab}
    sleep, med*4
    send {AppsKey}
    sleep, med*3
    send {down 2}{right}
    sleep, med*3
    send {enter}
    sleep, med*3
    send {esc}
    return
 }

 SetVolume(incr = "+1", wn = "400", hn = "70") { 
    SetTimer,SliderOff,1000
    SoundSet, %incr%
    Gosub,DisplaySlider
    return

    SliderOff:
    Progress,Off
    Return

    DisplaySlider:
    SoundGet,Volume
    Volume:=Round(Volume)
    popx := (A_ScreenWidth - wn)/2                                              ; popx := A_ScreenWidth - width - 25
    popy := A_ScreenHeight - hn                                                 ; popy := A_ScreenHeight - height - 25
    Progress, B C11 X%popx% Y%popy% W%wn% H%hn% FS18,,,,Gadugi
    Progress,%Volume%,Volume: %Volume% 
    ; TrayTip:="Alt+LeftArrow or Alt+RightArrow to adjust volume" . "`nCurrent Volume=" . Volume
    ; Menu,Tray,Tip,%TrayTip%
    Progress,
    Return
 }

; BOUND FUNCTIONS ______________________________________________________________
 ; used for Jump Lists and TapHoldManager class instantiations
 BluetoothSettings       := Func("BluetoothSettings")
 AddRemovePrograms       := Func("AddRemovePrograms")
 AlarmClock              := Func("AlarmClock")
 DisplaySettings         := Func("DisplaySettings")
 SoundSettings           := Func("SoundSettings")
 NotificationWindow      := Func("NotificationWindow")
 RunProgWindow           := Func("RunProgWindow")
 StartMenu               := Func("StartMenu")
 StartContextMenu        := Func("StartContextMenu")
 QuickConnectWindow      := Func("QuickConnectWindow")
 WindowsSettings         := Func("WindowsSettings")
 PresentationDisplayMode := Func("PresentationDisplayMode")
 CloseAllPrograms        := Func("CloseAllPrograms")
 WinMaximize             := Func("WinMaximize")
 WinMinimize             := Func("WinMinimize")
 WinClose                := Func("WinClose")
 KeyHistory              := Func("KeyHistory")
 WindowSpy               := Func("WindowSpy")
 ReloadAHK               := Func("ReloadAHK")
 ExitAHK                 := Func("ExitAHK")
 GenerateHotkeyList      := Func("GenerateHotkeyList")
 EditHotkeyList          := Func("EditFile").Bind("HotKey_List.txt", "editor_path") 
 CloudSyncON             := Func("CloudSync").Bind("ON") 
 CloudSyncOFF            := Func("CloudSync").Bind("OFF") 
 WinLLockTrue            := Func("WinLLock").Bind(True) 
 WinLLockFalse           := Func("WinLLock").Bind(False) 
 ActivateExplorer        := Func("ActivateApp").Bind("explorer.exe")    

 
 DisplaySettings() {
    Run explorer.exe ms-settings:display                                
 }

 BluetoothSettings() {
    Run explorer.exe ms-settings:bluetooth
 }
 
 SoundSettings() {
    Run explorer.exe %A_WinDir%\system32\mmsys.cpl                      
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

 AddRemovePrograms() {
    Run assets\win\Add Remove Programs.lnk                            
 }

 AlarmClock() {
    Run assets\win\Alarms & Clock.lnk
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
 
 ReloadAHK() {
    Reload
 }

 ExitAHK() {
    ExitApp
 }

 
 
 WinMaximize(isHold, taps, state) {
    if (taps > 1) 
        WinMaximize,A
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
    % (taps > 1) ? RunInputCommand("EditFile", File_DICT, "EDIT FILE") : ""
 }

 FolderJumpList(isHold, taps, state){
    global Folder_DICT
    global ActivateExplorer
    % (taps > 1) ? RunInputCommand(ActivateExplorer, Folder_DICT, "OPEN FOLDER") : ""
 }
 
 WinJumpList(isHold, taps, state){
    global Command_DICT
    global Command_TOC
    % (taps > 1) ? RunInputCommand(, Command_DICT, "RUN SYS COMMAND", Command_TOC) : ""
 }
 
; INPUT BOX COMMANDS ___________________________________________________________
 
 RunInputCommand(func="", dest_dict="", prompt="", name_dict = "") {     
    ; opens an input box offering a menu of choices based on dest_dict
    ; dictionary, name_dict(optional) will replace labels automatically generated 
    ; from dest_dict.
    ; func: if supplied with a function, the value of dest_dict will be
    ; treated as a parameter to that function. If leaving func blank, 
    ; RunInputCommand assumes 
    
    global UProfile
    global med
    sleep ,med                                                                  ; short wait to delete hotstring
    tbl_data := (name_dict) ? BuildTOC(,,name_dict) : BuildTOC(,dest_dict)      ; tbl_data := [TOC, width, height, x_pos, y_pos]
    Gui +LastFound +OwnDialogs +AlwaysOnTop                                     ; set input box to always on top
    InputBox, UserInput, %prompt% , % tbl_data[1],
            , % tbl_data[2] , % tbl_data[3] , % tbl_data[4], % tbl_data[5], 
    if ErrorLevel {
    } else {
        if (func and dest_dict[UserInput]) {
            %func%(dest_dict[UserInput])  
        } else if (!func and dest_dict[UserInput]) {
            try {
                command := dest_dict[UserInput]
                %command%.call()
            }
        } else {
            RunInputCommand(func,dest_dict,prompt,name_dict)
        }
    }
    return
 }
 
 BuildTOC(TOC_prefix = "", arr = "", alt_arr = "") { 
    ; output: [TOC, width, height, x_pos, y_pos]
    ; TOC = table of contents string created from array input. 
    ; length, width: input box dimensions to fit the text
    ; x_pos, y_pos: input box window placement coordinates 
    arr_KV_swapped := {}                                                        ; key value swapped version of input array 
    max_rows := max_str_len := 0
    arr := alt_arr ? alt_arr : arr
    
    for key, val in arr                                                         ; this loop cleans the label dictionary values and creates a key:value swapped 
    {                                                                           ; version of the array (done to display TOC sorted by value instead of key)
        RegExMatch(val, "[^\\]+$", selection)
        selection := ReplaceManySpaceWith1Space(selection, False)
        arr_KV_swapped[selection] := key
        max_str_len := max(max_str_len, strlen(key . selection))
        max_rows++ 
    }
    
    line := RepeatString("-", max_str_len + 2) 
    TOC  := TOC_prefix 
          ? TOC_prefix
          : "   Key`tSelection`n  ----`t" line "`r"

    For dest, ref in arr_KV_swapped                                             
    {
        if alt_arr {
            prefix := substr(dest, 1, 3)
            if (prefix <> prev_prefix and prev_prefix and prefix) {
               TOC .= "`n"
               max_rows++
            }
            prev_prefix := prefix
        } 
        TOC .= (TOC <> "" ? "`n" : "") "  " ref "`t" rtrim(dest, """")
    }

    height := (max_rows * 22.5) + 80                                              ; height of input box
    width  := ((max_str_len + 4) * 9.5)                                                 ; width 

    if alt_arr {
      height  -= 23                                                             
      width := min(width, 570)
    }
    coords := ActiveWinCoord()
    x_pos  := (coords[1] < 0) ? (coords[1] - width) // 2 : ""                   ; changes window position if active window is on secondary monitor
    y_pos  := ""
    return [TOC, width, height, x_pos, y_pos] 
 }

; MEM_CACHE FUNCTIONS __________________________________________________________
  
 CreateHotstringSnippet(width = "80", dest_file = "R.ahk") {
    /*
 
     CreateHotstringSnippet() will create a .txt copy of selected text
     in the mem_cache folder that can be retrieved through dynamically created 
     hotstring (i.e., hotstring can be used immediately after creation). 
 
      — Python and R hotstring snippets are kept in separate directories. So the same
        hotstring name can be applied to corresponding layers of abstraction. 
        For example, "PlotScatter" can be used in both python and R to output 
        language/api specific syntax for the same idea.
  
      — To see an index of hotstrings created through CreateHotstringSnippet() open 
        mem_cache/hotstring_creation_log.csv
 
      — FORMAT:
 
        1) First line of text will be transformed into the hotstring trigger string
           with a ">" character appended to the end.
        2) Second line will be transformed into a comment in the target .ahk file
        3) Third line should be the target text to store
 
      — EXAMPLE:
 
        hotstring_label
        comment/description of hotstring for hotkey_help.ahk indexing>
        text to store
 
        select above 3 lines and press insert & w to create a hotstring.
        Afterwards, typing "hotstring_label>" will output "text to store"  
    */

    input := trim(clip(), "`r`n`t")                                             
    key := trim(SubStr(input,1,InStr(input,"`r")-1))
    if (key = "")                                                  
        return                                                     
    desc := trim(SubStr(input,InStr(input,"`r") + 2
            , InStr(input,"`r",,,2) - StrLen(key) - 2))                         
    body := trim(SubStr(input,InStr(input,"`r",,,2)+2))                         
    switch dest_file                                                            
    {
        case "R.ahk":           mem_path := "R\" 
        case "python.ahk":      mem_path := "python\"                                           
        case "win_sys.ahk": mem_path := ""                                           
    }
    WriteToCache(key, False, mem_path, body)      
    new_hotstring := "`r :*:" key ">::"             
    num_char      := width - StrLen(new_hotstring) + 1                           
    string_char   := RepeatString(" ", num_char)                                 
    new_hotstring := new_hotstring string_char ";" desc                         ; create hotstring instantiation code  
                   . " AccessCache(" """" mem_path key """" ")`n"                
                   . " return`n"
    
    head    = %key% `, %A_YYYY% `, %A_MMM% `, %A_DD% `,                          
    tail    = %A_Hour% `, %A_Min% `, %dest_file%, %desc% `n                     
    log_txt = %head%%tail%                                                      
    FileAppend, %log_txt%, %A_ScriptDir%\mem_cache\hotstring_creation_log.csv   ; update hotstring creation log 
    FileAppend, %new_hotstring%, %A_ScriptDir%\golems\%dest_file%               ; add hotstring code to relevant ahk file ()
    AccessCache(key, mem_path)                                                  
    ShowPopup("new hotstring created", "008000", "300", "50", "-1000", "16", "610")
    global long
    sleep, long
    reload
    return
 } 
 
 WriteToCache(key, del_toggle = False, mem_path = "", input = "") {
    ; creates a txt file in \mem_cache from selected text
    if (input = "")                                                             
        input := clip()                                                         ; captures selected text if no input given
                                                            
    FileRead, output, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
    if (output = input) or (input = "") {
    } else {
        FileDelete, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
        FileAppend, %input%, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
    }  
    if (del_toggle = TRUE)
        send {del}
    return
 }
         
 AccessCache(key, mem_path = "", paste = True) {
    ; paste contents of mem folder txt file or assign to variable
    FileRead, output, %A_ScriptDir%\mem_cache\%mem_path%%key%.txt
    output := rtrim(output, "`t`n`r")
    if !paste {
       return %output%
    }
    clip(output)                                                                ; clip(output, True)
    return
 } 

; AHK UTILITIES ________________________________________________________________

 ActiveWinCoord() {
        ; returns an 1-D array with the bounding coordinates of the monitor the window is on.
        winHandle := WinExist("A")                                              ; The window to operate on
        VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)                
        monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2)
        DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo)    
        Left      := NumGet(monitorInfo, 20, "Int")                             ; Left
        Top       := NumGet(monitorInfo, 24, "Int")                             ; Top
        Right     := NumGet(monitorInfo, 28, "Int")                             ; Right
        Bottom    := NumGet(monitorInfo, 32, "Int")                             ; Bottom
        return [Left, Top, Right, Bottom] 
 }

 TimeCode()                                                                      
 {
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

 CreateConfigINI(apps*) {
    global config_path
    global UProfile
    global med
    msg = No configuration file detected `nplease wait while a new one is created.
    ShowPopup(msg, "000000",, "65", "-10000", "14", "560")                  
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
    ShowPopup("Done!",,, "50", "-10000", "15")
    sleep, med*2
    ClosePopup()
    return
 } 

 FindAppPath(app*) {
    global UProfile
    global PF_x86
    FOLDER := [PF_x86 "\*",A_ProgramFiles "\*",UProfile "\AppData\Local\Programs\*"]
    PATH := {}
    for each, exe in APP
    {  
        ShowPopup("Searching for " exe,,, "50", "-10000", "15")  
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
 
 WriteINI(section="settings", key="starting_icon", val="blue.ico") {
    global config_path
    IniWrite, %val%, %config_path%, %section%, %key%
    return
 }
 
 SetTrayIcon(ico_file) {
    ; change tray icon
    IfExist, %ico_file%
    {
        Menu, Tray, Icon, %ico_file%
    }
       
 } 

 ChangeTrayIcon(ico_path) {
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
    WriteINI("settings", "starting_icon", ico_file)
    return
 } 

 ShowPopup(msg, ctn = "008000", wn = "400", hn = "75", ms = "-1000", fmn = "16", wmn = "610", cwn = "ffffff") {
    ClosePopup()                                                                ; clean up any lingering popups
    popx := (A_ScreenWidth - wn)/2                                              
    popy := A_ScreenHeight - hn                                                 
    Progress, b C11 X%popx% Y%popy% ZH0 ZX10 zy10 W%wn% H%hn% FM%fmn% WM%wmn% CT%ctn% CW%cwn%,, %msg% ,,Gadugi
    SetTimer, ClosePopup, %ms%
    POP_UP := true
 }   

 ClosePopup() {
    Progress, Off
    POP_UP := false
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

    if (supress = False) {
        if state
              ShowPopup("Win+L Lock: ON",,"200","50", "-800")
        else           
              ShowPopup("Win+L Lock: OFF","FF0000","200","50", "-800")
    }
    return
 }
 
 GenerateHotkeyList() {
    ; generate a .txt list of all active hotkeys and hotstrings
    ; then opens that .txt in the default editor (config.ini)
    ReleaseModifiers()
    global long
    global med
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
 
 JoinArrayContents(arr, delimiter="`n") {
    content := ""
    for index, item in arr {
        if index > 1
            content := content . delimiter
        content := content . item
    }
    return content
 }

 SelectByRegEx() {
    ; Select files in file explorer by regex                                    ; https://sharats.me/posts/the-magic-of-autohotkey-2/
    static selectionPattern := ""
    WinGetPos, wx, wy
    ControlGetPos, cx, cy, cw, , DirectUIHWND3
    x := wx + cx + cw/2 - 200
    y := wy + cy
    InputBox, selectionPattern, Select by regex
        , Enter regex pattern to select files that CONTAIN it (Empty to select all)
        , , 400, 150, %x%, %y%, , , %selectionPattern%
    if ErrorLevel
        Return
    for window in ComObjCreate("Shell.Application").Windows
        if WinActive("ahk_id " . window.hwnd) {
            pattern := "S)" . selectionPattern
            items := window.document.Folder.Items
            total := items.Count()
            i := 0
            showProgress := total > 160
            if (showProgress)
                Progress, b w200, , Matching...
            for item in items {
                match := RegExMatch(item.Name, pattern) ? 17 : 0
                window.document.SelectItem(item, match)
                if (showProgress) {
                    i := i + 100
                    Progress, % i / total
                }
            }
            Break
        }
    Progress, Off
 }

 ExpandCollapseAllGroups(){
    global med
    WinGetActiveStats, Title, Width, Height, X, Y
    MouseGetPos, StartX, StartY
    sleep, med * 1.5
    MouseClick, right, % GetConfig("F_width"), % GetConfig("F_height")           
    n := 0
    Loop {
        MouseGetPos,,,, fc
        Sleep, fc ? 25 : 0
    } Until !fc ||g_highlight ++n > 80
    
    Send % (Instr(A_ThisHotkey, "^") ? "u" : "g") "{Enter}"                     ; ternary: sends u if if detects ctrl was pressed as part of the hotkey, g otherwise
    sleep, short
    MouseMove StartX, StartY
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
            return Item                                                         ; Return active window object        
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
        ActivateOrOpen(app_path,,arguments, start_folder_toggle)                ; only compatible options are file explorer or command window
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

    if (exe_name = "explorer.exe") {
        RegExMatch(arguments, "[^\\]+$", win_title)
        grp_ID := (start_folder_toggle)  
                ? "ahk_class CabinetWClass ahk_exe " exe_name                   ; after start folder first opening, make #b key activate last explorer window
                : win_title " ahk_class CabinetWClass ahk_exe " exe_name
    } else {
        grp_ID := arguments "ahk_exe " exe_name
    }
    WinGet, wList, List, %grp_ID%  
    if !wList {
        app_path := (exe_name = "explorer.exe" or exe_name = "cmd.exe")
                 ? exe_name
                 : app_path
        RunAsUser(app_path, arguments, A_ScriptDir)                             ; cmd.exe and explorer.exe do not need filepaths
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
            global config_path
            IniRead, prog_path, %config_path%, %A_ComputerName%, pdf_path
            RunAsUser(prog_path, file_path, A_ScriptDir) 
        } 
        else 
        {   
            global config_path
            IniRead, prog_path, %config_path%, %A_ComputerName%, %app_path%
            RunAsUser(prog_path, file_path, A_ScriptDir) 
        }
        return
    } 
    catch 
    {
        MsgBox, can't open file
    }
     
    return
 } 
 
 FilePrepend(filename, atext) {
    FileRead fileContent, % filename
    FileDelete % filename
    FileAppend % atext . "`n" . filecontent, % filename
 }
 
; MOUSE FUNCTIONS_______________________________________________________________

 MouseClicks(num = 2) {
    ; temporarily blocks mouse movement for more consistent doubleclick to select word
    ReleaseModifiers()
    BlockInput, MouseMove
    click, %num%
    BlockInput, MouseMoveOff
    return
 }

 JumpLeftEdge() {                                                              ; move mouse pointer with hotkeys
    ; move mouse cursor to the left edge of active window
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A 
    MouseGetPos,,y
    DllCall("SetCursorPos", int, winTopL_x + 20, int, y)                        ; MouseMove, X, Y, 0 ; does not work with multi-monitor
    return
 }
  
 JumpRightEdge() {
    ; move mouse cursor to the right edge of active window
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    MouseGetPos,,y
    DllCall("SetCursorPos", int, winTopL_x + width - 20, int, y) 
    return
 } 
 
 JumpTopEdge() {
    ; move mouse cursor to the top edge of active window
    Sleep 50
    CoordMode, Mouse, Screen 
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    MouseGetPos, x
    DllCall("SetCursorPos", int, x, int, winTopL_y - 20)
    return
 }
 
 JumpBottomEdge() {
    ; move mouse cursor to the bottom edge of active window
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    MouseGetPos, x
    DllCall("SetCursorPos", int, x, int, winTopL_y + height - 20) 
    return
 }
 
 JumpMiddle() {
    ; move mouse cursor to the middle of active window
    Sleep 50
    CoordMode, Mouse, Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    winCenter_x := winTopL_x + width/2
    winCenter_y := winTopL_y + height/2
    DllCall("SetCursorPos", int, winCenter_x, int, winCenter_y)
    return
 }
 
; CHROME BROWSER _______________________________________________________________
 

 LoadURL(URL) {
    ; Browser path used to load urls dependent on computer
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, html_path
    Run, %output% %URL%
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

; TEXT MANIPULATION ____________________________________________________________
 
 PasteClipboardAtMouseCursor() {    
    MouseClicks(2)
    var := Clipboard
    var := trim(var, "`r`n`t")
    Clipboard := var
    sleep, short
    send ^v
    return
 }

 Join(s,p*) {
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
    If !Instr(A_ThisHotkey, "del")                                              ; selects text to the left of hotstring (if no hotkey activation detected)
        send +{home}
    var := clip()
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
 
 EveryFirstLetterCapitalized(other_letters_lowercase = False) { 
    ; Every first letter of selected text is capitalized
    var := clip()
    if (other_letters_lowercase = False)
        var := RegExReplace(var, "(\b[a-z])", "$U1")
    else {
        StringReplace, var, var, `r`n, `n, All 
        StringUpper, var, var, T
    }
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
 
 FillChar(length = "80", char = "=", before = False) {
    ; Function to create borders and space characters
    try {
        input         := clip()                                                     
        string        := rtrim(input)
        num_char      := (length - StrLen(string))/StrLen(char)
        string_char   := RepeatString(char, num_char)
        output        := string . A_Space . string_char
        output        := substr(output, 1, length)
        clip(output)
    }
    return
 }

 AddSpaceBeforeComment(length = "80", char = " ") {
    ; Add spaces until cursor hits the desired comment column 
    global long                                                                
    global med
    backup := clipboardall
    clipboard := ""
    Send {space}{left}+{end}                                                    ; in vscode ^x on empty selection will cut the whole line
    TrimText(True)
    Send {home 2}{shift down}{end}{shift up}
    sleep, med
    FillChar(length, char) 
    if (clipboard != "") 
    {
        sleep, long
        send ^v 
    } 
    clipboard := backup
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

 TrimText(cut = False) {
    ; cut/copy and trim selected text 
    if (cut = False) 
        send ^c
    else
        send ^x
    input := trim(clipboard)
    clipboard := input
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
 
 ReplaceUnderscoreWithSpace(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := RegExReplace(var, "_", A_Space) 
    var := RegExReplace(var, "S) +", A_Space)
    if !paste
        return %var%
    clip(var, True)
    return
 }
 
 ReplaceSpaceWithUnderscore(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := RegExReplace(var, "S) +", A_Space)
    var := RegExReplace(var, A_Space, "_") 
    if !paste
        return %var%
    clip(var, True)
    return
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

 ReplaceQuotesWithSpaces(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := StrReplace(var, """","")
    if !paste
        return %var%
    clip(var, True)
 }
 
 RemoveAllSpaces(var = "", paste = True) {
    var := (!var ? clip() : var)
    StringReplace , var, var, %A_Space%,,All
    if !paste
        return %var%
    clip(var, True)
 }
 
 ReplaceManySpaceWith1Space(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := RegExReplace(var, "S) +", A_space) 
    if !paste
       return %var%
    clip(var, True)
    return  
 }

 ReplacePlusOrCommaWithSpace(var = "", paste = True) {
    var := (!var ? clip() : var)       
    var := StrReplace(var, ",", A_Space)
    var := StrReplace(var, "+", A_Space)
    var := RegExReplace(var, "S) +", A_Space)                                  
    if !paste
       return %var%
    clip(var, True)
    return  
 }

 ReplacePeriodWithSpace(var = "", paste = True) {
    var := (!var ? clip() : var)
    var := StrReplace(var, "."," ")
    if !paste
       return %var%
    clip(var, True)
    return  
 }

 ReplaceEqualWithSpace(var = "", paste = True) {                                                                  
    var := (!var ? clip() : var)
    var := StrReplace(var, "="," ")
    if !paste
       return %var%
    clip(var, True)
    return  
 }

 replaceDeletedCharWithSpaces() {
    var := clip()
    clip(RepeatString(" ", strlen(var)))
    return 
 }

 ReplaceEqualWithUnderscore() {
     var := clip()
     var := StrReplace(var, "=","_")
     clip(var)
     return
 }

 ReplaceDashWithSpaces() {
     var := clip()
     var := StrReplace(var, "-"," ")
     clip(var)
     return
 }

 ReplaceSpacesWithDash() {
     var := clip()
     var := StrReplace(var, " ","-")
     clip(var)
     return
 }

 PasteDelExtraSpaces() {
    char_count := strlen(clipboard)
    send ^v
    sendinput {del %char_count%}
    return
 }
 
 ReplaceSpacesWithPluses() {
    var := clip()
    var := RegExReplace(var, "S) +", A_Space)                                  
    var := RegExReplace(var, A_Space, " + ") 
    clip(var)
    return
 }

 ReplaceSpacesWithCommas() {
     var := clip()
     var := RegExReplace(var, "S) +", A_Space)                                 
     var := RegExReplace(var, A_Space, ", ") 
     clip(var, True)
     return
 }

 ReplaceCommasWithPluses() {
     var := clip()
     var := StrReplace(var, A_Space,"")                                          
     var := StrReplace(var, ",", " + ")
     clip(var, True)
     return
 }

 ReplacePlusesWithCommas() {
    var := clip()       
    var := StrReplace(var, A_Space,"")
    var := StrReplace(var, "+", ", ")
    clip(var, True)
    return
 }

 ReplaceSpacesWithPipe() {
     var := clip()
     var := RegExReplace(var, "S) +", A_Space) 
     var := RegExReplace(var, A_Space, "|") 
     clip(var, True)
     return 
 }