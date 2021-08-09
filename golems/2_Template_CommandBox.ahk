#IfWinActive

#enter:: CB("~win")                                                             ;win: opens command box that runs ~win suffix CB keys

; CB hotkey assignment _________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " ghwnd)                                                ; If command Box active

  !q::         MoveWin("TL")                                                    ; move CB window to top left
  !e::         MoveWin("TR")                                                    ; move CB window to top right
  !z::         MoveWin("BL")                                                    ; move CB window to bottom left
  !c::         MoveWin("BR")                                                    ; move CB window to bottom right
  !w::         MoveWin("T")                                                     ; move CB window to top half
  !s::         MoveWin("B")                                                     ; move CB window to bottom half
  #left::                                                                       ; move CB window to left half
  !a::         MoveWin("L")                                                     ; move CB window to left half
  #right::                                                                      ; move CB window to right half
  !d::         MoveWin("R")                                                     ; move CB window to right half
  #space::     GUISubmit()                                                      ; submit GUI input 
  !r::         GUIRecall()

  #IF WinExist("ahk_id " ghwnd)                                                 ; If command Box exists
  
  $<^space::                                                                    ; activate CB if exists and move focus to inputbox
  $>^space:: ActivateWin("ahk_id " ghwnd)                                       ; activate CB if exists and move focus to inputbox

  #IF                                                                           ; end context specific declarations

; CB key assignment: SYS SETTINGS ______________________________________________

  :X:b~win::   BluetoothSettings()                                              ;[SS] bluetooth settings
  :X:d~win::   DisplaySettings()                                                ;[SS] display settings
  :X:n~win::   NotificationWindow()                                             ;[SS] notification window
  :X:v~win::   SoundSettings()                                                  ;[SS] sound settings
  :X:r~win::   RunProgWindow()                                                  ;[SS] run program
  :X:x~win::   StartContextMenu()                                               ;[SS] context menu for the Start button
  :X:k~win::   QuickConnectWindow()                                             ;[SS] quick connect window
  :X:i~win::   WindowsSettings()                                                ;[SS] windows settings
  :X:p~win::   PresentationDisplayMode()                                        ;[SS] presentation display mode
  :X:s~~win::  PowerOptions("sleep")                                            ;[SC] enter sleep mode
  :X:h~~win::  PowerOptions("hybernate")                                        ;[SC] enter hybernate mode
  :X:sd~~win:: PowerOptions("shutdown")                                         ;[SC] shutdown + power down 
  :X:rs~~win:: PowerOptions("restart")                                          ;[SC] restart the computer
  :X:a~win::   Run assets\win\Alarms & Clock.lnk                                ;[SC] alarm clock
  :X:m~win::   sendEmail()                                                      ;[SC] send mail
  :X:ce~~win:: CloseAllPrograms()                                               ;[SC] close all open programs 
  :X:ss~win::  CloudSync("ON")                                                  ;[SC] turn on cloud sync 
  :X:qs~win::  CloudSync("OFF")                                                 ;[SC] turn off cloud sync
  :X:lt~win::  WinLLock(True)                                                   ;[SC] turn on win+L locks computer
  :X:lf~win::  WinLLock(False)                                                  ;[SC] turn off win+L locks computer
  :X:ap~win::  Run assets\win\Add Remove Programs.lnk                           ;[SC] open add remove programs 
  $^#Enter::                                                                    ;[SC] open start menu (alt: Ctrl+Esc)
  :X:s~win::   send ^{esc}                                                      ;[SC] open start menu (alt: Ctrl+Esc)

; CB keys assignment: AHK UTILITIES ____________________________________________

  :X:kh~win::   KeyHistory                                                      ;[AHK] open key history
  :X:ws~win::   run, C:\Program Files\AutoHotkey\WindowSpy.ahk                  ;[AHK] open windows spy
  :X:ci~win::   EditFile("""" config_path """")                                 ;[AHK] edit config.ini file
  :X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")                     ;[AHK] AHK beginner tutorial
  :X:cf~win::   TglSetting("cursor_follow", "Cursor follows active window: ")   ;[AHK] toggle mouse cursor follows active window
  ~+#left::                                                                     ;[AHK] cursor follows active window when moving apps btn monitors (if turned on)
  ~!tab::       CursorFollowWin()                                               ;[AHK] cursor follows active window when switch apps with alt+tab (if turned on)
  :X:clp~win::  WriteToINI(A_ComputerName, "CL_prfx")                           ;[AHK] store label prefix
  :X:cls~win::  WriteToINI(A_ComputerName, "CL_sffx")                           ;[AHK] store label suffix
  :X:cl~win::   CreateLabel("CL_prfx", "CL_sffx")                               ;[AHK] create hotstring label with execution option
  :X:!cl~win::  CreateLabel("!", "CL_sffx")                                     ;[AHK] create normal label
  :X:gl~win::   GenerateHotkeyList()                                            ;[AHK] generate a list of hotkeys in working directory.
  :X:ls~win::   EditFile("HotKey_List.txt")                                     ;[AHK] open last generated list of hotstrings and hotkeys
  :X:qw~~win::                                                                  ;[AHK] quit ahk script
  +^#r::        ExitApp                                                         ;[AHK] quit ahk script
  :X:rw~win::                                                                   ;[AHK] reload ahk script
  lshift & rshift::                                                             ;[AHK] reload ahk script
  rshift & lshift::      Reload                                                 ;[AHK] reload ahk script


  
#IfWinActive