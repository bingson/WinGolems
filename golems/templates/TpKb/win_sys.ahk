

; MANIPULATE APPLICATION WINDOWS _______________________________________________
  SetTitleMatchMode, 2
  #IfWinActive
  
  ~+#left::                                                                     ;[MAW] cursor follows active window when moving apps btn monitors
  ~!tab::                 CursorFollowWin()                                     ;[MAW] cursor follows active window when switch apps with alt+tab (option turned on in Commandbox)
  
  :X:tm~win::                                                                   ;[MAW] open task manager with hotstring combines with max + cursor follows task manager window
     send +^{esc}  
  ~+^esc::                TskMgrExt()                                           ;[MAW] maximize + mouse cursor follows window after task manager opens
  
  ^#sc027::               Send {lwin down}d{lwin up }                           ;[MAW] show desktop
  ^#w::                   WinClose,A                                            ;[MAW] close active window
  ^#q::                   CloseClass()                                          ;[MAW] close all instances of the active program
  printscreen & PgDn::
  +#tab::                 ActivatePrevInstance()                                ;[MAW] rotate through active program instances starting from oldest 
  !PgDn::
  #tab::                  ActivateNextInstance()                                ;[MAW] rotate through active program instances starting from newest 
  #esc::                  send #{tab}
  rshift & ralt::         send {F11}                                            ;[MAW] full screen {F11}
  
  !sc034::                moveWinBtnMonitors()                                  ;[MAW] move window btn monitors
     
  ^!space::               MaximizeWin()                                         ;[MAW] toggle maximize/restore window
  #del::                  AlwaysOnTop(1)                                        ;[MAW] Always on top: ON
  #ins::                  AlwaysOnTop(0)                                        ;[MAW] Always on top: OFF
  PrintScreen & Left::    send {LWin down}{Left}{LWin up}                       ;[MAW] resize window to left half of screen
  PrintScreen & Right::   send {LWin down}{Right}{LWin up}                      ;[MAW] resize window to right half of screen
                                                                         
 
  PrintScreen & SC027::                                                         ;[MAW] minimize window 
  #SC027::                 WinMinimize,A                                        ;[MAW] minimize window 
  !#SC027::                Send #{SC027}                                        ;[MAW] insert emoji popup
  :X:mod~win::             MoveWindowToOtherDesktop()                           ;[MAW] MoveWindowToOtherDesktop
 
; SYS SETTINGS _________________________________________________________________

  :X:b~win::               BluetoothSettings()                                  ;[SS] bluetooth settings
  :X:d~win::               DisplaySettings()                                    ;[SS] display settings
  :X:n~win::               NotificationWindow()                                 ;[SS] notification window
  :X:v~win::               SoundSettings()                                      ;[SS] sound settings
  :X:r~win::               RunProgWindow()                                      ;[SS] run program
  :X:x~win::               StartContextMenu()                                   ;[SS] context menu for the Start button
  :X:k~win::               QuickConnectWindow()                                 ;[SS] quick connect window
  :X:i~win::               WindowsSettings()                                    ;[SS] windows settings
  :X:p~win::               PresentationDisplayMode()                            ;[SS] presentation display mode
  
; SYS COMMANDS _________________________________________________________________

  ^#!Left::    Send {ctrl down}{lwin down}{Left}{ctrl up}{lwin up}              ;[SC] switch desktop environments (Left)
  ^#!Right::   Send {ctrl down}{lwin down}{Right}{ctrl up}{lwin up}             ;[SC] switch desktop environments (Right)
  :X:s~~win::                                                                   ;[SC] enter sleep mode
  +^!del::     PowerOptions("sleep")                                            ;[SC] enter sleep mode
  :X:h~~win::                                                                   ;[SC] enter hybernate mode
  ^#!del::     PowerOptions("hybernate")                                        ;[SC] enter hybernate mode
  :X:sd~~win::                                                                  ;[SC] shutdown + power down 
  ^#!esc::     PowerOptions("shutdown")                                         ;[SC] shutdown + power down 
  :X:rs~~win::                                                                  ;[SC] restart the computer
  +^!esc::     PowerOptions("restart")                                          ;[SC] restart the computer
  :X:a~win::   Run assets\win\Alarms & Clock.lnk                                ;[SC] alarm clock
  :X:m~win::   sendEmail()                                                      ;[SC] send mail
  :X:ce~~win:: CloseAllPrograms()                                               ;[SC] close all open programs 
  :X:ss~win::  CloudSync("ON")                                                  ;[SC] turn on cloud sync 
  :X:qs~win::  CloudSync("OFF")                                                 ;[SC] turn off cloud sync
  :X:lt~win::  WinLLock(True)                                                   ;[SC] turn on win+L locks computer
  :X:lf~win::  WinLLock(False)                                                  ;[SC] turn off win+L locks computer
  :X:ap~win::  Run assets\win\Add Remove Programs.lnk                           ;[SC] open add remove programs 
  :X:s~win::                                                                    ;[SC] open start menu (alt: Ctrl+Esc)
  $^#Enter::   send ^{esc}                                                      ;[SC] open start menu (alt: Ctrl+Esc)
  :X:de~win::  send #{tab}                                                      ;[SC] desktop environment overview

; AHK RELATED __________________________________________________________________
 
  #capslock::                                                                   ;[AHK] disable original key functionality (for AHK modifier keys)
  !printscreen::                                                                ;[AHK] disable original key functionality (for AHK modifier keys)
  +printscreen::                                                                ;[AHK] disable original key functionality (for AHK modifier keys)
  #printscreen::                                                                ;[AHK] disable original key functionality (for AHK modifier keys)
  ^printscreen:: return                                                         ;[AHK] disable original key functionality (for AHK modifier keys)
 
  >+esc::       getMousePos()                                                   ;[AHK] display current mouse cursor coordinates in a tool tip
  :X:kh~win::   KeyHistory                                                      ;[AHK] open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;[AHK] open windows spy
  :X:ci~win::   EditFile("""" config_path """")                                 ;[AHK] edit config.ini file
  :X:tut~win::  loadURL("https://www.autohotkey.com/docs/Tutorial.htm")         ;[AHK] AHK beginner tutorial
  :X:cf~win::   TglSetting("cursor_follow", "Cursor follows active window: ")   ;[AHK] toggle mouse cursor follows active window
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_prfx")                           ;[AHK] store selected as label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sffx")                           ;[AHK] store selected as label suffix
  :X:cl~win::   CreateLabel("CL_prfx", "CL_sffx")                               ;[AHK] using selected text, create hotstring label with execution
  :X:!cl~win::  CreateLabel("!", "CL_sffx")                                     ;[AHK] using selected text, create normal label
 
  :X:gl~win::   GenerateHotkeyList()                                            ;[AHK] generate a list of hotkeys in working directory.
  :X:ls~win::   EditFile("HotKey_List.txt")                                     ;[AHK] open last generated list of hotstrings and hotkeys

  :X:q~~win::                                                                   ;[AHK] quit ahk script
  +^#q::        ExitApp                                                         ;[AHK] quit ahk script
     
  :X:rw~win::                                                                      
  lshift & rshift::
  rshift & lshift::
     Reload:                                                                     
     Reload                                               
     return                                               

; Dynamic Hotstring Creation ___________________________________________________
  
  /*** CreateHotstringSnippet() -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
    CreateHotstringSnippet() will create a .txt copy of selected text
    in the mem_cache folder that can be retrieved through dynamically created 
    hotstring (i.e., hotstring can be used immediately after creation). 
  
     — Python and R hotstring snippets are kept in separate folders which means the same
       hotstring name can be applied to a corresponding layer of abstraction. 
       For example, "scatter_plot" can be used in both python and R to output 
       language/library specific syntax for equivalent plotting code.
   
     — To see an index of hotstrings created through CreateHotstringSnippet() open 
       mem_cache/hotstring_creation_log.csv
  
     — FORMAT:
  
       1) First line of text will be transformed into the hotstring trigger string
          with a ">" character appended to the end.
       2) Second line will be transformed into a comment in the target .ahk file
       3) Third line should be the target text a user wants to store and later retrieve
  
     — EXAMPLE:
  
       hotstring_label
       comment/description of hotstring for hotkey_help.ahk indexing>
       text to store
  
       select above 3 lines and press insert & w to create a hotstring.
       Afterwards, typing "hotstring_label>" will output "text to store"  
  */
  
  
  :X:hs~win::          run %A_ScriptDir%\mem_cache\hotstring_creation_log.csv   ; open hotstring_creation_log.csv
  
  return
 
  :X:dpu~win:: clip("PopUp(" clip() ",,,,-2000)")                           ; debugging PopUp(selected)
  :X:~win~:: clip(":X:" clip() "~win:`:")                                       ; create hotstring key
  
  :X:chsw~win:: CreateHotstringSnippet("win_sys")                               ; create windows hotstring
  :X:chsr~win:: CreateHotstringSnippet("R")                                     ; create R programming hotstring
  :X:chsp~win:: CreateHotstringSnippet("Python")                                ; create python programming hotstring
 
  ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  :*:sck>::                                                                     ; sc key legend
  AccessCache("sck")
  return
  
  :*:3key>::                                                                    ; example of 3 button hotkey using &
  :*:3k>::                                                                      ; example of 3 button hotkey using &
  AccessCache("key3")
  return
 
  :*:test_ahk>::                                                                ; code for testing ahk code
  AccessCache("test_ahk")
  return
  
  :*:gc>::                                                                      ; favorite git commands
  AccessCache("gc")
  return
 
 