#IfWinActive
; MANIPULATE APPLICATION WINDOWS _______________________________________________
 
 ^#sc027::                Send {lwin down}d{lwin up }                           ;[MAW] show desktop
 ^#w::                    WinClose,A                                            ;[MAW] close active window
 ^#q::                    CloseClass()                                          ;[MAW] close all instances of the active program
 #capslock::              ActivatePrevInstance()                                ;[MAW] rotate through active program instances starting from oldest 
 !capslock::              ActivateNextInstance()                                ;[MAW] rotate through active program instances starting from newest 
 ~!tab::                  CursorFollowWin()                                     ;[MAW] mouse cursor follows active window (option turned on in Sys Jumplist)
 >+enter::                send {F11}                                            ;[MAW] full screen {F11}
 PrintScreen & space::                                                          ;[MAW] move window btn monitors
 +#space::                MoveWindowToOtherMonitor()                            ;[MAW] move window btn monitors
 
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

 ^#!Left::  Send {ctrl down}{lwin down}{Left}{ctrl up}{lwin up}                 ;[SC] switch desktop environments (Left)
 ^#!Right:: Send {ctrl down}{lwin down}{Right}{ctrl up}{lwin up}                ;[SC] switch desktop environments (Right)
 +^!del::   DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)   ;[SC] enter sleep mode
 ^#!del::   DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)   ;[SC] enter hybernate mode
 ^#!esc::   ShutDown, 9                                                         ;[SC] shutdown + power down 
 +^!esc::   ShutDown, 2                                                         ;[SC] restart the computer
 :X:a~~::   AlarmClock()                                                        ;[SC] alarm clock
 :cX:ce~~:: CloseAllPrograms()                                                  ;[SC] close all open programs 
 ^#!F12::   CloudSync("ON")                                                     ;[SC] turn on cloud sync 
 +^#F12::   CloudSync("OFF")                                                    ;[SC] turn off cloud sync

; AHK RELATED __________________________________________________________________
 

 ^#!r::          ExitApp                                                        ;[AHK] quit WinGolems

 :*:g?~~::                                                                      ;[AHK] generate a list of hotkeys in working directory.
    ReleaseModifiers()
    send {esc}
    GenerateHotkeyList()                                             
    return

 :X:?~~:: EditFile("HotKey_List.txt")                                           ;[AHK] open last generated list of hotstrings and hotkeys

 :*:hs~~::                                                                      ;[AHK] open hotstring_creation_log.csv
    run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv
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
 
 printscreen & F1:: CreateHotstringSnippet("80", "win_sys.ahk")                 ; create windows hotstring
 printscreen & F2:: CreateHotstringSnippet("80", "R.ahk")                       ; create R programming hotstring
 printscreen & F3:: CreateHotstringSnippet("80", "Python.ahk")                  ; create python programming hotstring

 ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
 :*:sck>::                                                                      ; sc key legend
 AccessCache("sck")
 return
 
 :*:3key>::                                                                     ; example of 3 button hotkey using &
 :*:3k>::                                                                       ; example of 3 button hotkey using &
 AccessCache("3key")
 return

 :*:cc>::                                                                       ; 6-digit RGB color values
 :*:color_code>::                                                               ; 6-digit RGB color values
 AccessCache("color_code")
 return
