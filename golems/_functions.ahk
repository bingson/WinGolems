
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
 
 ActivateWindow(title="Chrome") {        
    ; activate window that contains title string
    SetTitleMatchMode,2                                                         ; match anywhere in title
    IfWinExist, %title%
        WinActivate 
    return
 
 }
 
 CloseEverything() {
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
    WinGetClass, class, A
    if (state = "ON") {
        Winset, Alwaysontop, ON , A                                             
        ShowModePopup(Process_Name "`nalways on top: ON",,,"80", "-800")
    } else {
        Winset, Alwaysontop, OFF , A                                            ; A stands for active window
        ShowModePopup(Process_Name "`nalways on top: OFF", "FF0000",,"80","-800")
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
        ActivateApp("ahk_exe googledrivesync.exe"
            , A_ProgramFiles . "\Google\Drive\googledrivesync.exe")           
        ShowModePopup("cloud sync initiated",,"300", "50")
        sleep, med
        return 
    } else {
        if WinExist("ahk_exe googledrivesync.exe"){
            WinClose, ahk_exe googledrivesync.exe
            ShowModePopup("closing cloud sync", "FF0000", "300", "50") 
            sleep, med 
        } else {
            ShowModePopup("cloud sync not running", "008080", "300", "50")
            sleep, med
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
        Run "C:\Users\bings\Desktop\Mail.lnk"
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
  
; MEM_CACHE FUNCTIONS __________________________________________________________
  
 CreateHotstringSnippet(width = "80", dest_file = "R.ahk") {
    /*
     CreateHotstringSnippet() will create a .txt copy of selected text
     in the mem_cache folder that can be retrieved through dynamically created 
     hotstring (script is automatically modified and reloaded). 
    
     — Python and R hotstring snippets will only work on designated windows 
       configured in the language specific ahk files. Allows the same hotstring 
       to be used if they embody equivalent ideas represented in different 
       code syntax.
    
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
    key := SubStr(input,1,InStr(input,"`r")-1)                                 
    if (key = "")                                                  
        return                                                     
    desc := trim(SubStr(input,InStr(input,"`r") + 2
            , InStr(input,"`r",,,2) - StrLen(key) - 2))                         
    body := trim(SubStr(input,InStr(input,"`r",,,2)+2))                         
    switch dest_file                                                            
    {
        case "R.ahk":           mem_path := "R\" 
        case "python.ahk":      mem_path := "python\"                                           
        case "windows_sys.ahk": mem_path := ""                                           
    }
    WriteToCache(key, False, mem_path, body)                                      
    new_hotstring := "`r:*:" key ">::"                                          
    num_char      := width - StrLen(new_hotstring) + 1                           
    string_char   := RepeatString(" ", num_char)                                 
    new_hotstring := new_hotstring string_char ";" desc "`n"                    ; create hotstring instantiation code  
                   . "AccessCache(" """" mem_path key """" ")`n"                
                   . "return`n"
    
    head    = %key% `, %A_YYYY% `, %A_MMM% `, %A_DD% `,                          
    tail    = %A_Hour% `, %A_Min% `, %dest_file%, %desc% `n                     
    log_txt = %head%%tail%                                                      
    FileAppend, %log_txt%, %A_ScriptDir%\mem_cache\hotstring_creation_log.csv   ; update hotstring creation log 
    FileAppend, %new_hotstring%, %A_ScriptDir%\golems\%dest_file%               ; add hotstring code to relevant ahk file
    AccessCache(key, mem_path)                                                  
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
    if (paste = True) {
        clip(output)
        return
    }
    return %output%
 } 

; AHK UTILITIES ________________________________________________________________


 CreateConfigINI() {
    global config_path
    global UProfile
    global PF_x86
    global med
    msg = No configuration file detected `nplease wait while a new one is created.
    ShowModePopup(msg, "000000",, "65", "-10000", "14", "560")                  
    PATH := FindAppPath("winword.exe", "excel.exe", "powerpnt.exe", "AcroRd32.exe", "chrome.exe")
    IniWrite,%UProfile%\AppData\Local\Programs\Microsoft VS Code\Code.exe, %config_path%, %A_ComputerName%, vscode_path
    IniWrite, % PATH["chrome.exe"],   %config_path%, %A_ComputerName%, chrome_path
    IniWrite, % PATH["winword.exe"],  %config_path%, %A_ComputerName%, word_path
    IniWrite, % PATH["excel.exe"],    %config_path%, %A_ComputerName%, excel_path
    IniWrite, % PATH["powerpnt.exe"], %config_path%, %A_ComputerName%, ppt_path
    IniWrite, % PATH["AcroRd32.exe"], %config_path%, %A_ComputerName%, pdf_path
    IniWrite,141,                     %config_path%, %A_ComputerName%, F_height
    IniWrite,415,                     %config_path%, %A_ComputerName%, F_width
    IniWrite,blue.ico,                %config_path%, settings, starting_icon
    ShowModePopup("Done!",,, "50", "-10000", "15")  
    sleep, med
    ClosePopup()
    return
 } 

 FindAppPath(app*) {
     global PF_x86
     FOLDER := [PF_x86 "\*",A_ProgramFiles "\*"]
     PATH := {}
 
     for each, exe in APP
     {  
         for each, dir in FOLDER
         {
             Loop Files, %dir%%exe%, R
             {

                 PATH[exe] := A_LoopFileFullPath
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
 
 set_tray_icon(ico_file) {
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
    set_tray_icon(ico_file_path) 
    WriteINI("settings", "starting_icon", ico_file)
    return
 } 

 ShowModePopup(msg, ctn = "008000", wn = "400", hn = "75", ms = "-1000", fmn = "16", wmn = "610") {
    ClosePopup()                                                                ; clean up any lingering popups
    popx := (A_ScreenWidth - wn)/2                                              ; popx := A_ScreenWidth - width - 25
    popy := A_ScreenHeight - hn                                                 ; popy := A_ScreenHeight - height - 25
    Progress, b C11 X%popx% Y%popy% ZH0 ZX10 zy10 W%wn% H%hn% FM%fmn% WM%wmn% CT%ctn% CWffffff,, %msg% ,,Gadugi
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
 
 WinLLock(state=TRUE) { 
    ; state = TRUE enables Win+L to lock the workstation. (admin privilege req'd)
    ; False disables the Windows hook, enabling AHK to repurpose #l 
    RegWrite, REG_DWORD, HKEY_CURRENT_USER
    , Software\Microsoft\Windows\CurrentVersion\Policies\System
    , DisableLockWorkstation, % !state
    return
 }
 
 GenerateHotkeyList() {
    ; generate a .txt list of all active hotkeys and hotstrings
    ; then opens that .txt in the default editor (config.ini)
    run %A_ScriptDir%\golems\Hotkey_Help.ahk                                    ; Run modified version of original script 
    global long
    sleep long                                                                  
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
    sleep, long * 1.5
    EditFile("""" New_Location """")
    FileDelete, %Orig_File%
    return
 }
 
 ReleaseModifiers(timeout := "") {                                              ; timeout in ms
    ; sometimes modifier keys get stuck while switching between programs
    ; this function call can be embedded in a function to fix that.
    static  aModifiers := ["Ctrl", "Alt", "Shift", "LWin", "RWin"
                          , "PrintScreen", "del", "ins", "end", "home"]
    
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


; FILE AND FOLDER RELATED FUNCTIONS ____________________________________________
 
 Explorer_GetSelection() {
    ; Get path of selected files/folders                                        https://www.autohotkey.com/boards/viewtopic.php?style=17&t=60403
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
     ; Select files in file explorer by regex                                   ; https://sharats.me/posts/the-magic-of-autohotkey-2/
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
    sleep, med
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
 
 ChangeFolder(path, sys_dependent = False) {
    ; this function instantiates a hotkey for changing the current folder
    ; in file explorer or windows "save as" type dialogue boxes
    if (sys_dependent = TRUE){
        global config_path
        IniRead, true_path, %config_path%, %A_ComputerName%, %path%
        path := true_path
    } 
    try
    {
        if WinActive("ahk_class #32770")                                        ; class for "save as" dialogue boxes
        {                                      
            changeDialDir(path)
        } 
        else if (WinActive("ahk_exe explorer.exe") 
        AND WinActive("ahk_class CabinetWClass")) 
        {
            NavRun(path)
        }
        return
    }
 }
 
 changeDialDir(path) {
    ; change directory of "save as" dialogue box
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
 
 ActivateApp(identifier, app_path = "", arguments = "", admin = False) {
    /* creates dedicated hotkey to activate/open an application
     identifier: Window Title, Class, or Process name from window spy
     app_dir: directory where app is located

     Usage example:
 
     #a::ActivateApp("ahk_exe chrome.exe")
     ,"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe") 
     
     creates keyboard shortcut: 'win + a' combo will activate the
     last opened chrome window or launch new instance if none found
    
    */  
    global config_path
    WinGet, wList, List, %identifier%  
    if !wList                                                                   ; if wList is empty/zero, no app windows exist 
    {                       
        RegExMatch(app_path, "[^.]+$", ext)
        ext := rtrim(ext, """")
        if (ext = "exe") or (ext = "lnk")
            RunAsUser(app_path, arguments, A_ScriptDir)                         ; launch new instance of program with standard user priviledges
        else                                                                    ; else must be a system dependent path
        {
            try
            {
                IniRead, output, %config_path%, %A_ComputerName%, %app_path%                                                    
                RunAsUser(output, arguments, A_ScriptDir)             
            }
        }
        return
    } 
    Else if (wList > 0) 
    {                                                                           ; activates app if window already exists     
        WinActivate, % "ahk_id " wList1                                         ; activates last currently opened instance
    }
 }
 
 ActivateEnv(key) { 
    ; retrieves anaconda environment dependent on the system
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, %key%
    clip("activate " output)
    return
 }
 
 EditFile(file_path = "0_MASTER.ahk", app_path = "vscode_path") {
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
 
; MOUSE ________________________________________________________________________
 
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
  
  LoadURL(URL) {
    ; Browser path used to load urls dependent on computer
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, chrome_path
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
    ; if A_ThisHotkey
    If !Instr(A_ThisHotkey, "del") 
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
  
  ConvertUpper() {
    ; Convert selected text to uppercase
    var := clip()
    StringReplace, var, var, `r`n, `n, All 
    StringUpper, var, var
    clip(var, True)
    return
  }
  
  ConvertLower() {
    ; Convert selected text to lowercase
    var := clip()
    StringReplace, var, var, `r`n, `n, All 
    StringLower, var, var
    clip(var, True)
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
  
  FirstLetterCapitalized() {
    ; Capitalize just first letter of selected text
    var := clip()
    StringReplace, var, var, `r`n, `n, All
    StringLower, var, var
    var := RegExReplace(var, "(((^|([.!?]+\s+))[a-z])| i | i')", "$u1")
    clip(var, True)
    return
  }
     
  RepeatString(_string, _count) {
    ; FAST WAY TO CREATE A STRING OF A REPEATED CHARACTER
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
 
  AddBorder( length = "80", char = "_", prefix = "" )  {
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
  
  RemoveAllSpaces() {
    var := clip()       
    StringReplace , var, var, %A_Space%,,All
    clip(var, True)
    return
  }
  
  ReplaceUnderscoreWithSpace() {
    var := clip()
    var := RegExReplace(var, "_", A_Space) 
    var := RegExReplace(var, "S) +", A_Space)
    clip(var, True)
    return 
  }
  
  ReplaceSpaceWithUnderscore() {
    var := clip()
    var := RegExReplace(var, "S) +", A_Space)
    var := RegExReplace(var, A_Space, "_") 
    clip(var, True)
    return
  }
 
  AddSpaceBtnCaseChange() {
    var := clip()
    var := trim(RegExReplace(var, "((?<=[a-z])[A-Z]|[A-Z](?=[a-z]))", " $1")) 
    clip(var, True)
    return
  }

; CODING _______________________________________________________________________


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
