#IfWinActive
SetTitleMatchMode, 2
win_sys_autoexecution:                                                          ; initialize class instances for double-tap to execute commands
 
 ; tap twice to execute shortcuts
 thm_sys := new TapHoldManager(270,,maxTaps = 3,"$","")                         ; with window parameter set here, default window criteria that will be set for all sub-created hotkeys under this manager object is notepad
 thm_sys.Add("printscreen", Func("WinMaximize"))                                ; maximize window by pressing printscreen twice in 300 milliseconds
 thm_sys.Add("rctrl",       Func("BrowserForward"))                             ; simulates Alt+Right 
 thm_sys.Add("ralt",        Func("BrowserBack"))                                ; simulates Alt+Left 

 return

; MANIPULATE APPLICATION WINDOWS _______________________________________________

 ^#sc027::                Send {lwin down}d{lwin up }                           ;[MAW] show desktop
 ^#w::                    WinClose,A                                            ;[MAW] close active window
 ^#q::                    CloseClass()                                          ;[MAW] close all instances of the active program
 +#capslock::             ActivatePrevInstance()                                ;[MAW] rotate through active program instances starting from oldest 
 #capslock::              ActivateNextInstance()                                ;[MAW] rotate through active program instances starting from newest 
 >+enter::                send {F11}                                            ;[MAW] full screen {F11}
 PrintScreen & space::                                                          ;[MAW] move window btn monitors
 +#space::                Send {lwin down}{shift down}{Left}{shift up}{lwin up} ;[MAW] move window btn monitors    
 #ins::                   AlwaysOnTop()                                         ;[MAW] Always on top: ON
 #del::                   AlwaysOnTop("OFF")                                    ;[MAW] Always on top: Off
 PrintScreen & Left::     send {LWin down}{Left}{LWin up}                       ;[MAW] resize window to left half of screen
 PrintScreen & Right::    send {LWin down}{Right}{LWin up}                      ;[MAW] resize window to right half of screen
 #space::                                                                       ;[MAW] maximize window
 PrintScreen & Up::                                                             ;[MAW] maximize window   
 #Up::                    WinMaximize,A                                         ;[MAW] maximize window 
 PrintScreen & SC027::                                                          ;[MAW] minimize window 
 #SC027::                 WinMinimize,A                                         ;[MAW] minimize window 
 !#SC027::                Send #{SC027}                                         ;[MAW] insert emoji popup
 PrintScreen & PgDn::     MoveWindowToOtherDesktop()                            ;[MAW] MoveWindowToOtherDesktop
 

; SYS SETTINGS _________________________________________________________________

 :X:b~~::    BluetoothSettings()                                                ;[SS] bluetooth settings
 :X:d~~::    DisplaySettings()                                                  ;[SS] display settings
 :X:n~~::    NotificationWindow()                                               ;[SS] notification window
 :X:v~~::    SoundSettings()                                                    ;[SS] sound settings
 :X:r~~::    RunProgWindow()                                                    ;[SS] run program
 :X:x~~::    StartContextMenu()                                                 ;[SS] context menu for the Start button
 :X:k~~::    QuickConnectWindow()                                               ;[SS] quick connect window
 :X:i~~::    WindowsSettings()                                                  ;[SS] windows settings
 :X:p~~::    PresentationDisplayMode()                                          ;[SS] presentation display mode

; SYS COMMANDS _________________________________________________________________

 ^#!Left::   Send {ctrl down}{lwin down}{Left}{ctrl up}{lwin up}                ;[SC] switch desktop environments (Left)
 ^#!Right::  Send {ctrl down}{lwin down}{Right}{ctrl up}{lwin up}               ;[SC] switch desktop environments (Right)
 +^!del::    DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)  ;[SC] enter sleep mode
 ^#!del::    DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)  ;[SC] enter hybernate mode
 ^#!esc::    ShutDown, 9                                                        ;[SC] shutdown + power down 
 +^!esc::    ShutDown, 2                                                        ;[SC] restart the computer
 :X:a~~::    AlarmClock()                                                       ;[SC] alarm clock
 :cX:ce~~::  CloseAllPrograms()                                                 ;[SC] close all open programs 
 ^#!F12::    CloudSync("ON")                                                    ;[SC] turn on cloud sync 
 +^#F12::    CloudSync("OFF")                                                   ;[SC] turn off cloud sync

; FILE EXPLORER ________________________________________________________________
 
 #IfWinActive ahk_group FileListers
 $+!c::     clipboard := Explorer_GetSelection()                                ;[FE] store file path(s) of selected file(s) in clipboard
 ^s::       SelectByRegEx()                                                     ;[FE] select files by regex
 !r::       Send {F2}                                                           ;[FE] rename file
 ^!c::      SendInput !dcmd{Enter}                                              ;[FE] Open Command Prompt Here
 !b::       send !{left}                                                        ;[FE] prev folder
 !n::       send !{right}                                                       ;[FE] forward folder
 ^!k::                                                                          ;[FE] up one directory level
 !u::       send !{up}                                                          ;[FE] up one directory level
 !p::       Send ^w                                                             ;[FE] close file explorer window
 
 !SC027::   DetailedView()                                                      ;[FE] view: detailed file info with resized columns
 ^h::       ToggleInvisible()                                                   ;[FE] view: toggle hide/unhide invisible files
 <^j::      SortByName()                                                        ;[FE] view: sort by name
 <^k::      SortByDate()                                                        ;[FE] view: sort by date modified
 >^j::      SortByType()                                                        ;[FE] view: sort by type
 >^k::      SortBySize()                                                        ;[FE] view: sort by size
 
 ^u::      send !vg{up   4}{enter}                                              ;[FE] groups: toggle groupby name/remove grouping
 ^o::      Send !vg{down 2}{enter}                                              ;[FE] groups: group by file type
 ^i::      Send !vg{down 1}{enter}                                              ;[FE] groups: group by date
 !sc035::                                                                       ;[FE] groups: group folding: Expand all 
 ^sc035::  ExpandCollapseAllGroups()                                            ;[FE] groups: group folding: Collapse all
 
 !z::       Send !vn{enter}                                                     ;[FE] panes: toggle navigation pane
 ^p::       Send {alt down}p{alt up}                                            ;[FE] panes: toggle preview plane
 <+Space:: ControlFocus, SysTreeView321, ahk_class CabinetWClass                ;[FE] panes: move focus to navigation pane
 >+Space:: ControlFocus, DirectUIHWND2, ahk_class CabinetWClass                 ;[FE] panes: move focus to current folder pane 
 

 #IfWinActive    

; COMMAND WINDOW _______________________________________________________________

 SetTitleMatchMode, 2
 #If WinActive("ahk_class ConsoleWindowClass") 
 :X:R.exe::      clip("C:\R\R-4.0.5\bin\R.exe")                                 ;[C] R terminal (for pkg installation)
 :X:conda dir::  clip("conda info --envs")                                      ;[C] conda info --envs
 :X:j>::         clip("jupyter notebook")                                       ;[C] jupyter notebook
 :X:jl>::        clip("jupyterlab")                                             ;[C] jupyterlab
 #IfWinActive

; AHK RELATED __________________________________________________________________
 
 >+esc::   getMousePos()                                                        ;[AHK] display current mouse cursor coordinates in a tool tip
 :X:kh~~:: KeyHistory                                                           ;[AHK] open key history
 :X:ws~~:: run, C:\Program Files\AutoHotkey\WindowSpy.ahk                       ;[AHK] open windows spy
 +^#r::    ExitApp                                                              ;[AHK] quit ahk script
 
 :*:g?~~::                                                                      ;[AHK] generate a list of hotkeys in working directory.
    ReleaseModifiers()
    send {esc}
    GenerateHotkeyList()                                             
    return

 :*:?~~::                                                                       ;[AHK] open last generated list of hotstrings and hotkeys
    ReleaseModifiers()
    EditFile("HotKey_List.txt")
    return
 
 $^#r::                                                                         ;[AHK] reload all ahk scripts with ~^#r reload hotkeyp
    Reload:                                                                     
    Reload                                               
    return                                               

; DYNAMIC HOTSTRING CREATION ___________________________________________________
  
 /*** CreateHotstringSnippet() -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 
   CreateHotstringSnippet() will create a .txt copy of selected text
   in the mem_cache folder that can be retrieved through dynamically created 
   hotstring (i.e., hotstring can be used immediately after creation). 
 
    — Python and R hotstring snippets are kept in separate directories. So the same
      hotstring name can be applied to corresponding layers of abstraction. 
      For example, "plot_scatter_plot" can be used in both python and R to output 
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
 
 
 Home & F8::                                                                    ;[D] open hotstring_creation_log.csv
 :*:hs~~::                                                                      ;[D] open hotstring_creation_log.csv
 run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv
 return
 
 printscreen & F1:: CreateHotstringSnippet("80", "win_sys.ahk")                 ;[D] create windows hotstring
 printscreen & F2:: CreateHotstringSnippet("80", "R.ahk")                       ;[D] create R programming hotstring
 printscreen & F3:: CreateHotstringSnippet("80", "Python.ahk")                  ;[D] create python programming hotstring

 ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
 
 :*:sck>::                                                                      ;[D] sc key legend
 AccessCache("sck")
 return
 
 :*:3key>::                                                                     ;[D] example of 3 button hotkey using &
 :*:3k>::                                                                       ;[D] example of 3 button hotkey using &
 AccessCache("3key")
 return

 :*:cc>::                                                                       ;[D] 6-digit RGB color values
 :*:color_code>::                                                               ;[D] 6-digit RGB color values
 AccessCache("color_code")
 return
