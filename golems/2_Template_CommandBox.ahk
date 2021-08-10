#IfWinActive

  #space:: CB("~win")                                                           ; opens command box that runs ~win suffix CB keys

; CB hotkey assignment _________________________________________________________; shared by all Command Boxes 

  #IF WinActive("ahk_id " ghwnd) or TitleTest("(-_-)")                          ; If command Box active

  !q::          MoveWin("TL")                                                   ; move CB window to top left
  !e::          MoveWin("TR")                                                   ; move CB window to top right
  !z::          MoveWin("BL")                                                   ; move CB window to bottom left
  !c::          MoveWin("BR")                                                   ; move CB window to bottom right
  !w::          MoveWin("T")                                                    ; move CB window to top half
  !s::          MoveWin("B")                                                    ; move CB window to bottom half
  #left::                                                                       ; move CB window to left half
  !a::          MoveWin("L")                                                    ; move CB window to left half
  #right::                                                                      ; move CB window to right half
  !d::          MoveWin("R")                                                    ; move CB window to right half
  #space::      GUISubmit()                                                     ; submit GUI input 
  $!x::         ToggleDisplay()                                                 ; toggle Command Box display/minimalist mode
  !r::          GUIRecall()                                                     ; reenter last command

  #IF WinExist("ahk_id " ghwnd) and !WinActive("ahk_id " ghwnd)                 ; If command Box exists
  
  $<^space::                                                                    ; activate CB if exists and move focus to inputbox
  $>^space:: ActivateWin("ahk_id " ghwnd)                                       ; activate CB if exists and move focus to inputbox

  #IF                                                                           ; end context specific declarations

; CB key assignment: SYS SETTINGS ______________________________________________

  :X:b~win::    BluetoothSettings()                                             ;[SS] bluetooth settings
  :X:d~win::    DisplaySettings()                                               ;[SS] display settings
  :X:n~win::    NotificationWindow()                                            ;[SS] notification window
  :X:v~win::    SoundSettings()                                                 ;[SS] sound settings
  :X:r~win::    RunProgWindow()                                                 ;[SS] run program
  :X:x~win::    StartContextMenu()                                              ;[SS] context menu for the Start button
  :X:k~win::    QuickConnectWindow()                                            ;[SS] quick connect window
  :X:i~win::    WindowsSettings()                                               ;[SS] windows settings
  :X:p~win::    PresentationDisplayMode()                                       ;[SS] presentation display mode
  :X:s~~win::   PowerOptions("sleep")                                           ;[SC] enter sleep mode
  :X:h~~win::   PowerOptions("hybernate")                                       ;[SC] enter hybernate mode
  :X:sd~~win::  PowerOptions("shutdown")                                        ;[SC] shutdown + power down 
  :X:rs~~win::  PowerOptions("restart")                                         ;[SC] restart the computer
  :X:a~win::    Run assets\win\Alarms & Clock.lnk                               ;[SC] alarm clock
  :X:m~win::    sendEmail()                                                     ;[SC] send mail
  :X:ce~~win::  CloseAllPrograms()                                              ;[SC] close all open programs 
  :X:ss~win::   CloudSync("ON")                                                 ;[SC] turn on cloud sync 
  :X:qs~win::   CloudSync("OFF")                                                ;[SC] turn off cloud sync
  :X:lt~win::   WinLLock(True)                                                  ;[SC] turn on win+L locks computer
  :X:lf~win::   WinLLock(False)                                                 ;[SC] turn off win+L locks computer
  :X:ap~win::   Run assets\win\Add Remove Programs.lnk                          ;[SC] open add remove programs 
  $^#Enter::                                                                    ;[SC] open start menu (alt: Ctrl+Esc)
  :X:s~win::    send ^{esc}                                                     ;[SC] open start menu (alt: Ctrl+Esc)

; CB keys assignment: AHK UTILITIES ____________________________________________
  
  :X:ec~win::   OpenFolder("mem_cache\")                                        ;[AHK] open cache folder in file explorer
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
                                                                     
  lshift & rshift::                                                             ;[AHK] reload ahk script
  rshift & lshift::                                                             ;[AHK] reload ahk script
  :X:rw~win::   Reload                                                          ;[AHK] reload ahk script

; CHANGE FOLDER IN FILELISTERS _________________________________________________
  SetTitleMatchMode, 2
  #IfWinActive ahk_group FileListers                                            ;    ChangeFolders works in file explorer and open file + save as dialogue boxes
  
  >+sc029::     ChangeFolder(A_ScriptDir)                                       ;<F> AHK folder
  >+1::         ChangeFolder(A_ScriptDir "\golems\")                            ;<F> AHK golems folder
  >+2::         ChangeFolder(A_ScriptDir "\lib\")                               ;<F> AHK libs folder
  >+m::         ChangeFolder(A_ScriptDir "\mem_cache\")                         ;<F> mem_cache
  >+a::         ChangeFolder(A_ScriptDir "\assets\")                            ;<F> mem_cache
  >+c::         ChangeFolder(hdrive)                                            ;<F> %Homedrive% (C:)
  >+o::         ChangeFolder(A_ProgramFiles)                                    ;<F> C:\Program Files
  >+!o::        ChangeFolder(PF_x86)                                            ;<F> C:\Program Files(x86)
  >+u::         ChangeFolder(UProfile)                                          ;<F> %UserProfile%
  >+p::         ChangeFolder(UProfile "\Pictures\")                             ;<F> Pictures
  >+g::         ChangeFolder(UProfile "\Google Drive")                          ;<F> google drive
  >+j::         ChangeFolder(UProfile "\Downloads")                             ;<F> Downloads
  >+d::         ChangeFolder(UProfile "\Documents")                             ;<F> Documents
  >+r::         ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}")      ;<F> Recycle bin (doesn't work for save as diag)
  >+t::         ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")      ;<F> This PC / My Computer

#IfWinActive